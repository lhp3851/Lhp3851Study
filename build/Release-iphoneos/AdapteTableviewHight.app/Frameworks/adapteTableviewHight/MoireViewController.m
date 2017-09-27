//
//  MoireViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/6/15.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "MoireViewController.h"

@interface MoireViewController ()

@end

@implementation MoireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPannel];
    [self setupRippleAnimation];
}

-(void)setPannel{
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)setupRippleAnimation
{
    CGFloat width      = 4;
    CGRect pathFrame   = CGRectMake(0,0, width, width);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:width/2];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.position      = CGPointMake(kSCREENWIDTH/2, kSCREENHEIGHT/2);
    shapeLayer.bounds        = path.bounds;
    shapeLayer.path          = [path CGPath];
    shapeLayer.strokeColor   = [[UIColor colorWithRed:65/225.0 green:182/255.0 blue:251 alpha:1] CGColor];
    shapeLayer.fillColor     = [[UIColor clearColor] CGColor];
    shapeLayer.lineWidth     = 0.2;
    [self.view.layer addSublayer:shapeLayer];

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeScale(60, 60, 1)];

    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue   = @0;

    CAAnimationGroup *animation   = [CAAnimationGroup animation];
    animation.animations          = @[scaleAnimation, alphaAnimation];
    animation.duration            = 1;
    animation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.repeatCount         =  HUGE_VALF;
    animation.removedOnCompletion = NO;
    [shapeLayer addAnimation:animation forKey:nil];

    NSLog(@"shapeLayer.frame:%@ and self.view.frame:%@",NSStringFromCGRect(shapeLayer.frame),NSStringFromCGRect(self.view.frame));

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
