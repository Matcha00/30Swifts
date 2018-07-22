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
@property (nonatomic, strong) CHPronVideoView *video;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSString *url;
@end

@implementation CHVIdeoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
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
                    
                    self.video = [[CHPronVideoView alloc]initWithFrame:CGRectMake(0, self.view.center.y - 44, [UIScreen mainScreen].bounds.size.width, 200)];
                    self.video.urlVideo = hhhhh;
                    NSLog(@"hhhhhhh%@", hhhhh);
                    [self.view addSubview:self.video];
                    
                   
                    
                });
            }
            
          
            

            
            
            
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
   // [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)dealloc
{
    [self.video stop] ;
}

@end
