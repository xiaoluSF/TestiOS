//
//  JSWebController.h
//  travelAgency-iOS
//
//  Created by Jopool on 16/8/30.
//  Copyright © 2016年 Jopool. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height

typedef void(^jsCall)(NSDictionary *result);
@interface JSWebController : UIViewController

@property(nonatomic,copy)NSString *webUrl;//链接
@property(nonatomic,copy)NSString *startTitle;//初始标题
@property(nonatomic,retain)UIImage *backImage;//返回按钮图片

-(void)refreshWebView;

///*********** 子类操作 ************
//添加js操作
-(void)addJSActionWithTitle:(NSString *)title withCall:(jsCall)jscall;

///*********** 子类实现 ************
//关闭页面(默认为出栈操作)
-(void)close;
//返回自己的拼串（默认使用webUrl）
-(NSString *)didGetLink;

@end
