//
//  VedioTool.h
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/2/28.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^compressCompletedHandler) (NSString *outPutPath,BOOL status);
@interface VedioTool : NSObject

+(void)convertVedio:(id)vedio ToFormateType:(NSString *)type handler:(compressCompletedHandler)handler;

@end
