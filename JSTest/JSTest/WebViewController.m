//
//  WebViewController.m
//  JSTest
//
//  Created by jopool on 2016/10/20.
//  Copyright © 2016年 jopool. All rights reserved.
//

#import "WebViewController.h"

#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height

@interface WebViewController ()<UIWebViewDelegate>{
    UIWebView * web;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"webView"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    [web setScalesPageToFit:YES];
    web.delegate = self;
    [self.view addSubview:web];
    
//    NSURLRequest * r = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"jmall:"]];
//    [web loadRequest:r];
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithTitle:@"查看" style:UIBarButtonItemStylePlain target:self action:@selector(didClickbarbtn)];
    [self.navigationItem setRightBarButtonItem:btn];
    
}

-(void)didClickbarbtn{
    UIAlertController * alterCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * act1 = [UIAlertAction actionWithTitle:@"PDF" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURLRequest * r = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://jbrain.jopool.com/files//8a2e37bc587150be015871535b7d12ec/uploadfile/xclj.pdf"]];
        [web loadRequest:r];
    }];
    UIAlertAction * act2 = [UIAlertAction actionWithTitle:@"DOCX" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURLRequest * r = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://jbrain.jopool.com/files//8a2e37bc587150be015871535b7d12ec/uploadfile/phpframework.docx"]];
        [web loadRequest:r];
    }];
    UIAlertAction * act3 = [UIAlertAction actionWithTitle:@"xlsx" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURLRequest * r = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://jbrain.jopool.com/files//8a2e37bc587150be015871535b7d12ec/uploadfile/fubushi.xlsx"]];
        [web loadRequest:r];

    }];
    UIAlertAction * act4 = [UIAlertAction actionWithTitle:@"PPTX" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURLRequest * r = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://jbrain.jopool.com/files//8a2e37bc587150be015871535b7d12ec/uploadfile/111.pptx"]];
        [web loadRequest:r];
    }];

    [alterCtrl addAction:act1];
    [alterCtrl addAction:act2];
    [alterCtrl addAction:act3];
    [alterCtrl addAction:act4];
    [self presentViewController:alterCtrl animated:YES completion:nil];

//    [self loadDocument:@"fubushi.xlsx" inView:web];
}

-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    
    NSString *HTMLSource = [web stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
    
    NSLog(@"***************%@",HTMLSource);
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
