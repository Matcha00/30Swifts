//
//  CHVideoButton.h
//  91Movie
//
//  Created by 陈欢 on 2018/7/21.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@class CHVideoButton;

@protocol CHVideoButtonDelegate <NSObject>

@required

- (void)pauseOrPlayView:(CHVideoButton *)pauseOrPlayView withState:(BOOL)state;







@end


@interface CHVideoButton : UIButton

@property (nonatomic, weak) id<CHVideoButtonDelegate> delegate;


- (instancetype)initPauseOrPlayView;

@end
