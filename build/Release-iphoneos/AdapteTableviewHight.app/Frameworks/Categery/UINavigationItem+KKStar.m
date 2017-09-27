//
//  UINavigationItem+KKStar.m
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/4.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "UINavigationItem+KKStar.h"

@implementation UINavigationItem (KKStar)
+(instancetype)DefaultNavigationItem{
    UINavigationItem *defaultItem=[[UINavigationItem alloc]init];
    defaultItem.title=@"Back";
    return defaultItem;
}
@end
