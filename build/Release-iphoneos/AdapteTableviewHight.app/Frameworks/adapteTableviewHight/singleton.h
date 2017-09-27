//
//  singleton.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/23.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

/*
 %@ 对象
 
 %d,%i 整型 (%i的老写法)
 
 %hd 短整型
 
 %ld , %lld 长整型
 
 %u 无符整型
 
 %f 浮点型和double型
 
 %0.2f 精度浮点数，只保留两位小数
 
 %x:    为32位的无符号整型数(unsigned int),打印使用数字0-9的十六进制,小写a-f;
 
 %X:    为32位的无符号整型数(unsigned int),打印使用数字0-9的十六进制,大写A-F;
 
 %o 八进制
 
 %zu size_t
 
 %p 指针地址
 
 %e float/double （科学计算）
 
 %g float/double （科学技术法）
 
 %s char *  字符串
 
 %.*s Pascal字符串
 
 %c char 字符
 
 %C unichar
 
 %Lf 64位double
 
 %lu sizeof(i)内存中所占字节数
 
 打印CGRect : NSLog(@"%@",NSStringFromCGRect(someCGRect)); 或者CFShow(NSStringFromCGRect(someCGRect));
 
 打印CGSize: NSLog(@"%@",NSStringFromCGSize(someCG Size ));

 */

#import <Foundation/Foundation.h>

@interface singleton : NSObject


+(singleton *)getInsistance;
//第二种获取单例的方法
+(singleton *)sharedManager;

@end
