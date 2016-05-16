//
//  ShowView.m
//  Deep JavaScriptWithOC
//
//  Created by Aotu on 16/5/6.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ShowView.h"

@interface ShowView(){

    ShowView *_showView;
    UILabel  *_lab;
    
    
}



@end
@implementation ShowView


-(instancetype)createWithFrame:(CGRect)frame backGroundcolor:(UIColor*)Bcakcolor{
    
    if ( self == [super initWithFrame:frame]) {
        _showView = [[ShowView alloc] initWithFrame:frame];
        
        _showView.backgroundColor = Bcakcolor;
        
//        _lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
//        _lab.backgroundColor = [UIColor greenColor];
//        _lab.font = [UIFont systemFontOfSize:14];
//        _lab.numberOfLines = 0;
//        _lab.text = @"111111111111";
//        [self addSubview:_lab];
//        

        return _showView;
    }
    return nil;
    
    
    
    
}




@end
