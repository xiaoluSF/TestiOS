//
//  Sub3ViewController.m
//  JSTest
//
//  Created by jopool on 2016/9/28.
//  Copyright © 2016年 jopool. All rights reserved.
//

#import "Sub3ViewController.h"

@interface Sub3ViewController ()

@end

@implementation Sub3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"sub3";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"%@",_userID);
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
