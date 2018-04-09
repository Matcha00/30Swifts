//
//  CHManyScrollVIew.m
//  CHManyScrollview
//
//  Created by 陈欢 on 2017/12/2.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CHManyScrollVIew.h"
#import "UIView+CHExtension.h"

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height


@interface CHManyScrollVIew()

@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation CHManyScrollVIew

- (instancetype)initViewWithButtonArray:(NSArray *)buttonArray chlidViewController:(NSArray<UIViewController *> *)chlidArray
{
    self = [super initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 120)];
    
    if (!buttonArray | !chlidArray) {
        
        return nil;
    }
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.bgView = bgView;
    [self addSubview:bgView];

    
    UIView *indicatorView = [[UIView alloc] init];
    
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = 1;
    indicatorView.y = bgView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    
    CGFloat width = bgView.width / buttonArray.count;
    CGFloat height = bgView.height;
    
    for (NSInteger i = 0; i<buttonArray.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        
        button.tag  = i;
        button.width = width;
        button.height = height;
        button.x = i * width;
        
        [button setTitle:buttonArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
         [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            /**
             *  让按钮内部lable根据文字内容计算尺寸
             */
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.center.x;
        }

        
        

    }
    
    
    
    
    
    
    return self;
}


- (void)titleClick:(UIButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        //CHLog(@"%@",NSStringFromCGRect(self.indicatorView.frame));
        
        
        
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
        
    }];
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag *self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}



@end
