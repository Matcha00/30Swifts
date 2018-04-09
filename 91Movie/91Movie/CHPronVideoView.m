//
//  CHPronVideoView.m
//  91Movie
//
//  Created by 陈欢 on 2018/3/31.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "CHPronVideoView.h"
#import <AVFoundation/AVFoundation.h>

@interface CHPronVideoView()

@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerItem *avPlayerItem;


@end
@implementation CHPronVideoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
        [self setupVideoView];
        
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
    
     NSURL *url = [NSURL URLWithString:self.urlVideo];
    NSMutableDictionary * headers = [NSMutableDictionary dictionary];
    [headers setObject:@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"forKey:@"User-Agent"];
    [headers setObject:@"zh-CN,zh;q=0.8,en;q=0.6" forKey:@"Accept-Language"];
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:@{@"AVURLAssetHTTPHeaderFieldsKey" : headers}];
    
    
    self.avPlayerItem = [[AVPlayerItem alloc]initWithAsset:urlAsset];
    self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:self.avPlayerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.frame = self.bounds;
    self.avPlayerLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:self.avPlayerLayer];
    [self.avPlayer play];
}

- (void)setUrlVideo:(NSString *)urlVideo
{
    _urlVideo = urlVideo;
    
    NSURL *url = [NSURL URLWithString:urlVideo];
    NSMutableDictionary * headers = [NSMutableDictionary dictionary];
    [headers setObject:@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"forKey:@"User-Agent"];
    [headers setObject:@"zh-CN,zh;q=0.8,en;q=0.6" forKey:@"Accept-Language"];
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:@{@"AVURLAssetHTTPHeaderFieldsKey" : headers}];
    
    
    self.avPlayerItem = [[AVPlayerItem alloc]initWithAsset:urlAsset];
    self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:self.avPlayerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.avPlayerLayer.frame = self.bounds;
    self.avPlayerLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:self.avPlayerLayer];
    [self.avPlayer play];
    
}











@end
