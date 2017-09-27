//
//  AlertTool.h
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2016/10/31.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIAlertView,UIAlertController;//warnning:如果有多继承就好了

@interface AlertTool : NSObject<UIAlertViewDelegate>

typedef void (^ __nullable CompleteBlock)(void);

/**
 alertView 按钮标题数组
 */
@property(nullable,nonatomic,strong)NSArray <NSString *>*buttonTitles;

/**
 AlertAction 操作块
 */
@property(nullable,nonatomic,strong)NSMutableArray<UIAlertAction *> *actions;


@property(nonatomic)CompleteBlock completeBlock;

-(nonnull instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate;


/**
 显示警告框
 @param viewController 要显示警告框的视图控制器，可以传nil，
 1️⃣：如果iOS系统大（等）于8.0
 传nil则显示在当前试图控制器上，否则显示在指定的试图控制器上；
 2️⃣：如果iOS系统小于8.0
 不论传什么都会以alertview的形式进行
 */
-(void)showInViewController:(nullable UIViewController *)viewController;
@end
