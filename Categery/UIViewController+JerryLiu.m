//
//  UIViewController+JerryLiu.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/5/18.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "UIViewController+JerryLiu.h"

#define ViewControllerName NSStringFromClass([self class])

@implementation UIViewController (JerryLiu)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swizzing_viewWillAppear:);
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

#pragma mark - Method Swizzling
- (void)swizzing_viewWillAppear:(BOOL)animated
{
    [self inject_ViewWillAppear];
    //不能干扰原来的代码流程，插入代码结束后要让本来该执行的代码继续执行
    [self swizzing_viewWillAppear:animated];
}

-(void)swizzing_viewDidDisappear:(BOOL)animated{
    [self inject_ViewWillDisappear];
    [self swizzing_viewDidDisappear:animated];
}

-(void)inject_ViewWillAppear{
//    NSLog(@"我在%@的viewWillAppear执行前偷偷插入了一段代码",ViewControllerName);
    [MobClick endLogPageView:ViewControllerName];
}

-(void)inject_ViewWillDisappear{
//    NSLog(@"我在%@的viewWillDisappear执行前偷偷插入了一段代码",ViewControllerName);
    [MobClick beginLogPageView:ViewControllerName];
   
}
#pragma mark 获取视图控制器事件变量
- (NSString *)eventPageViewController:(BOOL)EnterPage
{
    NSString *selfClassName = NSStringFromClass([self class]);
    NSString *pageEventID = nil;
    if ([selfClassName isEqualToString:@"ViewController"]) {
        pageEventID = EnterPage ? @"EVENT_HOMEPAGE" : @"LEAVE_HOME_PAGE";
    }
    else if ([selfClassName isEqualToString:@"FeedbackViewController"]) {
        pageEventID = EnterPage ? @"EVENT_DETAIL_PAGE" : @"LEAVE_DETAIL_PAGE";
    }
    else{
        pageEventID = EnterPage ?@"EVENT_NEWPAGEVC":@"LEAVE_NEWPAGEVC";
    }
    return pageEventID;
}

@end
