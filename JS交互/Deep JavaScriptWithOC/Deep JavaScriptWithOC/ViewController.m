//
//  ViewController.m
//  Deep JavaScriptWithOC
//
//  Created by Aotu on 16/4/28.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "ShowView.h"





@interface ViewController ()<UIWebViewDelegate,WebViewJavascriptBridgeBaseDelegate,UIAlertViewDelegate>
{
    UIWebView *_webview;
    
    

    
    
}
@property (nonatomic,strong) WebViewJavascriptBridge *bridge;
@property (nonatomic,strong) ShowView                *showView;
@property (nonatomic,strong) UILabel                 *lab;


@end

@implementation ViewController

-(ShowView*)showView{
    if (!_showView) {

    _showView = [[ShowView alloc] createWithFrame:CGRectMake(20, 500, self.view.frame.size.width-40, 60)  backGroundcolor:[UIColor lightGrayColor]];
    }
    return _showView;
    
}

-(UILabel*)lab{
    
    if (!_lab) {
        _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 60)];
        _lab.backgroundColor = [UIColor grayColor];
        _lab.font = [UIFont systemFontOfSize:13];
        _lab.textColor = [UIColor whiteColor];
        _lab.textAlignment = UITextAlignmentCenter;
        _lab.numberOfLines = 0;
        _lab.text = @"js还未回信!🐱";
        
    }
    return _lab;
    
}

-(void)loadHtmlintoWebview:(UIWebView*)webview{
    NSString *pathHtml = [[NSBundle mainBundle] pathForResource:@"changeString" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:pathHtml encoding:NSUTF8StringEncoding error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:pathHtml];
    [_webview loadHTMLString:htmlString baseURL:url];
    
    _webview.delegate = self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    
    [self setWebView];
    [self setButton];
    [self.view addSubview:self.showView];
    [self.showView addSubview:self.lab];
 
    
}

-(void)setWebView{
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-40)];
    [self loadHtmlintoWebview:_webview];
    [self.view addSubview:_webview];
 
    
    
    
    //开启调试信息
    [WebViewJavascriptBridge enableLogging];
    
    //关联webView
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webview];
    
    
    //点击js事件 js向oc通信(触发oc事件)
    [_bridge registerHandler:@"registerHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"datattatatatat=== %@",[NSString stringWithFormat:@"%@",data]);
        
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:nil message:@"js调用oc的按钮提示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        aler.tag = 100;
        
        [aler show];

    }];
    
    
    //点击js事件2 js向oc通信(触发oc事件)
    [_bridge registerHandler:@"registerHandler2" handler:^(id data, WVJBResponseCallback responseCallback) {
          self.lab.text = @"js改变了oc _lab的文字信息 🐱🐱🐱🐱";
    }];


    
}
-(void)setButton{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"oc的按钮,点击Btn ==> oc取得js反馈" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 600, self.view.frame.size.width-40, 30);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setTitle:@"oc按钮,点击Btn2 ==> oc向js发送且获得反馈" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(20, 650, self.view.frame.size.width-40, 30);
    btn2.backgroundColor = [UIColor cyanColor];
    [btn2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}
-(void)btnClick{
    
    //点击oc事件 js向oc反馈(js自身改变自身)

    [_bridge callHandler:@"callHandler" data:nil responseCallback:^(id responseData) {
        
        NSLog(@"jsShow =====Data====== %@",responseData);

        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.lab.text = [NSString stringWithFormat:@"btn 获得就是反馈 %@",responseData];
            
                
        });
        
    }];

    
    
}


-(void)btnClick2{
    
    
    id data = @{@"信息来源:":@"点击oc事件🐱,oc向js发送信息并得到js反馈"};
    [_bridge callHandler:@"callHandler" data:data responseCallback:^(id responseData) {
        NSLog(@"   =========  %@",responseData);
        self.lab.text = [NSString stringWithFormat:@"btn2 获得js反馈 %@",responseData];
    }];
    
    
}


//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    
//    JSContext *context = [_webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    //定义好JS要调用的方法, share就是调用的share方法名
//    context[@"????"] = ^() {
//        NSArray *args = [JSContext currentArguments];
//        for (JSValue *jsVal in args) {
//            NSLog(@"%@", jsVal.toString);
//          [NSString stringWithFormat:@"%@",jsVal.toString];
//        }
//
//        
//        NSLog(@"111111111111111");
//        
//        
//    };
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
