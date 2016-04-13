//
//  ViewController.m
//  changeVIewControllerSize
//
//  Created by Aotu on 16/4/12.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
@interface ViewController ()
{
    FirstViewController *f ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"1111";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    

    //.关闭导航栏透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];   //
    
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];    //
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"加" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    
    self.navigationItem.rightBarButtonItem = item;

    f = [[FirstViewController alloc] init];
    
}
-(void)add{
    
    [self.navigationController pushViewController:f animated:YES];
    
}
-(void)change{
    
    [self.navigationController pushViewController:f animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
