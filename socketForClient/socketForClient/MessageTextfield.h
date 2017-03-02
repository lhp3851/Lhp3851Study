//
//  MessageTextfield.h
//  socketForClient
//
//  Created by LiuXuan on 2017/3/2.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageTextfieldDelegate <NSObject>

-(void)sendData;

@end

@interface MessageTextfield : UIView
@property(nonatomic,assign)id<MessageTextfieldDelegate> delegate;
@property(nonatomic,strong)UITextField *msgTextFiled;
@property(nonatomic,strong)UIButton    *sendBut;

/**
 发送信息控件

 @param viewController 设置为代理的VC
 @return 发送信息控件
 */
-(id)initWithDelegate:(UIViewController *)viewController;
@end
