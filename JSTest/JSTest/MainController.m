//
//  MainController.m
//  JSTest
//
//  Created by jopool on 2016/9/28.
//  Copyright © 2016年 jopool. All rights reserved.
//

#import "MainController.h"
#import "Sub1ViewController.h"
#import "Sub2ViewController.h"
#import "Sub3ViewController.h"
#import "JsController.h"
#import "WebViewController.h"
#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height


@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"JS测试";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat t;
    NSString * s = [NSString stringWithFormat:@"%.2f",t];
    NSLog(@"%@",s);
    
    [self setUpLayout];
}

-(void)setUpLayout{
    
    for (NSInteger i = 0; i < 4; i ++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake((Screen_W - 200)/2, 100 + i * (50 + 30), 200, 50)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTag:i];
        switch (i) {
            case 0:
                [btn setBackgroundColor:[UIColor blueColor]];
                [btn setTitle:@"进入webView" forState:UIControlStateNormal];
                break;
            case 1:
                [btn setBackgroundColor:[UIColor grayColor]];
                [btn setTitle:@"正常跳转1" forState:UIControlStateNormal];
                break;
            case 2:
                [btn setBackgroundColor:[UIColor greenColor]];
                [btn setTitle:@"正常跳转2" forState:UIControlStateNormal];
                break;
            case 3:
                [btn setBackgroundColor:[UIColor cyanColor]];
                [btn setTitle:@"正常跳转3" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        
        [btn addTarget:self action:@selector(didClickToPush:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)didClickToPush:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
        {
//            JsController * jsCtrl = [[JsController alloc]init];
//            NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewDemo"
//                                                                  ofType:@"html"];
//            NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                            encoding:NSUTF8StringEncoding
//                                                               error:nil];
//            jsCtrl.webUrl = htmlCont;
            WebViewController * jsCtrl = [[WebViewController alloc]init];
            [self.navigationController pushViewController:jsCtrl animated:YES];
        }
            break;
        case 1:
        {
            Sub1ViewController * sub1Ctrl = [[Sub1ViewController alloc]init];
            [self.navigationController pushViewController:sub1Ctrl animated:YES];
        }
            break;
        case 2:
        {
            Sub2ViewController * sub2Ctrl = [[Sub2ViewController alloc]init];
            [self.navigationController pushViewController:sub2Ctrl animated:YES];
        }
            break;
        case 3:
        {
            Sub3ViewController * sub3Ctrl = [[Sub3ViewController alloc]init];
            [self.navigationController pushViewController:sub3Ctrl animated:YES];
        }
            break;
   
        default:
            break;
    }
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
