//
//  ViewController.m
//  LineExtendWithStar
//
//  Created by Aotu on 16/4/7.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"
#import "StarViewController.h"
@interface ViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet UITextField *starFiled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
}
- (IBAction)starBtn:(id)sender {
    
    StarViewController *star = [[StarViewController alloc] init];
    star.starString = _starFiled.text;
    
    [self.navigationController pushViewController:star animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
