//
//  NSString_NSStringExtension.h
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/3.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

/*
 1.自定义的名字在后面，不能包含.m文件，会造成重复包含另一个类的.m文件，可以添加属性、成员变量和方法
 2.分类和类扩展的相似之处是：都可以为类添加一个额外的方法；
 3.不同之处在于：要添加额外方法，分类必须在第一个@interface中声明方法，并且在@implementation中提供实现，不然运行时出错。而类扩展，你添加的方法是一个required API，如果不去实现，编译器会警告，而且这个方法的声明可以不在第一个@interface中去声明。
 */

#import <Foundation/Foundation.h>

@interface NSString ()

@end
