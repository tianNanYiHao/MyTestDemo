//
//  ViewController.m
//  UIPresentationVCtest
//
//  Created by Aotu on 16/4/11.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"
#import "PopViewController.h"
@interface ViewController ()<UIPopoverPresentationControllerDelegate>
{
  
    PopViewController   *_popVC;
    
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    self.navigationItem.title = @"QQ";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnR = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnR.frame = CGRectMake(0, 0, 50, 50);
    btnR.backgroundColor = [UIColor clearColor];
    [btnR setTitle:@"+" forState:UIControlStateNormal];
    [btnR addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *imte = [[UIBarButtonItem alloc] initWithCustomView:btnR];
    self.navigationItem.rightBarButtonItem = imte;
    
}
-(void)popView{
    
    _popVC = [[PopViewController alloc] init];
    
    
    _popVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //设置依附的按钮
    _popVC.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    
    //可以指示小箭头颜色
    _popVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    
    //content尺寸
    _popVC.preferredContentSize = CGSizeMake(400, 400);
    
    //pop方向
    _popVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //delegate
    _popVC.popoverPresentationController.delegate = self;

    [self presentViewController:_popVC animated:YES completion:nil];
    
    
    
}
//代理方法 ,点击即可dismiss掉每次init产生的PopViewController
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}


@end
