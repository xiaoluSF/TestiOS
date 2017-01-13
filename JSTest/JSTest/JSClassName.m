//
//  JSClassName.m
//  Jmall
//
//  Created by jopool on 2016/9/27.
//  Copyright © 2016年 jopool. All rights reserved.
//

#import "JSClassName.h"

@implementation JSClassName

+(NSString *)getClassNameWithStr:(NSString *)view{
    
    NSDictionary * dict = @{@"JSTest_1":@"Sub1ViewController",
                            @"JSTest_2":@"Sub2ViewController",
                            @"JSTest_3":@"Sub3ViewController",};
    return dict[view];
}


@end
