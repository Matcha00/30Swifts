//
//  CHManyScrollVIew.h
//  CHManyScrollview
//
//  Created by 陈欢 on 2017/12/2.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHManyScrollVIewDelegate <NSObject>

- (void)buttonSelected: (NSInteger)index;

@end




@interface CHManyScrollVIew : UIView

@property (nonatomic, weak) id<CHManyScrollVIewDelegate> delegate;

- (instancetype)initViewWithButtonArray:(NSArray *)buttonArray chlidViewController:(NSArray <UIViewController *>*)chlidArray;


@end
