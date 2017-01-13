//
//  JSClassName.h
//  Jmall
//
//  Created by jopool on 2016/9/27.
//  Copyright © 2016年 jopool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSClassName : NSObject
//view为服务器给返回的view代码  返回的那个string是本地真正的类名
+(NSString *)getClassNameWithStr:(NSString *)view;

@end
