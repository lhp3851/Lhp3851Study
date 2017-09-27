//
//  MessageTextfield.m
//  socketForClient
//
//  Created by LiuXuan on 2017/3/2.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "MessageTextfield.h"

@interface MessageTextfield ()
@property(nonatomic,strong)UIViewController *viewController;
@end

@implementation MessageTextfield

-(id)initWithDelegate:(UIViewController *)viewController{
    self=[super init];
    if (self) {
        self.viewController =viewController;
        self.delegate=(id<MessageTextfieldDelegate>)viewController;
        [self addSubview:self.msgTextFiled];
        [self addSubview:self.sendBut];
    }
    return self;
}

-(UITextField *)msgTextFiled{
    if (!_msgTextFiled) {
        _msgTextFiled=[[UITextField alloc]initWithFrame:(CGRect){5,7.5f,kSCREENWIDTH-85,45}];
        _msgTextFiled.delegate=(id<UITextFieldDelegate>)self.viewController;
        _msgTextFiled.placeholder=@"输入要发送的消息";
    }
    return _msgTextFiled;
}

-(UIButton *)sendBut{
    if (!_sendBut) {
        _sendBut=[UIButton buttonWithType:UIButtonTypeCustom];
        _sendBut.frame=(CGRect){kSCREENWIDTH-80,7.5f,60,45};
        _sendBut.layer.masksToBounds=YES;
        _sendBut.layer.cornerRadius=5.0f;
        _sendBut.backgroundColor=[UIColor blueColor];
        [_sendBut setTitle:NSLocalizedString(@"发送", nil) forState:UIControlStateNormal];
        [_sendBut addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBut;
}

-(void)sendMessage:(id)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(sendData)]) {
        [self.delegate sendData];
    }
}

@end
