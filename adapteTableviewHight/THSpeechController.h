//
//  THSpeechController.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/5/21.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface THSpeechController : NSObject
@property(nonatomic,strong,readonly)AVSpeechSynthesizer *synthesizer;

+(instancetype)speechController;
-(void)beginConversation;
@end
