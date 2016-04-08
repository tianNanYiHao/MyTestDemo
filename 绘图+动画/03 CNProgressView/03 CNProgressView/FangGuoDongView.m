//
//  FangGuoDongView.m
//  03 CNProgressView
//
//  Created by Aotu on 16/3/31.
//  Copyright © 2016年 wxk. All rights reserved.
//

#import "FangGuoDongView.h"
@interface FangGuoDongView(){
    
    CADisplayLink *_displayLink;
    CGContextRef  _contextRef;
    
    
}


@end

@implementation FangGuoDongView



-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setINSTALL];
    }return self;
}

-(void)setINSTALL{
    _value = 0;
    
}


//-(void)setValue:(CGFloat)value{
//    if (_value != value) {
//        _value =  value;
//        [self setNeedsDisplay];
//    }
//}



//动画开始  添加CADisplayLink
-(void)startAnimation{
    
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(transformmm)];
        _displayLink.frameInterval = 2;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}


//动画结束  关闭runloop 移除CADisplayLink
-(void)compeletAnimation{
    
    [_displayLink invalidate];
    _displayLink = nil;
  
}


-(void)transformmm{
    NSLog(@"_value === %f",_value);
    
    [self setValue:_value+0.66667];

    [self setNeedsDisplay];
    
    if (_value >= 10 ) {
        [self compeletAnimation];
    }
}

-(void)drawRect:(CGRect)rect{
    NSLog(@"%@",@"1");
    
    if (_value != 0) {
        _contextRef = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(_contextRef, 5);
        CGContextSetStrokeColorWithColor(_contextRef, [UIColor whiteColor].CGColor);
        
        float v_m_m = _value/10;
        CGFloat endAngle = -M_PI_2+(2*M_PI)*v_m_m;
        UIColor *color  = [UIColor colorWithRed:v_m_m green:v_m_m*7.8 blue:v_m_m*1.9 alpha:1];

        CGContextSetStrokeColorWithColor(_contextRef, color.CGColor);
        CGContextAddArc(_contextRef, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.width/4, -M_PI_2,
                        endAngle, NO);
        CGContextSetLineCap(_contextRef, kCGLineCapRound);
        CGContextStrokePath(_contextRef);
    }
   

}


@end
