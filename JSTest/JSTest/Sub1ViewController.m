//
//  Sub1ViewController.m
//  JSTest
//
//  Created by jopool on 2016/9/28.
//  Copyright © 2016年 jopool. All rights reserved.
//

#import "Sub1ViewController.h"
#import "INTUAnimationEngine.h"

#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, INTUAnimationProperty) {
    INTUAnimationPropertyMove   = 0,
    INTUAnimationPropertyScale  = 1,
    INTUAnimationPropertyRotate = 2,
};



@interface Sub1ViewController (){
    UIButton * allBtn;
    UIView * bottomView;
}
@property (nonatomic, assign) INTUAnimationProperty animationProperty;
@property (nonatomic, assign) INTUAnimationID animationID;


@end

@implementation Sub1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"sub1";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"%@",_orderID);
    [self setUpViews];
}

-(void)setUpViews{
    allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setFrame:CGRectMake((Screen_W - 100)/2, 64, 100, 100)];
    [allBtn setTitle:@"弹性按钮" forState:UIControlStateNormal];
    [allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [allBtn setBackgroundColor:[UIColor redColor]];
    [allBtn addTarget:self action:@selector(didClickTestBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allBtn];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_H , Screen_W, 100)];
    [bottomView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:bottomView];
}

-(void)resetDemoViewState{
    [bottomView setFrame:CGRectMake(0, Screen_H , Screen_W, 100)];
}

-(void)didClickTestBtn{
    [self resetDemoViewState];
    INTUAnimationProperty animationProperty = self.animationProperty;
    CGPoint moveStart = CGPointMake(bottomView.center.x, bottomView.center.y);
    CGPoint moveEnd = CGPointMake(bottomView.center.x, bottomView.center.y - 100);
    
    self.animationID = [INTUAnimationEngine animateWithDamping:20
                                                     stiffness:200
                                                          mass:1
                                                         delay:0
                                                    animations:^(CGFloat progress) {
                                                                        switch (animationProperty) {
                                                                            case INTUAnimationPropertyMove:
                                                                                bottomView.center = INTUInterpolateCGPoint(moveStart, moveEnd, progress);
                                                                                break;
                                                                                
                                                                            default:
                                                                                break;
                                                                        }
                                                                    } completion:^(BOOL finished) {
                                                                        
                                                                    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [INTUAnimationEngine cancelAnimationWithID:self.animationID];
    [UIView animateWithDuration:0.5 animations:^{
        [bottomView setFrame:CGRectMake(0, Screen_H , Screen_W, 100)];
    } completion:^(BOOL finished) {
        
    }];
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
