//
//  CHPronVideoView.m
//  91Movie
//
//  Created by 陈欢 on 2018/3/31.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "CHPronVideoView.h"
//#import <AVFoundation/AVFoundation.h>
#import "CHVideoButton.h"
#import "CHVideoControlView.h"

static NSInteger count = 0;

@interface CHPronVideoView() <CHVideoControlViewDelegate,CHVideoButtonDelegate,UIGestureRecognizerDelegate>
{
    id playbackTimerObserver;
}

@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerItem *avPlayerItem;
@property (nonatomic, strong) AVURLAsset *urlAsset;
@property (nonatomic, strong) CHVideoButton *pauseOrPlayView;
@property (nonatomic, strong) CHVideoControlView *controlView;
//加载动画
@property (nonatomic,strong) UIActivityIndicatorView *activityIndeView;

//添加标题
@property (nonatomic,strong) UILabel *titleLabel;
@end
@implementation CHPronVideoView


//FIXME: Tracking time,跟踪时间的改变
-(void)addPeriodicTimeObserver{
    __weak typeof(self) weakSelf = self;
    playbackTimerObserver = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.f, 1.f) queue:NULL usingBlock:^(CMTime time) {
        weakSelf.controlView.value = weakSelf.avPlayerItem.currentTime.value/weakSelf.avPlayerItem.currentTime.timescale;
        if (!CMTIME_IS_INDEFINITE(self.urlAsset.duration)) {
            weakSelf.controlView.currentTime = [weakSelf convertTime:weakSelf.controlView.value];
        }
        if (count >= 5) {
            [weakSelf setSubViewsIsHide:YES];
        }else{
            [weakSelf setSubViewsIsHide:NO];
        }
        count += 1;
    }];
}
-(void)setSubViewsIsHide:(BOOL)isHide{
    self.controlView.hidden = isHide;
    self.pauseOrPlayView.hidden = isHide;
    self.titleLabel.hidden = isHide;
}
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}
//TODO: KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus itemStatus = [[change objectForKey:NSKeyValueChangeNewKey]integerValue];
        
        switch (itemStatus) {
            case AVPlayerItemStatusUnknown:
            {
                _status = CHPlayerStatusUnknown;
                NSLog(@"AVPlayerItemStatusUnknown");
            }
                break;
            case AVPlayerItemStatusReadyToPlay:
            {
                _status = CHPlayerStatusReadyToPlay;
                NSLog(@"AVPlayerItemStatusReadyToPlay");
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                _status = CHPlayerStatusFailed;
                NSLog(@"AVPlayerItemStatusFailed");
            }
                break;
            default:
                break;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  //监听播放器的下载进度
        NSArray *loadedTimeRanges = [self.avPlayerItem loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
        CMTime duration = self.avPlayerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //缓存值
        self.controlView.bufferValue=timeInterval / totalDuration;
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) { //监听播放器在缓冲数据的状态
        _status = CHPlayerStatusBuffering;
        if (!self.activityIndeView.isAnimating) {
            [self.activityIndeView startAnimating];
        }
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        NSLog(@"缓冲达到可播放");
        [self.activityIndeView stopAnimating];
    } else if ([keyPath isEqualToString:@"rate"]){//当rate==0时为暂停,rate==1时为播放,当rate等于负数时为回放
        if ([[change objectForKey:NSKeyValueChangeNewKey]integerValue]==0) {
            _isPlaying=false;
            _status = CHPlayerStatusPlaying;
        }else{
            _isPlaying=true;
            _status = CHPlayerStatusStopped;
        }
    }
    
}
//添加KVO
-(void)addKVO{
    //监听状态属性
    [self.avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监听网络加载情况属性
    [self.avPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //监听播放的区域缓存是否为空
    [self.avPlayerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //缓存可以播放的时候调用
    [self.avPlayerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    //监听暂停或者播放中
    [self.avPlayer addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
}
//MARK:添加消息中心
-(void)addNotificationCenter{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SBPlayerItemDidPlayToEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}
//MARK: NotificationCenter
-(void)SBPlayerItemDidPlayToEndTimeNotification:(NSNotification *)notification{
    [self.avPlayerItem seekToTime:kCMTimeZero];
    [self setSubViewsIsHide:NO];
    count = 0;
    [self pause];
    [self.pauseOrPlayView setSelected:NO];
    
}

-(void)willResignActive:(NSNotification *)notification{
    if (_isPlaying) {
        [self setSubViewsIsHide:NO];
        count = 0;
        [self pause];
        [self.pauseOrPlayView setSelected:NO];
    }
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}
- (void)drawRect:(CGRect)rect {
    [self setupPlayerUI];
}
//MARK: 设置界面 在此方法下面可以添加自定义视图，和删除视图
-(void)setupPlayerUI{
    [self.activityIndeView startAnimating];
    //添加标题
    [self addTitle];
    //添加点击事件
    [self addGestureEvent];
    //添加播放和暂停按钮
    [self addPauseAndPlayBtn];
    //添加控制视图
    [self addControlView];
    //添加加载视图
    [self addLoadingView];
    //初始化时间
    [self initTimeLabels];
}
//初始化时间
-(void)initTimeLabels{
    self.controlView.currentTime = @"00:00";
    self.controlView.totalTime = @"00:00";
}
//添加加载视图
-(void)addLoadingView{
    [self addSubview:self.activityIndeView];
    [self.activityIndeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@80);
        make.center.mas_equalTo(self);
    }];
}
//添加标题
-(void)addTitle{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(12);
        make.width.mas_equalTo(self.mas_width);
    }];
}
//添加点击事件
-(void)addGestureEvent{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}
-(void)handleTapAction:(UITapGestureRecognizer *)gesture{
    [self setSubViewsIsHide:NO];
    count = 0;
}
//添加播放和暂停按钮
-(void)addPauseAndPlayBtn{
    [self addSubview:self.pauseOrPlayView];
    [self.pauseOrPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}
//添加控制视图
-(void)addControlView{
    
    [self addSubview:self.controlView];
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(@44);
    }];
    [self layoutIfNeeded];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =  [super initWithFrame:frame]) {
        
        //[self setupVideoView];
        
    }
    
    return self;
}


