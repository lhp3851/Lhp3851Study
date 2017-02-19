//
//  WindowTool.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "WindowTool.h"

@implementation WindowTool

+(UIWindow *)keyWindow{
    __block UIWindow *keyWindow=nil;
    NSArray *windowArray=[UIApplication sharedApplication].windows;
    [windowArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIWindow *window=obj;
        if (window.windowLevel==UIWindowLevelNormal) {
            keyWindow=obj;
        }
    }];
    return keyWindow;
}

@end
