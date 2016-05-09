//
//  ViewController.m
//  CATextLayer&&AnimationTest
//
//  Created by Aotu on 16/4/14.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import "ViewController.h"

#define kDurationTime   5
#define kFromFrontSize 20
#define kToFrontSize   40
#define kLayerWidth   400
#define kLayerHeight   50

#define kScreenWidth  self.view.frame.size.width
#define kScreenHeight self.view.frame.size.height


@interface ViewController ()
{
    UISlider *_slider;
    
}
@property (nonatomic,strong) CATextLayer *changeColoerTextLayer;   //颜色&形变   layer
@property (nonatomic,strong) CATextLayer *changeMaskTextLayer;     //遮罩颜色形变 layer

@property (nonatomic,strong) CALayer     *topLayer;
@property (nonatomic,strong) CALayer     *bottomLayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    
    [self addTextLayer];
    
    [self addTextLayerAnimation];
    
    
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(10 , 100, kScreenWidth-20, 20)];
    
    _slider.minimumValue = 0;
    _slider.maximumValue = kToFrontSize-kFromFrontSize;
    
    
    [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    

    
    
}
-(void)addTextLayer{
    

    _changeColoerTextLayer = [CATextLayer layer];
    _changeColoerTextLayer.string = @"颜色&形变TextLayer";
    [self setTextLayerWithPoint:CGPointMake(kScreenWidth/2, kScreenHeight/4) frame:CGRectMake(0, 0, kLayerWidth, kLayerHeight) forTextlayer:_changeColoerTextLayer];
    [self.view.layer addSublayer:_changeColoerTextLayer];
    
    
    
    //遮罩Mask
    _changeMaskTextLayer = [CATextLayer layer];
    _changeMaskTextLayer.string = @"作为遮罩的MaskText";
    [self setTextLayerWithPoint:CGPointZero frame:CGRectZero forTextlayer:_changeMaskTextLayer];

    _topLayer = [CALayer layer];
    _topLayer.backgroundColor = [UIColor redColor].CGColor;
    _topLayer.frame  = CGRectMake(0, 0, 0, kLayerHeight);
    
    
    _bottomLayer = [CALayer layer];
    _bottomLayer.backgroundColor = [UIColor blackColor].CGColor;
    _bottomLayer.bounds =  CGRectMake(0, 0, kLayerWidth, kLayerHeight);
    _bottomLayer.position = CGPointMake(kScreenWidth/2, kScreenHeight/2);

    _changeMaskTextLayer.frame = _bottomLayer.bounds;
    [_bottomLayer addSublayer:_topLayer];
    _bottomLayer.mask = _changeMaskTextLayer;

    [self.view.layer addSublayer:_bottomLayer];
    
    
    
    
}


-(void)sliderChange:(UISlider*)value{
    
    NSLog(@"%f",value.value);

    //timeOffset 动画进度对应的时间 (value.value / ??  = 5) 最后要等于5 (0 ~ 5)
    _changeColoerTextLayer.timeOffset = value.value/(value.maximumValue/kDurationTime);
    NSLog(@"%f",_changeColoerTextLayer.timeOffset);
    
    
    
    
    _changeMaskTextLayer.timeOffset = value.value/(value.maximumValue/kDurationTime);
    
    //保证进度统一
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGRect topLayerRect = _topLayer.frame;

    
    topLayerRect.size.width = roundf(_bottomLayer.frame.size.width * (value.value/(value.maximumValue/kDurationTime))/kDurationTime);
    NSLog(@"++++++++  %f",topLayerRect.size.width);
    
    _topLayer.frame = topLayerRect;

    [CATransaction commit];
    
}

-(void)addTextLayerAnimation{
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"foregroundColor"];
    colorAnimation.duration = kDurationTime;
    colorAnimation.fromValue = (__bridge id _Nullable)([UIColor blackColor].CGColor);
    colorAnimation.toValue   = (id)[UIColor orangeColor].CGColor;
    colorAnimation.fillMode = kCAFillModeForwards;
    colorAnimation.removedOnCompletion = NO;
    colorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]; //执行模式 默认
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"fontSize"];
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.duration = kDurationTime;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];  //执行模式 渐进渐出
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = @(kFromFrontSize);
    scaleAnimation.toValue   = @(kToFrontSize);
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.duration = kDurationTime;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.animations = @[colorAnimation,scaleAnimation];
    

    _changeColoerTextLayer.speed = 0.0;
    [_changeColoerTextLayer addAnimation:animationGroup forKey:@"color&transfromChange"];
    
    
    _changeMaskTextLayer.speed = 0.0;
    [_changeMaskTextLayer addAnimation:scaleAnimation forKey:@"color&MaskformChange"];
    
    
}


-(void)setTextLayerWithPoint:(CGPoint)point frame:(CGRect)frame forTextlayer:(CATextLayer*)textLayer{
    textLayer.frame = frame;
    textLayer.position = point;
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.fontSize = kFromFrontSize;
    textLayer.alignmentMode = kCAAlignmentCenter;
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