- (instancetype)init
{
    if (self = [super init]) {
        //[self setupVideoView];
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupVideoView];
        
    }
    
    return self;
}


- (void)setupVideoView
{
    
//     NSURL *url = [NSURL URLWithString:self.urlVideo];
//    NSMutableDictionary * headers = [NSMutableDictionary dictionary];
//    [headers setObject:@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"forKey:@"User-Agent"];
//    [headers setObject:@"zh-CN,zh;q=0.8,en;q=0.6" forKey:@"Accept-Language"];
//
//    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:@{@"AVURLAssetHTTPHeaderFieldsKey" : headers}];
//
//
//    self.avPlayerItem = [[AVPlayerItem alloc]initWithAsset:urlAsset];
//    self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:self.avPlayerItem];
//    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
//    self.avPlayerLayer.frame = self.bounds;
//    self.avPlayerLayer.backgroundColor = [UIColor yellowColor].CGColor;
//    [self addPeriodicTimeObserver];
//    //添加KVO
//    [self addKVO];
//    //添加消息中心
//    [self addNotificationCenter];
//    [self.layer addSublayer:self.avPlayerLayer];
//    self.avPlayerLayer.frame = self.bounds;
//    self.avPlayerLayer.backgroundColor = [UIColor yellowColor].CGColor;
//    [self.avPlayer play];
}
//FIXME: set
- (void)setUrlVideo:(NSString *)urlVideo
{
    _urlVideo = urlVideo;
    
    NSURL *url = [NSURL URLWithString:urlVideo];
    NSMutableDictionary * headers = [NSMutableDictionary dictionary];
    [headers setObject:@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"forKey:@"User-Agent"];
    [headers setObject:@"zh-CN,zh;q=0.8,en;q=0.6" forKey:@"Accept-Language"];

    self.urlAsset = [AVURLAsset URLAssetWithURL:url options:@{@"AVURLAssetHTTPHeaderFieldsKey" : headers}];

    NSArray *keys = @[@"duration"];
    
    [self.urlAsset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus tracksStatus = [self.urlAsset statusOfValueForKey:@"duration" error:&error];
        switch (tracksStatus) {
            case AVKeyValueStatusLoaded:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!CMTIME_IS_INDEFINITE(self.urlAsset.duration)) {
                        CGFloat second = self.urlAsset.duration.value / self.urlAsset.duration.timescale;
                        self.controlView.totalTime = [self convertTime:second];
                        self.controlView.minValue = 0;
                        self.controlView.maxValue = second;
                    }
                });
            }
                break;
            case AVKeyValueStatusFailed:
            {
                //NSLog(@"AVKeyValueStatusFailed失败,请检查网络,或查看plist中是否添加App Transport Security Settings");
            }
                break;
            case AVKeyValueStatusCancelled:
            {
                NSLog(@"AVKeyValueStatusCancelled取消");
            }
                break;
            case AVKeyValueStatusUnknown:
            {
                NSLog(@"AVKeyValueStatusUnknown未知");
            }
                break;
            case AVKeyValueStatusLoading:
            {
                NSLog(@"AVKeyValueStatusLoading正在加载");
            }
                break;
        }
    }];
    self.avPlayerItem = [[AVPlayerItem alloc]initWithAsset:self.urlAsset];
    self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:self.avPlayerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.avPlayerLayer.frame = self.bounds;
    self.avPlayerLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.avPlayerLayer];
    [self.layer displayIfNeeded];
    [self.avPlayer play];
    [self.pauseOrPlayView setSelected:YES];;
    [self addPeriodicTimeObserver];
    //添加KVO
    [self addKVO];
    //添加消息中心
    [self addNotificationCenter];
}

