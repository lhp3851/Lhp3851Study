//
//  TransitionBViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/1.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "TransitionBViewController.h"
#import "TransitionAB.h"

@interface TransitionBViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)TransitionAB *transition;
@end

@implementation TransitionBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.transitioningDelegate=self;
//    self.modalTransitionStyle=UIModalPresentationCustom;
    self.navigationController.delegate=self;
    self.view.backgroundColor=[UIColor greenColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
    self.transition=[[TransitionAB alloc]init];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    return nil;
}


//手势交互需要
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    return self.transition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
