//
//  CHVideoControlView.h
//  91Movie
//
//  Created by 陈欢 on 2018/7/21.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHVideoControlView;


@protocol CHVideoControlViewDelegate <NSObject>


@required

- (void)controlView:(CHVideoControlView *)controlView pointSliderLocationWithCurrentValue:(CGFloat)value;

- (void)controlView:(CHVideoControlView *)controlView draggedPositionWithSlider:(UISlider *)slider;



-(void)controlView:(CHVideoControlView *)controlView withLargeButton:(UIButton *)button;


@end





@interface CHVideoControlView : UIView


//全屏按钮
@property (nonatomic,strong) UIButton *largeButton;
//进度条当前值
@property (nonatomic,assign) CGFloat value;
//最小值
@property (nonatomic,assign) CGFloat minValue;
//最大值
@property (nonatomic,assign) CGFloat maxValue;
//当前时间
@property (nonatomic,copy) NSString *currentTime;
//总时间
@property (nonatomic,copy) NSString *totalTime;
//缓存条当前值
@property (nonatomic,assign) CGFloat bufferValue;
//UISlider手势
@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;
//代理方法
@property (nonatomic,weak) id<CHVideoControlViewDelegate> delegate;


































@end