#pragma mark lazy

//- (AVURLAsset *)urlAsset
//{
//    if (!_urlAsset) {
//
//        NSURL *url = [NSURL URLWithString:self.urlVideo];
//        NSMutableDictionary * headers = [NSMutableDictionary dictionary];
//        [headers setObject:@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"forKey:@"User-Agent"];
//        [headers setObject:@"zh-CN,zh;q=0.8,en;q=0.6" forKey:@"Accept-Language"];
//        _urlAsset = [AVURLAsset URLAssetWithURL:url options:@{@"AVURLAssetHTTPHeaderFieldsKey" : headers}];
//    }
//    return _urlAsset;
//}
//
//
//- (AVPlayerItem *)avPlayerItem
//{
//    if (!_avPlayerItem) {
//        _avPlayerItem = [[AVPlayerItem alloc]initWithAsset:self.urlAsset];
//    }
//    return _avPlayerItem;
//}
//
//
//
//
//- (AVPlayer *)avPlayer
//{
//    if (!_avPlayer) {
//        _avPlayer = [AVPlayer playerWithPlayerItem:self.avPlayerItem];
//    }
//    return _avPlayer;
//}







//- (AVPlayerLayer *)avPlayerLayer
//{
//    if (!_avPlayerLayer) {
//        _avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
//         _avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        _avPlayerLayer.frame = self.bounds;
//         _avPlayerLayer.backgroundColor = [UIColor blackColor].CGColor;
//    }
//    return _avPlayerLayer;
//}


//懒加载暂停或者播放视图
-(CHVideoButton *)pauseOrPlayView{
    if (!_pauseOrPlayView) {
        _pauseOrPlayView = [[CHVideoButton alloc]init];
        _pauseOrPlayView.backgroundColor = [UIColor clearColor];
        _pauseOrPlayView.delegate = self;
    }
    return _pauseOrPlayView;
}
//懒加载控制视图
-(CHVideoControlView *)controlView{
    if (!_controlView) {
        _controlView = [[CHVideoControlView alloc]init];
        _controlView.delegate = self;
        _controlView.backgroundColor = [UIColor clearColor];
        [_controlView.tapGesture requireGestureRecognizerToFail:self.pauseOrPlayView.gestureRecognizers.firstObject];
    }
    return _controlView;
}

