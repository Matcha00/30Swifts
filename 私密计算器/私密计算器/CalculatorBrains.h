//
//  CalculatorBrains.h
//  私密计算器
//
//  Created by 陈欢 on 2017/12/17.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrains : NSObject

- (void)pushOperand:(NSInteger) operand;

- (NSInteger)performOperation:(NSString *) operation;

- (NSInteger)pushTrigFuntion:(NSString *) operation;

- (void)clearStrack;

- (NSInteger)negateLastStackEntry;


@end
