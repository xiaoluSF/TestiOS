//
//  Sub2ViewController.m
//  JSTest
//
//  Created by jopool on 2016/9/28.
//  Copyright © 2016年 jopool. All rights reserved.
//

#import "Sub2ViewController.h"

@interface Sub2ViewController ()

@end

@implementation Sub2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"sub2";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"%@",_productID);
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
