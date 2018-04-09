//
//  ViewController.m
//  aaaaaaaaa
//
//  Created by 陈欢 on 2018/1/24.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "ViewController.h"
#import "CHjiantou.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CHjiantou *lllll = [[CHjiantou alloc]initWithFrame:CGRectMake(100, 50, 100, 20)];
    //lllll.backgroundColor = [UIColor yellowColor];
    lllll.text = @"lllll";
    [self.view addSubview:lllll];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
