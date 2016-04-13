//
//  FirstViewController.m
//  changeVIewControllerSize
//
//  Created by Aotu on 16/4/12.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"改变Size的VC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGSize)preferredContentSize{
    
    if (self.view != nil&&self.view.frame.size.height > 400) {
        CGSize tempSize;
        tempSize.height = 100;
        tempSize.width  = 200;
        return tempSize;

    }else{
        return [super preferredContentSize];
    }
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
