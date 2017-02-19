//
//  AudioEffectViewController.m
//  AdapteTableviewHight
//
//  Created by lhp3851 on 16/7/24.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#import "AudioEffectViewController.h"

@interface AudioEffectViewController ()

@end

@implementation AudioEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self playSoundEffect:@"Hooded"];
}

/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}

-(void)playSoundEffect:(NSString *)soundFileName{
    NSString *filePath=[[NSBundle mainBundle] pathForResource:soundFileName ofType:@"mp3"];
    NSURL *fileURL=[NSURL URLWithString:filePath];
    SystemSoundID soundID=0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(fileURL), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
//    AudioServicesPlaySystemSound(soundID);
    AudioServicesPlayAlertSound(soundID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
