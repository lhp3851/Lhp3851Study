//
//  UINavigationBar+KKStar.m
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/4.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "UINavigationBar+KKStar.h"

@implementation UINavigationBar (KKStar)
+(instancetype)DefaultNavigationBar{
    UINavigationBar *defaultNavigationBar=[UINavigationBar appearance];
    defaultNavigationBar.backgroundColor=[UIColor whiteColor];
    defaultNavigationBar.translucent=YES;
    return defaultNavigationBar;
}
@end
