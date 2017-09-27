//
//  userModel.h
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModel : NSObject


//用户名
@property (nonatomic,copy) NSString *username;
//介绍
@property (nonatomic,copy) NSString *introduction;
//头像图片路径
@property (nonatomic,copy) NSString *imagePath;

@end
