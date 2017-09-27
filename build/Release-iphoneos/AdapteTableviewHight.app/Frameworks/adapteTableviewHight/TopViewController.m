//
//  TopViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "TopViewController.h"
#import "WindowTool.h"

@implementation TopViewController
+(UIViewController *)topViewContrroler{
    UIViewController *resultVC;
    resultVC = [TopViewController _topViewController:[[WindowTool keyWindow] rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [TopViewController _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}


+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
