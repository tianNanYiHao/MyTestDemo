//
//  CNProgressView.h
//  03 CNProgressView
//
//  Created by wang xinkai on 15/8/29.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNProgressView : UIView
{
    CADisplayLink *_link;
    
//    目标value
    CGFloat toValue;
    CGFloat step;
}
//最大值 最小值 当前值
@property (nonatomic,assign) float maxValue,minValue,value;

//圆的宽
@property (nonatomic,assign)CGFloat circleWidth;

//自动滚动一圈的时间
@property (nonatomic,assign) NSTimeInterval duration;

@property (nonatomic) BOOL showValue;


//设置value 是否带有动画
-(void)setValue:(float)value animated:(BOOL) animated;




@end
