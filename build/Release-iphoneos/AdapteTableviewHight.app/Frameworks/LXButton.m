//
//  LXButton.m
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/25.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "LXButton.h"
#import "UIImage+Extension.h"

typedef NS_ENUM(NSInteger,LXButtonType){
    LXButtonTypeCustom = 0,                         // no button type
    LXButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0),  // standard system button
    
    LXButtonTypeDetailDisclosure,
    LXButtonTypeInfoLight,
    LXButtonTypeInfoDark,
    LXButtonTypeContactAdd,
    
    LXButtonTypeRoundedRect,
};


@implementation LXButton


+(instancetype)setTitle:(NSString *)title normaTitleColor:(UIColor *)normaTitleColor heilightTitleColor:(UIColor *)heilightTitleColor prohibitTitleColor:(UIColor *)prohibitTitleColor normaBackGroundColor:(UIColor *)normaBackGroundColor heilightBackGroundColor:(UIColor *)heilightBackGroundColor prohibitBackGroundColor:(UIColor *)prohibitBackGroundColor buttonType:(UIButtonType)buttonType{
    LXButton *button=[LXButton buttonWithType:buttonType];
    button.layer.cornerRadius=3.0f;
    button.layer.masksToBounds=YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normaTitleColor forState:UIControlStateNormal];
    [button setTitleColor:heilightTitleColor forState:UIControlStateHighlighted];
    [button setTitleColor:prohibitTitleColor forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageWithColor:normaBackGroundColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:heilightBackGroundColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageWithColor:prohibitBackGroundColor] forState:UIControlStateDisabled];
    return (LXButton *)button;
}

+(instancetype)buttonWithImage:(UIImage *)image frame:(CGRect)buttonFrame normaBackGroundColor:(UIColor *)normaBackGroundColor heilightBackGroundColor:(UIColor *)heilightBackGroundColor prohibitBackGroundColor:(UIColor *)prohibitBackGroundColor buttonType:(UIButtonType)buttonType{
    LXButton *button=[LXButton buttonWithType:buttonType];
    button.frame=buttonFrame;
    button.layer.cornerRadius=(buttonFrame.size.width/2);
    button.layer.masksToBounds=YES;
    button.layer.borderWidth=0.5f;
    button.layer.borderColor=[UIColor whiteColor].CGColor;
    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:normaBackGroundColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:heilightBackGroundColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageWithColor:prohibitBackGroundColor] forState:UIControlStateDisabled];
    return (LXButton *)button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
