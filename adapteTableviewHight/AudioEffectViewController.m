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
    [self setThePannle];
    [self playSoundEffectWithData:@"Hooded"];
    [self playSoundEffectWithData:@"06_Chimes"];
}

-(void)setThePannle{
    self.view.backgroundColor=[UIColor whiteColor];
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


-(void)playSoundEffectWithData:(NSString *)soundPath{
    NSString *filePath=[[NSBundle mainBundle] pathForResource:soundPath ofType:@"mp3"];
    NSURL *fileURL=[NSURL fileURLWithPath:filePath];
    SystemSoundID soundeID=0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileURL), &soundeID);
    AudioServicesAddSystemSoundCompletion(soundeID, nil, nil, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundeID);
    //    AudioServicesPlayAlertSound(soundeID);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
