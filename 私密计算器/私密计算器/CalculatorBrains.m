//
//  CalculatorBrains.m
//  私密计算器
//
//  Created by 陈欢 on 2017/12/17.
//  Copyright © 2017年 陈欢. All rights reserved.
//

#import "CalculatorBrains.h"
@interface CalculatorBrains()

@property (nonatomic, strong) NSMutableArray *operandStack;

@end

@implementation CalculatorBrains

- (NSMutableArray *)operandStack {
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc]init];
    }
    
    return _operandStack;
}

- (NSInteger)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    
    return [operandObject doubleValue];
}

- (void) pushOperand:(NSInteger) operand {
    
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
}

- (void)clearStrack
{
    [self.operandStack removeAllObjects];
}

- (NSInteger)negateLastStackEntry
{
    NSInteger result = 0;
    
    result = -[self popOperand];
    
    [self pushOperand:result];
    
    return result;
}


- (NSInteger)performOperation:(NSString *)operation
{
    NSInteger result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    }else if ([operation isEqualToString:@"-"]) {
        result = [self popOperand] - [self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if(divisor)
            result = [self popOperand] / divisor;
        else
            result = 0;
    }
    
    [self pushOperand:result];
    
    return result;
}

- (NSInteger) pushTrigFuntion:(NSString *)operation
{
    NSInteger result = 0;
    
    if ([operation isEqualToString:@"Sin"]) {
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"Cos"]) {
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"Tan"]) {
        result = tan([self popOperand]);
    }
    
    [self pushOperand:result];
    
    return result;
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"stack = %@", self.operandStack];
}

































@end
