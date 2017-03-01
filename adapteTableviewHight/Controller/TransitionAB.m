//
//  TransitionAB.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/3/1.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "TransitionAB.h"
#import "TransitionBViewController.h"
#import "TransitionAViewController.h"

@implementation TransitionAB

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    NSLog(@"执行动画");
    TransitionAViewController *fromVC=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransitionBViewController *toVC  =[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView=[transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame=CGRectMake(0, 0, 100, 100);
    } completion:^(BOOL finished) {
        fromVC.view.hidden=YES;
        toVC.view.hidden=NO;
        [transitionContext completeTransition:YES];
    }];
}

@end
