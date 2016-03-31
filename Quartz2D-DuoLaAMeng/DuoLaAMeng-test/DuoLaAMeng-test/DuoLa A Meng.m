//
//  DuoLa A Meng.m
//  DuoLaAMeng-test
//
//  Created by Aotu on 16/3/21.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "DuoLa A Meng.h"
#define kDoraBlue     [UIColor colorWithRed:29.0f/255.f green:159.f/255.f blue:230.f/255.f alpha:1]
@implementation DuoLa_A_Meng




-(void)drawRect:(CGRect)rect{
    
     [self drawDoraemon:UIGraphicsGetCurrentContext()];
    
}

-(void)drawDoraemon:(CGContextRef)context{
    
    
    //外部轮廓 (圆线)
    CGContextSetLineWidth(context, 3);
    //1.1.1 外部圆 轮廓线
    CGContextAddArc(context, self.width/2, self.width/2, self.width/2-50, M_PI_4+M_PI_4*.2, -M_PI-M_PI_4, 1);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    

    
    //1.1.2 外部圆
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, kDoraBlue.CGColor);
    CGContextAddArc(context, self.width/2, self.width/2, self.width/2-50, M_PI_4+M_PI_4*.2, -M_PI-M_PI_4, 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    //1.1.3 猫领带黑线(黑粗直)
    CGContextSetLineWidth(context, 20);
    CGContextMoveToPoint(context, 85, 283);
    CGContextAddLineToPoint(context, 283, 298);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    
    //1.1.4 猫领带红色填充
    CGContextSetLineWidth(context, 14);
    CGContextMoveToPoint(context, 85, 283);
    CGContextAddLineToPoint(context, 283, 298);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
    //跟新上下文状态
    CGContextRestoreGState(context);
    
    //嘴巴轮廓
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextMoveToPoint(context, 82.5, 272.5);
    CGContextAddCurveToPoint(context, -79, 30, 455, 68, 268, 286.5);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextMoveToPoint(context, 82.5, 272.5);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextAddCurveToPoint(context, -79, 30, 455, 68, 268, 286.5);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    //眼睛
    CGContextSaveGState(context);
    CGContextRotateCTM(context, M_PI_4/2);
    CGContextTranslateCTM(context, 40, -70);
    //左眼框
    CGContextStrokeEllipseInRect(context, CGRectMake(107, 66, 65, 90));
    CGContextFillEllipseInRect(context, CGRectMake(107+2, 66+2, 65-3, 90-3));;
    CGContextFillPath(context);
    
    //右眼框
    CGContextStrokeEllipseInRect(context, CGRectMake(107+66, 66-10, 65+5, 80));
    CGContextFillEllipseInRect(context, CGRectMake(107+66+2, 66-10+2, 65+5-3, 80-3));
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    
    //眼珠左
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 8);
    CGContextSetLineCap(context,kCGLineCapRound); //设施线段端点样式
    
    CGContextAddArc(context, 145, 95, 30, M_PI_4, M_PI_2, 0);
    CGContextStrokePath(context);
    
    //眼珠右
    CGContextAddArc(context, 225, 95, 40, M_PI_2, M_PI_2+M_PI_4, 0);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    
    //鼻子
    CGContextAddArc(context, 158, 162, 30, 0, 2*M_PI, 0);
    CGContextStrokePath(context);
    
    CGContextAddArc(context, 158, 162, 29, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextAddArc(context, 158-10, 162-9, 13, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    //嘴
    CGContextSetLineCap(context, kCGLineCapRound); //设置线端点样式
    CGContextMoveToPoint(context, 158, 192);       //设置起点
    CGContextAddQuadCurveToPoint(context, 150, 210, 158, 230);   //设置控制点 &  终点
    CGContextStrokePath(context);
    
    //嘟嘴
    CGContextMoveToPoint(context, 158, 230);
    CGContextAddCurveToPoint(context, 130, 205, 120, 248, 150, 250);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 150, 250);
    CGContextAddCurveToPoint(context, 130, 245, 130, 270-2, 149, 268-2);
    CGContextStrokePath(context);
    
    
    //胡子
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 4);
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    //左上
    CGContextMoveToPoint(context, 70, 180);
    CGContextAddQuadCurveToPoint(context, 70+30, 180, 130, 190);
    CGContextStrokePath(context);

    //左中
    CGContextMoveToPoint(context, 60, 210);
    CGContextAddQuadCurveToPoint(context, 85, 205, 120, 210);
    CGContextStrokePath(context);
    
    
    //做下
    CGContextMoveToPoint(context, 70, 240);
    CGContextAddQuadCurveToPoint(context, 88, 225, 118, 225);
    CGContextStrokePath(context);
    
    //右上
    CGContextMoveToPoint(context, 210, 190);
    CGContextAddQuadCurveToPoint(context, 245, 180, 290, 180);
    CGContextStrokePath(context);
    
    //右中
    CGContextMoveToPoint(context, 208, 190+20);
    CGContextAddQuadCurveToPoint(context, 208+50, 190+18, 290+5, 180+40);
    CGContextStrokePath(context);
    
    //右下
    CGContextMoveToPoint(context, 210, 190+40);
    CGContextAddQuadCurveToPoint(context, 210+40, 190+40+4, 290-15, 180+40+30);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);

}

-(CGFloat)width{
    return self.frame.size.width;
}

@end
