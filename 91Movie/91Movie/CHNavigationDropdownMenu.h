//
//  CHNavigationDropdownMenu.h
//  91Movie
//
//  Created by feirui on 2018/7/20.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHNavigationDropdownMenu;

@protocol CHNavigationDropdownMenuDataSource <NSObject>

@required

- (NSArray<NSString *> *)titleArrayForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;


@optional

- (UIFont *)titleFontForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (UIColor *)titleColorForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (UIImage *)arrowImageForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (CGFloat)arrowPaddingForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (NSTimeInterval)animationDurationForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (BOOL)keepCellSelectionForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (CGFloat)cellHeightForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (UIEdgeInsets)cellSeparatorInsetsForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (NSTextAlignment)cellTextAlignmentForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (UIFont *)cellTextFontForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (UIColor *)cellTextColorForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (UIColor *)cellBackgroundColorForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;
- (UIColor *)cellSelectedColorForNavigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu;

@end


@protocol CHNavigationDropdownMenuDelegate <NSObject>


@required

- (void)navigationDropdownMenu:(CHNavigationDropdownMenu *)navigationDropdownMenu didSelectTitleAtIndex:(NSUInteger)index;

@end










@interface CHNavigationDropdownMenu : UIButton





@property (nonatomic, weak) id <CHNavigationDropdownMenuDataSource> dataSource;

@property (nonatomic, weak) id <CHNavigationDropdownMenuDelegate> delegate;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;




- (void)show;

- (void)hide;

















@end
