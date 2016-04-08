//
//  CNProgressView.m
//  03 CNProgressView
//
//  Created by wang xinkai on 15/8/29.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import "CNProgressView.h"

@implementation CNProgressView

// 间距
#define kMargin 10

#define kAlpha  1            //图形的透明度
#define kCircleColorDefault [UIColor colorWithRed:0 green:0.72 blue:0.87 alpha:kAlpha]

#define rate 60
-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self defaultSetting];
    }

    return self;
}

-(void)awakeFromNib{
    
    [self defaultSetting];
    
}

//加载默认设置
-(void)defaultSetting{
    
    _showValue = YES;
    
    _circleWidth = 5;
    _maxValue = 100;
    _value = 0;
    _minValue = 0;
 
    _duration = 10.0f;
}



- (void)drawRect:(CGRect)rect {

    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGPoint center;
    CGFloat radius;
    if (self.frame.size.height>self.frame.size.width) {
        
        center.x = self.frame.size.width/2;
        center.y = self.frame.size.width/2;
        radius = self.frame.size.width/2 - _circleWidth - kMargin;
        
        
    }else{
    
        center.x = self.frame.size.height/2;
        center.y = self.frame.size.height/2;
        radius = self.frame.size.height/2 - _circleWidth - kMargin;

    }
    
    CGContextSetLineWidth(context, _circleWidth);

    
//    背景圆
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextAddArc(context, center.x, center.y, radius, 0, M_PI, false);
    CGContextStrokePath(context);
    
    
    
    float v_m_m = _value/(_maxValue-_minValue);
    NSLog(@"_value %f",_value);
//    NSLog(@"_maxValue %f",_maxValue);
//    NSLog(@"_mi你Value %f",_minValue);
//    NSLog(@"_m_m %f",v_m_m);
    
//    value 0:   0 0.72 0.87
//    value 1:   1  0   0
    
    UIColor* color = [UIColor colorWithRed:v_m_m green:0.72*(1-v_m_m) blue:0.87*(1-v_m_m) alpha:kAlpha];
    
    
    
//    设置颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGFloat endAngle = -M_PI_2+(2*M_PI)*v_m_m;
    
    CGContextAddArc(context, center.x, center.y, radius, -M_PI_2, endAngle, false);
    CGContextStrokePath(context);
    
    
//    写value
    
    
    if (_showValue) {
        
        float a = _value - (int)_value/1;
        int m = _value-a;
        int n = a*100;
        
        NSString *strValue = [NSString stringWithFormat:@"%02d.%02d",m,n];
        
        
        [strValue drawInRect:CGRectMake(center.x-radius*2*.8/2, center.y-radius*2*.8*2/5/2, radius*2*.8, radius*2*.8*2/5) withAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont systemFontOfSize:radius*2*.8*2/5]}];

    }
    
    
    
}






-(void)setValue:(float)value{
    if (_value != value) {
        _value = value;
        //刷新界面
        [self setNeedsDisplay];
    }
    
}


-(void)setValue:(float)value animated:(BOOL) animated{

    if (!animated) {
        [self setValue:value];
        return;
    }
    
    
    toValue = value;
    
    //    当前的value
    float current =  _value;
    
    CGFloat timeInterval = _duration*(toValue-current)/(_maxValue-_minValue);
    
    
    float count = timeInterval*rate;
    step = (toValue-current)/count;
    
    _link =  [CADisplayLink displayLinkWithTarget:self selector:@selector(time)];
    
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    
    
}


//确定 滚动一圈需要的时间 

-(void)time{
    
    static int a = 0;
    if (a != 60/rate) {
        a++;
        return;
    }
    
    a = 0;
    
    //终止
    if (_value+step >= toValue) {
        
        [_link invalidate];
        _link = nil;
        
    }
    
    NSLog(@"value%f  -   step%f",_value,step);
    [self setValue:_value+step];
    
    
}


@end
