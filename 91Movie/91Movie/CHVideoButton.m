//
//  CHVideoButton.m
//  91Movie
//
//  Created by 陈欢 on 2018/7/21.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "CHVideoButton.h"
#import "UIView+ZHNFirework.h"
@interface CHVideoButton()


//@property (nonatomic, assign) BOOL isPlay;

@end
@implementation CHVideoButton

/*
 
 
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupPauseOrPlayView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (instancetype)initPauseOrPlayView
{
    self = [CHVideoButton buttonWithType:UIButtonTypeCustom];
    
    if (self) {
        [self setupPauseOrPlayView];
    }
    
    return self;
}


- (void)setupPauseOrPlayView
{
    [self setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    
    [self setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    
    
    [self addTarget:self action:@selector(pauseOrPlay) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pauseOrPlay
{
    self.selected = !self.selected;
    
    [self fireInTheHole];
    //self.isPlay = self.isSelected ? YES : NO;
    
    if ([self.delegate respondsToSelector:@selector(pauseOrPlayView:withState:)]) {
        [self.delegate pauseOrPlayView:self withState:self.isSelected];
    }
}








@end
