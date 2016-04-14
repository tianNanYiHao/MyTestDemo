//
//  StarViewController.m
//  LineExtendWithStar
//
//  Created by Aotu on 16/4/7.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "StarViewController.h"
#import "Line.h"
@interface StarViewController ()
{
    UIButton *_clearBtn;
}
@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    Line *line = [[Line alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/4, self.view.frame.size.width, self.view.frame.size.height/4)];
    line.backgroundColor = [UIColor whiteColor];
    line.star = [_starString floatValue];
    [self.view addSubview:line];
    

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
