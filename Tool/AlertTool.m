//
//  AlertTool.m
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2016/10/31.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#import "AlertTool.h"

@interface AlertTool (){
    id ATDelegate;
    NSString *ATTitle;
    NSString *ATMessage;
    NSString *ATSuerlButtonTitle;
    NSString *ATOtherButtonTitles;
}
@property(nonatomic,strong)UIAlertView *alertView;
@property(nonatomic,strong)UIAlertController *alertController;

@end

@implementation AlertTool

-(UIAlertView *)alertView{
    if (!_alertView) {
        if (self.buttonTitles.count==2) {
            _alertView=[[UIAlertView alloc]initWithTitle:ATTitle message:ATMessage delegate:ATDelegate cancelButtonTitle:self.buttonTitles[0] otherButtonTitles:self.buttonTitles[1], nil];
        }
        else if (self.buttonTitles.count==1){
            _alertView=[[UIAlertView alloc]initWithTitle:ATTitle message:ATMessage delegate:ATDelegate cancelButtonTitle:self.buttonTitles[0] otherButtonTitles:nil];
        }
        else{
            _alertView=[[UIAlertView alloc]initWithTitle:ATTitle message:ATMessage delegate:ATDelegate cancelButtonTitle:nil otherButtonTitles:nil];
        }
    }
    return _alertView;
}

-(UIAlertController *)alertController{
    if (!_alertController) {
        _alertController=[UIAlertController alertControllerWithTitle:ATTitle message:ATMessage preferredStyle:UIAlertControllerStyleAlert];
        for (UIAlertAction *action in self.actions) {
            [_alertController addAction:action];
        }
        
        if (_alertController.actions.count<=0) {//在没有添加任何操作的情况下，添加一个默认操作
            UIAlertAction *action =[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [_alertController addAction:action];
        }
    }
    return _alertController;
}

-(NSArray <NSString *>*)buttonTitles{
    return _buttonTitles;
}

-(NSArray <UIAlertAction *> *)actions{
    if (kSYSYTEMVERSION>8.0) {
        for (NSString *title in self.buttonTitles) {
            _actions=[NSMutableArray new];
            if (self.alertView){
                return nil;
            }
            else{
                if (_actions.count>0) {
                    return _actions;
                }
                else{//默认处理
                    UIAlertAction *action=[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [_actions addObject:action];
                }
            }
        }
        return _actions;
    }
    else{
        return nil;
    }
}

-(instancetype)init{
    self=[super init];
    if (self) {
        if (kSYSYTEMVERSION>=8.0) {
            _alertController=self.alertController;
        }
        else{
            _alertView=self.alertView;
        }
        return self;
    }
    return nil;
}

-(nonnull instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate{
    self=[super init];
    if (self) {
        ATDelegate=delegate;
        ATMessage =message;
        ATTitle   =title;
        return self;
    }
    return nil;
}

-(instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate suerButtonTitle:(nullable NSString *)suerlButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles,...{
    self=[super init];
    if (self) {
        ATTitle   =title;
        ATDelegate=delegate;
        ATMessage =message;
        ATSuerlButtonTitle =suerlButtonTitle;
        ATOtherButtonTitles=otherButtonTitles;
        return self;
    }
    return nil;
}



-(void)showInViewController:(nullable UIViewController *)viewController{
    if (kSYSYTEMVERSION<8.0) {
        [self.alertView show];
    }
    else{
        __weak typeof(self) weakSelf=self;
        if (viewController) {
            [viewController presentViewController:self.alertController animated:YES completion:^{
                if (weakSelf.completeBlock) {
                    weakSelf.completeBlock();
                }
            }];
        }
        else{
            UIViewController *topViewController=[self topViewCotroller];
            [topViewController presentViewController:self.alertController animated:YES completion:^{
                if (weakSelf.completeBlock) {
                    weakSelf.completeBlock();
                }
            }];
        }
    }
}

-(nonnull UIViewController *)topViewCotroller{
    UIViewController *topViewController=[self getCurrentVC];
    if (topViewController.presentedViewController) {
        topViewController=[self getPresentedViewController];
    }
    else{
        UIViewController *presentedVC=[self getPresentedViewController];
        topViewController=presentedVC?presentedVC:topViewController;
    }
    return topViewController;
}


/**
 主Window

 @return 主Window
 */
-(UIWindow *)keyWindow{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * keyWindow=[self keyWindow];
    
    UIView *frontView = [[keyWindow subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = keyWindow.rootViewController;
    
    return result;
}


/**
 当前试图控制器

 @return 当前试图控制器
 */
- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


@end
