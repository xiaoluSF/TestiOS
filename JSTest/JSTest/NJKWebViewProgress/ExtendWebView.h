//
//  ExtendWebView.h
//  travelAgency-iOS
//
//  Created by Jopool on 16/6/3.
//  Copyright © 2016年 Jopool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExtendWebView : NSObject

+(BOOL)didAnalysisWebUrl:(NSString *)Url WithCallback:(void(^)(BOOL success, NSString *body, NSDictionary *result))callback;


//url编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;
//url解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

@end
