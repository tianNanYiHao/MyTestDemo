//
//  Line.m
//  LineExtendWithNumber
//
//  Created by Aotu on 16/4/6.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "Line.h"

#define kscreenHeight (self.frame.size.height)
#define kscreenWidth  (self.frame.size.width)

@interface Line(){
    
    CGContextRef   _context;
    CADisplayLink *_displayLink;
    float          _addfloat;     //添加数值
    float          _curretnfloat; //当前数值
    float          _jianfloat;    //减去数值
    float          _starNum;
    
    
    

    
}@end


@implementation Line

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {

        [self setCADisplayLink];
        
        _curretnfloat = 0;
        
    }return self;
}
-(void)setCADisplayLink{
    
    _addfloat = 0;
    _jianfloat = 100;
    
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeValue)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}

-(void)setInit{
    
    _with = @(15);
    _color = [UIColor orangeColor];

}

-(void)drawRect:(CGRect)rect{
    
    //初始化
    _context = UIGraphicsGetCurrentContext();
    
    [self setInit];
    CGContextSaveGState(_context);
    
    CGContextSetLineWidth(_context, [_with doubleValue]);
    CGContextSetLineCap(_context, kCGLineCapRound);
    CGContextMoveToPoint(_context, 0, kscreenHeight/2);
    CGContextAddLineToPoint(_context,_curretnfloat, kscreenHeight/2);
    CGContextSetStrokeColorWithColor(_context, [UIColor colorWithRed:222/255.0 green:_jianfloat/255.0 blue:0/255.0 alpha:0.8].CGColor);
    CGContextStrokePath(_context);
    CGContextRestoreGState(_context);
    
    
}




-(void)setStar:(float)star{
    _star = star;
    _starNum = star;
    _star  = _star/5 * self.frame.size.width;
    NSLog(@"%f",_star);
}

-(void)changeValue{

    //控制进度
    if (_curretnfloat < _star) {
        _addfloat = 3+_addfloat;
        _curretnfloat = _addfloat;
        
        _jianfloat = -0.7 + _jianfloat;
        
          NSLog(@"%f",_jianfloat);
        
    }else{
        [_displayLink invalidate];
    }
    [self setNeedsDisplay];
    
    
}


- (UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}



@end
