//
//  CHjiantou.m
//  aaaaaaaaa
//
//  Created by 陈欢 on 2018/1/24.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import "CHjiantou.h"

@implementation CHjiantou

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    
    
    UIColor *color = [UIColor redColor];
    
    
    
    UIBezierPath *pathLable = [UIBezierPath bezierPathWithRect:rect];
    
    
    
    [pathLable moveToPoint:CGPointMake(self.frame.size.width,0 )];
    
    [pathLable addLineToPoint:CGPointMake(self.frame.size.width - 20,self.frame.size.height * 0.5 )];
    
    [pathLable addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    
    pathLable.lineWidth = 1;
    pathLable.lineJoinStyle = kCGLineJoinMiter;
    [[UIColor whiteColor] setFill];
    [pathLable fill];
    
    [super drawRect:rect];
}

@end
