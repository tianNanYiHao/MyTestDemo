//
//  ViewController.h
//  AlertProject
//
//  Created by Peter.Kang on 14-1-23.
//  Copyright (c) 2014年 Peter.Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebView+Alert.h"

@interface ViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
