//
//  ViewController.m
//  AlertProject
//
//  Created by Peter.Kang on 14-1-23.
//  Copyright (c) 2014年 Peter.Kang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"test"
                                                         ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile: htmlPath];
    NSString *info = [[NSString alloc] initWithData:data
                                           encoding:NSUTF8StringEncoding];
    [_webView loadHTMLString:info
                           baseURL:[NSURL fileURLWithPath: htmlPath]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
