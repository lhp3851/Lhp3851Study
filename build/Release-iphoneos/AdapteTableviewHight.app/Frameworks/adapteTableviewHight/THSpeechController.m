//
//  THSpeechController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/5/21.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "THSpeechController.h"

@interface THSpeechController ()

@property(strong,nonatomic)AVSpeechSynthesizer *synthesizer;
@property(strong,nonatomic)NSArray *voices;
@property(strong,nonatomic)NSArray *speechString;
@end

@implementation THSpeechController
+(instancetype)speechController{
    return [[self alloc]init];
}

-(id)init{
    self=[super init];
    if (self) {
        _synthesizer=[[AVSpeechSynthesizer alloc]init];
        
        _voices=@[[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                  [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"]];
        
        _speechString=[self buildSpeechString];
    }
    return self;
}

-(NSArray *)buildSpeechString{
    return @[@"Hello AV Foundation.How are you?",
             @"I'm well! Thanks for asking.",
             @"Are you excited about the book?",
             @"Very! I have always felt so misunderstood.",
             @"What's your favorate feature?",
             @"Oh, They're all my babies. I couldn't possibly choose.",
             @"It was great to speak to you!",
             @"The pleasure was all mine! Have fun!"];
}

-(void)beginConversation{
    for (NSUInteger i=0; i<self.speechString.count; i++) {
        AVSpeechUtterance *utterance=[[AVSpeechUtterance alloc]initWithString:_speechString[i]];
        utterance.voice=self.voices[i%2];
        utterance.rate=0.4f;
        utterance.pitchMultiplier=0.8f;
        utterance.postUtteranceDelay=0.1f;
        [self.synthesizer speakUtterance:utterance];
    }
}

@end
