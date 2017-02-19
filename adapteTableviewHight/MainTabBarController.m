//
//  MainTabBarControllerController.m
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/4.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "MainTabBarController.h"
#import "ViewController.h"
#import "feedbackViewController.h"
#import "MainNavigationController.h"

@interface MainTabBarController (){
    
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakself = self;
    [self setViewControler:[self tabBarViewControllers] CompleteHandler:^() {
        [weakself setDefaultTabBar];
    }];
}


-(void)setViewControler:(NSArray <UIViewController *> *)viewControllers CompleteHandler:(void(^)(void))completeHandler{
    if (!completeHandler) {
        NSLog(@"设置视图控制器出错");
    }
    else{
        self.viewControllers=viewControllers;
        completeHandler();
    }
}


-(NSArray *)tabBarViewControllers{
    ViewController *VC=[[ViewController alloc]init];
    VC.title=@"首页";
    MainNavigationController *navVC=[[MainNavigationController alloc]initWithRootViewController:VC];
    [VC.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    VC.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    feedbackViewController *feedBackVC=[[feedbackViewController alloc]init];
    feedBackVC.title=@"功能";
    MainNavigationController *navFeedBackVC=[[MainNavigationController alloc]initWithRootViewController:feedBackVC];
    
    NSArray *tabBarViewControllers=[NSArray arrayWithObjects:navVC,navFeedBackVC, nil];
    return tabBarViewControllers;
}

-(void)setDefaultTabBar{
    UITabBar *defaultTabBar=self.tabBar;
    UITabBarItem *frontPage=defaultTabBar.items[0];
    [frontPage defaultTabBarItem:@"首页" WithImage:@"" AndSelectImage:@""];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
