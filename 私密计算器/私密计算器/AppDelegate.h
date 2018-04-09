//
//  AppDelegate.h
//  私密计算器
//
//  Created by 陈欢 on 2017/12/17.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

