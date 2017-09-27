//
//  UITabBarItem+DefaultTabBarItem.m
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/4.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "UITabBarItem+DefaultTabBarItem.h"

@implementation UITabBarItem (DefaultTabBarItem)
-(__kindof UITabBarItem *)defaultTabBarItem:(NSString *)title WithImage:(NSString *)imageName AndSelectImage:(NSString *)selectImageImageName{
    UIImage *image=[UIImage imageNamed:imageName];
    UIImage *selectImage=[UIImage imageNamed:selectImageImageName];
    UITabBarItem *defaultItem=[self initWithTitle:title image:image selectedImage:selectImage];
    [defaultItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return defaultItem;
}
@end
