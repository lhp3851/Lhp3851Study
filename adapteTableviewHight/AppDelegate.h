//
//  AppDelegate.h
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "BaseTabarViewController.h"
#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "UMFeedback.h"
#import "UMOpus.h"
#import <BaiduMapAPI/BMKLocationService.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>


@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) ViewController *viewController;


@property (strong,nonatomic) BaseTabarViewController *baseTabBarViewController;
@end

