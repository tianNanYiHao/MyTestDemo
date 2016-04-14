//
//  ViewController.m
//  DuoLaAMeng-test
//
//  Created by Aotu on 16/3/21.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"
#import "DuoLa A Meng.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"截图" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 100, 70);
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

}

//点击截图 且保存
-(void)click:(UIButton*)btn{
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
