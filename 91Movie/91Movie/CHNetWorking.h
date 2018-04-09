//
//  CHNetWorking.h
//  91Movie
//
//  Created by 陈欢 on 2018/3/25.
//  Copyright © 2018年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHNetWorking : NSObject

+ (CHNetWorking *)shareManager;


- (void)getUrl:(NSString *)url withBlock:(void(^)(NSData *data, NSError *error))block;

@end
