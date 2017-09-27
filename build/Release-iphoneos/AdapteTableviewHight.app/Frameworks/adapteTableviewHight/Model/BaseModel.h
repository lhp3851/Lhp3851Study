//
//  BaseModel.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/4/6.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <Foundation/Foundation.h>
//什么类型的数据
typedef enum : NSUInteger {
    ModelTypeNormal,
    ModelTypeNews,
    ModelTypeShops,
} ModelType;

@interface BaseModel : NSObject
@property (nonatomic, assign) NSInteger rtnCode;
@property (nonatomic, assign) ModelType type;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) id data;
@end
