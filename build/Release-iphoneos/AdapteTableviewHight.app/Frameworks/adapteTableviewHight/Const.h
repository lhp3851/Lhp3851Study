//
//  Const.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#ifndef Const_h
#define Const_h

// 上下拉操作
typedef enum : NSUInteger {
    MJRereshOperateAuto,
    MJRereshOperateRefresh,
    MJRereshOperateLoad,
} MJRereshOperate;

#define kHMARGIN 15

#define kMinute  60

#define kHoure   60*kMinute

//屏幕宽高
#define kSCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

#define kSCREENWIDTH  [[UIScreen mainScreen] bounds].size.width

#define kSTATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define kNAVIGATION_BAR_HEIGHT self.navigationController.navigationBar.frame.size.height

#define kTABLE_BAR_HEIGHT self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

#endif /* Const_h */
