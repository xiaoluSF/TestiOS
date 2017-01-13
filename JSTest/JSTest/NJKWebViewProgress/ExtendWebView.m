//
//  ExtendWebView.m
//  travelAgency-iOS
//
//  Created by Jopool on 16/6/3.
//  Copyright © 2016年 Jopool. All rights reserved.
//

#import "ExtendWebView.h"

@implementation ExtendWebView

+(BOOL)didAnalysisWebUrl:(NSString *)Url WithCallback:(void(^)(BOOL success, NSString *body, NSDictionary *result))callback{
    NSString *head = [Url substringToIndex:5];
    if ([head isEqualToString:@"local"]) {
        if ([Url containsString:@"?"]) {
            NSArray *arr1 = [Url componentsSeparatedByString:@"//"];
            if ([arr1[1] containsString:@"?"]) {
                NSArray *arr2 = [arr1[1] componentsSeparatedByString:@"?"];
                NSString *bodystr = arr2[0];
                
                NSDictionary *dic = [self didGetDateWithSubStr:arr2[1]];
                callback(YES,bodystr,dic);
            }
            else{
                NSString *bodystr = arr1[1];
                callback(YES,bodystr,nil);
            }
        }
        else{
            callback(YES,nil,nil);
        }
        return NO;
    }
    else{
        callback(NO,nil,nil);
        return YES;
    }
}

+(NSMutableDictionary *)didGetDateWithSubStr:(NSString *)subStr{
    NSMutableDictionary *date = [NSMutableDictionary dictionary];
    NSArray *arr = [subStr componentsSeparatedByString:@"&"];
    for (NSString *kvStr in arr) {
        if ([kvStr containsString:@"="]) {
            NSArray *arr1 = [kvStr componentsSeparatedByString:@"="];
            [date setObject:arr1[1] forKey:arr1[0]];
        }
        else{
            [date setObject:@"" forKey:kvStr];
        }
    }
    
    return date;
}

//url编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString*
    outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                             
                                                                             NULL, /* allocator */
                                                                             
                                                                             (__bridge CFStringRef)input,
                                                                             
                                                                             NULL, /* charactersToLeaveUnescaped */
                                                                             
                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                             
                                                                             kCFStringEncodingUTF8);
    
    
    return
    outputStr;
}
//url解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,
                                                      [outputStr length])];
    
    return
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
