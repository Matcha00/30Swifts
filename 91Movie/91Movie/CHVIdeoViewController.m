//
//  CHVIdeoViewController.m
//  91Movie
//
//  Created by 陈欢 on 2018/3/25.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "CHVIdeoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CHPronModel.h"
#import "CHNetWorking.h"
#import <TFHpple.h>
#import "CHPronVideoView.h"
@interface CHVIdeoViewController ()
@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *url;
@end

@implementation CHVIdeoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CHPronVideoView *pronVideo = [[CHPronVideoView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 200)];
     [self.view addSubview:pronVideo];
    //NSLog(@"%@",self.pron.showUrl);
    //*[@id="vid_html5_api"]/source
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[CHNetWorking shareManager]getUrl:self.pron.showUrl withBlock:^(NSData *data, NSError *error) {
            
            TFHpple *xpathHtml = [[TFHpple alloc]initWithHTMLData:data];
            
            NSArray *sourceHtml = [xpathHtml searchWithXPathQuery:@"//source"];
            NSString *hhhhh = [[NSString alloc]init];
            for (TFHppleElement *eee in sourceHtml) {
                
                NSString *videoUrl = [eee objectForKey:@"src"];
                hhhhh = videoUrl;
                //NSLog(@"%@",videoUrl);
                
                
                
            }
            
            //NSLog(@"%@", hhhhh);
            
            if (hhhhh) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    pronVideo.urlVideo = hhhhh;
                   
                    
                });
            }
            
          
            
//            if (hhhhh) {
//
//                NSURL *url = [NSURL URLWithString:hhhhh];
//                NSMutableDictionary * headers = [NSMutableDictionary dictionary];
//                [headers setObject:@"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"forKey:@"User-Agent"];
//                [headers setObject:@"zh-CN,zh;q=0.8,en;q=0.6" forKey:@"Accept-Language"];
//
//                AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:@{@"AVURLAssetHTTPHeaderFieldsKey" : headers}];
//
//
//                _item = [[AVPlayerItem alloc]initWithAsset:urlAsset];
//                _myPlayer = [[AVPlayer alloc]initWithPlayerItem:_item];
//                _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_myPlayer];
//                _playerLayer.frame = CGRectMake(0, 20, self.view.frame.size.width, 300);
//                _playerLayer.backgroundColor = [UIColor yellowColor].CGColor;
//                [self.view.layer addSublayer:_playerLayer];
//                [_myPlayer play];
            
           // }
            
            
            
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
           // [super viewWillAppear:animated];
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
            for (id obj in _tmpArray) {
                [cookieJar deleteCookie:obj];
            }

            
        }];
        
    });
    
    
    
    
                       
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
