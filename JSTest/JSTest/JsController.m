//
//  JsController.m
//  Jmall
//
//  Created by jopool on 2016/9/27.
//  Copyright © 2016年 jopool. All rights reserved.
//

#import "JsController.h"
#import <objc/runtime.h>
#import "JSClassName.h"
@interface JsController ()

@end

@implementation JsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    //操作是页面跳转
    [self addJSActionWithTitle:@"gotoView" withCall:^(NSDictionary *result) {
        if (result[@"view"]) {
            //根据事先跟服务器商量好的协议 取result里边的view的类名来实例化一个UIviewController
            NSString * str = [JSClassName getClassNameWithStr:result[@"view"]];
            Class someClass = NSClassFromString(str);
            UIViewController *vc = [[someClass alloc] init];//实例化一个类
            
            //遍历字典 除去View之后，看一下这个字典里的key是否和本地属性的名字一样，如果一样给这个属性赋值。
            [result enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                //服务器返回里边还有一个类名，所以不参与属性赋值
                if (![key isEqualToString:result[@"view"]]) {
                    //遍历这个类的所有属性
                    for (NSString * classStr in [weakSelf propertyKeysWithClass:someClass]) {
                        //如果这个属性跟服务器返回的key一样，那么就给这个类赋值为服务器返回的value
                        if ([classStr isEqualToString:key]) {
                            //给属性赋值
                            [vc setValue:obj forKey:classStr];
                        }
                    }
                }
            }];
            //最后跳转
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
}

//获取一个控制器对象下边所有的属性
- (NSArray*)propertyKeysWithClass:(Class)vc{
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([vc class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
