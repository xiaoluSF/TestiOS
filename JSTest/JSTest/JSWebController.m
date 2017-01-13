//
//  JSWebController.m
//  travelAgency-iOS
//
//  Created by Jopool on 16/8/30.
//  Copyright © 2016年 Jopool. All rights reserved.
//

#import "JSWebController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "ExtendWebView.h"

@interface JSWebController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>
{
    UIWebView *web;
    
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
    
    NSMutableDictionary *callDic;//js操作
}
@end

@implementation JSWebController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_webViewProgressView removeFromSuperview];
}

//刷新
-(void)refreshWebView{
    [web reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"链接";
    
    callDic = [NSMutableDictionary dictionary];
    
    [self didAddWebview];
    
    [self didAddLeftButtons];
    [self didAddRightButton];
}

//添加js操作
-(void)addJSActionWithTitle:(NSString *)title withCall:(jsCall)jscall{
    [callDic setObject:jscall forKey:title];
}


-(void)didAddLeftButtons{
    UIBarButtonItem *left1 = self.navigationItem.leftBarButtonItem;
    if (left1 != nil) {
        [left1 setAction:@selector(didBack)];
    }
    else{
        //设置返回按钮
        if (_backImage != nil) {
            UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
            butt.frame = CGRectMake(0, 0, 13, 22);
            [butt setImage:_backImage forState:UIControlStateNormal];
            [butt setImageEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
            [butt addTarget:self action:@selector(didBack) forControlEvents:UIControlEventTouchUpInside];
            left1 = [[UIBarButtonItem alloc]initWithCustomView:butt];
        }
        else{
            left1 = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didBack)];
        }
    }
    UIBarButtonItem *close = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.leftBarButtonItems = @[left1,close];
    
}
//左
-(void)didBack{
    if (![web canGoBack]) {
        [self close];
    }
    else{
        [web goBack];
    }
}
-(void)close{
    [self.navigationController popViewControllerAnimated:YES];
}

//右键编辑
-(void)didAddRightButton{
//    UIBarButtonItem *edit = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:EditImg] style:UIBarButtonItemStylePlain target:self action:@selector(didEdit)];
//    self.navigationItem.rightBarButtonItem = edit;
}


///************************ 添加web界面 *****************************
-(void)didAddProgressHUD{
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    web.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    CGRect navBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0,
                                 navBounds.size.height ,
                                 navBounds.size.width,
                                 2);
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    _webViewProgressView.progressBarView.backgroundColor = [UIColor greenColor];
    
    [self.navigationController.navigationBar addSubview:_webViewProgressView];
    
    [self didRequestWebview];
}

-(void)didAddWebview{
    BOOL isALL = self.navigationController.navigationBar.isTranslucent;//导航栏适应
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, isALL?Screen_H:Screen_H-64)];
    [web setBackgroundColor:[UIColor whiteColor]];
    web.delegate = self;
    [self.view addSubview:web];
    
    [self didAddProgressHUD];
}

-(void)didRequestWebview{
//    [self didLoadWebViewWithURL:[self didGetLink]];//正常情况下用
    [self didLoadWebViewWithStr:[self didGetLink]];//demo专用 因为要加载本地HTML文件
}

-(void)didLoadWebViewWithStr:(NSString *)url{
    [web loadHTMLString:url baseURL:nil];
}

-(void)didLoadWebViewWithURL:(NSString *)url{
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [web loadRequest:req];
}

///*********** 子类实现 ************
//获取拼串
-(NSString *)didGetLink{
    NSString *link = [NSString stringWithFormat:@"%@",_webUrl];
    
    return link;
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    self.title = [web stringByEvaluatingJavaScriptFromString:@"document.title"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //    self.title = [web stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self performSelector:@selector(resetTitle) withObject:nil afterDelay:1];
}

-(void)resetTitle{
    [_webViewProgressView setProgress:1 animated:YES];
    self.title = [web stringByEvaluatingJavaScriptFromString:@"document.title"];
}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    NSString *urlStr = [url absoluteString];
    _webUrl = [url absoluteString];
    
    BOOL ret = [ExtendWebView didAnalysisWebUrl:urlStr WithCallback:^(BOOL success, NSString *body, NSDictionary *result) {
        jsCall call = callDic[body];
        if (call) {
            call(result);
        }
    }];
    
    return ret;
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
