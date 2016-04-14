//
//  ViewController.m
//  03 CNProgressView
//
//  Created by wang xinkai on 15/8/29.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import "ViewController.h"
#import "FangGuoDongView.h"
@interface ViewController ()
{
    FangGuoDongView *_fangGuoDongView;
    CADisplayLink   *_displayLink;
    
    __weak IBOutlet UILabel *ValueLab;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    _fangGuoDongView  = [[FangGuoDongView alloc] initWithFrame:CGRectMake(50 ,400,300, 300)];
    _fangGuoDongView.backgroundColor  = [UIColor blackColor];
    
    [self.view addSubview:_fangGuoDongView];
    [progressView setValue:50 animated:YES];
    
    
    
    
}
-(IBAction)sliderChange:(UISlider*)sender{

    progressView.value = sender.value;
}

- (IBAction)star:(id)sender {
    [_fangGuoDongView startAnimation];
    
        
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
