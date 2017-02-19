//
//  archiveData.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/10/18.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface archiveData : NSObject<NSCoding>//遵守归档协议
{
//    NSString *name;//待归档类型
}

@property(copy,nonatomic) NSString *name;
@property(assign,nonatomic) int age;
@property(assign,nonatomic) double  weight;
@property(copy,nonatomic) NSArray *hobby;
@property(copy,nonatomic) NSDictionary *others;

@end