-(CGFloat)rate{
    return self.avPlayer.rate;
}
-(void)setRate:(CGFloat)rate{
    self.avPlayer.rate = rate;
}
-(void)setMode:(CHLayerVideoGravity)mode{
    switch (mode) {
        case CHLayerVideoGravityResizeAspect:
            self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
            break;
        case CHLayerVideoGravityResizeAspectFill:
            self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            break;
        case CHLayerVideoGravityResize:
            self.avPlayerLayer.videoGravity = AVLayerVideoGravityResize;
            break;
    }
}

-(void)play{
    if (self.avPlayer) {
        [self.avPlayer play];
    }
}
-(void)pause{
    if (self.avPlayer) {
        [self.avPlayer pause];
    }
}
-(void)stop{
    [self.avPlayerItem removeObserver:self forKeyPath:@"status"];
    [self.avPlayer removeTimeObserver:playbackTimerObserver];
    [self.avPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.avPlayer removeObserver:self forKeyPath:@"rate"];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    if (self.avPlayer) {
        [self pause];
        self.urlAsset = nil;
        self.avPlayerItem = nil;
        self.controlView.value = 0;
        self.controlView.currentTime = @"00:00";
        self.controlView.totalTime = @"00:00";
        self.avPlayer = nil;
        self.activityIndeView = nil;
        [self removeFromSuperview];
    }
}

//MARK: SBPauseOrPlayViewDeleagate
-(void)pauseOrPlayView:(CHVideoButton *)pauseOrPlayView withState:(BOOL)state{
    count = 0;
    if (state) {
        [self play];
    }else{
        [self pause];
    }
}
//MARK: SBControlViewDelegate


- (void)controlView:(CHVideoControlView *)controlView pointSliderLocationWithCurrentValue:(CGFloat)value
{
    count = 0;
    CMTime pointTime = CMTimeMake(value * self.avPlayerItem.currentTime.timescale, self.avPlayerItem.currentTime.timescale);
    [self.avPlayerItem seekToTime:pointTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

-(void)controlView:(CHVideoControlView *)controlView draggedPositionWithSlider:(UISlider *)slider{
    count = 0;
    CMTime pointTime = CMTimeMake(controlView.value * self.avPlayerItem.currentTime.timescale, self.avPlayerItem.currentTime.timescale);
    [self.avPlayerItem seekToTime:pointTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
-(void)controlView:(CHVideoControlView *)controlView withLargeButton:(UIButton *)button{
//    count = 0;
//    if (kScreenWidth<kScreenHeight) {
//        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
//    }else{
//        [self interfaceOrientation:UIInterfaceOrientationPortrait];
//    }
}


- (void)dealloc
{
    
     NSLog(@"--- %@ --- 销毁了",[self class]);
    [self pause];
    [self.avPlayerItem removeObserver:self forKeyPath:@"status"];
    [self.avPlayer removeTimeObserver:playbackTimerObserver];
    [self.avPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.avPlayer removeObserver:self forKeyPath:@"rate"];
    //[self.avPlayer removeTimeObserver:playbackTimerObserver];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    if (self.avPlayer) {
        [self.avPlayer pause];
        [self.avPlayer cancelPendingPrerolls];
        
        self.urlAsset = nil;
        self.avPlayerItem = nil;
        self.controlView.value = 0;
        self.controlView.currentTime = @"00:00";
        self.controlView.totalTime = @"00:00";
        self.avPlayer = nil;
        self.activityIndeView = nil;
        [self removeFromSuperview];
    }
    
   
        [self.avPlayerLayer removeFromSuperlayer];
    
}


@end
