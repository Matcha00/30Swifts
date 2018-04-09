//
//  ViewController.m
//  TEst
//
//  Created by 陈欢 on 2018/3/21.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 100);
    [btn setTitle:@"ooooooooooo" forState:UIControlStateHighlighted];
    //UIColor *btn =   [btn titleColorForState:UIControlStateNormal];
    //[btn setAttributedTitle:@"iiii" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn.reversesTitleShadowWhenHighlighted = YES;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:btn];
    
    UIImage *image = [[UIImage alloc]init];
    UIImage *hhh = [UIImage imageWithContentsOfFile:@"oooo"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
