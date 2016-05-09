//
//  ViewController.m
//  CATextLayerTest
//
//  Created by Joe Shang on 7/14/15.
//  Copyright (c) 2015 Shang Chuanren. All rights reserved.
//

#import "ViewController.h"

static CGFloat const kTextLayerFontSize = 29.0f;
static CGFloat const kTextLayerSelectedFontSize = 35.0f;
static CGFloat const kLayerWidth = 300.0f;
static CGFloat const kLayerHeight = 40.0f;
static CGFloat const kAnimationDuration = 5.0f;

@interface ViewController ()

@property (nonatomic, strong) CATextLayer *colorTextLayer;
@property (nonatomic, strong) CATextLayer *maskTextLayer;
@property (nonatomic, strong) CATextLayer *ThredMytextLayer;

@property (nonatomic, strong) CALayer *topLayer;
@property (nonatomic, strong) CALayer *bottomLayer;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    [self p_initLayers];
    

    [self p_addAnimationForLayers];
    
    
    
    CGPoint center = CGPointMake(roundf(self.view.bounds.size.width / 2), roundf(self.view.bounds.size.height / 4));
    self.colorTextLayer.position = center;
    
    center.y += roundf(self.view.bounds.size.height / 2);
    self.bottomLayer.position = center;
    
    
    //设置我的textLayer的position
    self.ThredMytextLayer.position = CGPointMake(center.x, center.y+100);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Target-Action

- (IBAction)onSliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    NSLog(@"%f",slider.value);
    self.colorTextLayer.timeOffset = slider.value;     //设置进程随着slider改变
    self.maskTextLayer.timeOffset = slider.value;      //设置进程随着slider改变
    self.ThredMytextLayer.timeOffset = slider.value;   //设置进程随着slider改变
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGRect rect = self.topLayer.frame;
    
    
    rect.size.width = roundf(self.bottomLayer.frame.size.width * slider.value / kAnimationDuration);    //决定覆盖的layer形变'
    NSLog(@"+++++++ %f",rect.size.width);
    self.topLayer.frame = rect;
    [CATransaction commit];
}

#pragma mark - Private

- (void)p_initLayers {
    self.colorTextLayer = [CATextLayer layer];
    self.colorTextLayer.string = @"我会整体变色哦";
    self.colorTextLayer.foregroundColor = [UIColor greenColor].CGColor; //前景颜色 不设置没事
    [self p_commonInitTextLayer:self.colorTextLayer];                   //
    [self.view.layer addSublayer:self.colorTextLayer];
    
    self.topLayer = [CALayer layer];
    self.topLayer.backgroundColor = [UIColor redColor].CGColor;
    self.topLayer.frame = CGRectMake(0, 0, 0, kLayerHeight);
    
    self.bottomLayer = [CALayer layer];
    self.bottomLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.bottomLayer.bounds = CGRectMake(0, 0, kLayerWidth, kLayerHeight);
    [self.bottomLayer addSublayer:self.topLayer];
    [self.view.layer addSublayer:self.bottomLayer];
    
    self.maskTextLayer = [CATextLayer layer];
    self.maskTextLayer.string = @"我会区域变色哦";
    self.maskTextLayer.foregroundColor = [UIColor blackColor].CGColor;   //前景颜色 不设置没事
    [self p_commonInitTextLayer:self.maskTextLayer];                     //
    self.maskTextLayer.frame = self.bottomLayer.bounds;
    [self.bottomLayer setMask:self.maskTextLayer];
    
    
    ////////我的textLayer
    _ThredMytextLayer = [CATextLayer layer];
    _ThredMytextLayer.string = @"我自己写的TextLayer";
    _ThredMytextLayer.foregroundColor = [UIColor orangeColor].CGColor;
    [self p_commonInitTextLayer:_ThredMytextLayer];
    [self.view.layer addSublayer:_ThredMytextLayer];
    

    
}

//设置动画( 字体颜色变化  +   字体front大小形变 )
- (void)p_addAnimationForLayers {
    
    
    CABasicAnimation *colorAnimation = [CABasicAnimation
                                        animationWithKeyPath:@"foregroundColor"];  //设置 字体前景颜色变化量
    colorAnimation.duration = kAnimationDuration;
    colorAnimation.fillMode = kCAFillModeForwards;
    colorAnimation.removedOnCompletion = NO;
    colorAnimation.fromValue = (id)[UIColor blackColor].CGColor;
    colorAnimation.toValue = (id)[UIColor greenColor].CGColor;
    colorAnimation.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseOut];  //设置动画的等渐进效果
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation
                                        animationWithKeyPath:@"fontSize"];
    scaleAnimation.duration = kAnimationDuration;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = @(kTextLayerFontSize);
    scaleAnimation.toValue = @(kTextLayerSelectedFontSize);
    scaleAnimation.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = kAnimationDuration;
    animationGroup.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.animations = @[colorAnimation, scaleAnimation];
    
    self.colorTextLayer.speed = 0.0f;
    [self.colorTextLayer addAnimation:animationGroup forKey:@"animateColorAndFontSize"];
    
    self.maskTextLayer.speed = 0.0f;
    [self.maskTextLayer addAnimation:scaleAnimation forKey:@"animateFontSize"];
    
    self.ThredMytextLayer.speed = 0.0f; 
    [self.ThredMytextLayer addAnimation:animationGroup forKey:@"animateFontSize"];
    
}

- (void)p_commonInitTextLayer:(CATextLayer *)textLayer {
    textLayer.fontSize = kTextLayerFontSize;
    textLayer.contentsScale = [[UIScreen mainScreen] scale];
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.frame = CGRectMake(0, 0, kLayerWidth, kLayerHeight);
}

@end
