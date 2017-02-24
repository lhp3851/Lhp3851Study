//
//  AVAudioMusicViewController.m
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/25.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "AVAudioMusicViewController.h"


#define kMusicFile @"原来你也在这里-刘若英.mp3"
#define kMusicSinger @"刘若英"
#define kMusicTitle @"原来你也在这里"

@interface AVAudioMusicViewController ()

@end

@implementation AVAudioMusicViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开启远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioInterrupted:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    //[self resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    self.title=kMusicTitle;
    self.view.backgroundColor=[UIColor whiteColor];
    self.musicSinger.text=kMusicSinger;

    [self.view addSubview:self.backGroundImageView];
    [self.view addSubview:self.playProgress];
    [self.view addSubview:self.playOrPause];
    [self.view addSubview:self.controlPanel];
    [self.view addSubview:self.musicSinger];
}

-(UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        _backGroundImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"RuoyingLiu3.jpg"]];
        _backGroundImageView.frame=CGRectMake(0, kSTATUS_BAR_HEIGHT+kNAVIGATION_BAR_HEIGHT, kSCREENWIDTH, kSCREENHEIGHT-kSTATUS_BAR_HEIGHT-kNAVIGATION_BAR_HEIGHT);
    }
    return _backGroundImageView;
}

-(UILabel *)musicSinger{
    if (!_musicSinger) {
        _musicSinger=[[UILabel alloc]initWithFrame:CGRectMake(kHMARGIN, kSCREENHEIGHT*0.85f-30, kSCREENWIDTH*0.3, 20)];
        _musicSinger.font=kSYSTEM_FONT_VERSION(14);
        _musicSinger.textColor=[UIColor blueColor];
    }
    return _musicSinger;
}

-(UIProgressView *)playProgress{
    if (!_playProgress) {
        _playProgress=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _playProgress.frame=CGRectMake(0, kSCREENHEIGHT*0.85f, kSCREENWIDTH, 3.0f);
        _playProgress.progressTintColor=[UIColor blueColor];
        _playProgress.trackTintColor=[UIColor whiteColor];
        _playProgress.progress=0.5;
    }
    return _playProgress;
}


-(UIButton *)playOrPause{
    if (!_playOrPause) {
        _playOrPause=[UIButton buttonWithType:UIButtonTypeCustom];
        _playOrPause.frame=CGRectMake(self.view.center.x-30, CGRectGetMaxY(_playProgress.frame)+15, 60, 60);
        _playOrPause.layer.masksToBounds=YES;
        _playOrPause.layer.cornerRadius=_playOrPause.frame.size.height/2;
        _playOrPause.backgroundColor=[UIColor blackColor];
        [_playOrPause addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playOrPause;
}

-(UILabel *)controlPanel{
    if (!_controlPanel) {
        
    }
    return _controlPanel;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:true];
    }
    return _timer;
}

/**
 *  创建播放器
 *
 *  @return 音频播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSString *urlStr=[[NSBundle mainBundle]pathForResource:kMusicFile ofType:nil];
        NSURL *url=[NSURL fileURLWithPath:urlStr];
        NSError *error=nil;
        //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        //设置播放器属性
        _audioPlayer.numberOfLoops=0;//设置为0不循环
        _audioPlayer.delegate=self;
        [_audioPlayer prepareToPlay];//加载音频文件到缓存
        if(error){
            NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
            return nil;
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChange:) name:AVAudioSessionRouteChangeNotification object:nil];
    }
    return _audioPlayer;
}

/**
 *  播放音频
 */
-(void)play{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
        self.timer.fireDate=[NSDate distantPast];//恢复定时器
    }
}

/**
 *  暂停播放
 */
-(void)pause{
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer pause];
        self.timer.fireDate=[NSDate distantFuture];//暂停定时器，注意不能调用invalidate方法，此方法会取消，之后无法恢复
    }
}

/**
 *  点击播放/暂停按钮
 *
 *  @param sender 播放/暂停按钮
 */
- (void)playClick:(UIButton *)sender {
    if(sender.tag){
        sender.tag=0;
        [sender setImage:[UIImage imageNamed:@"playing_btn_play_n"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"playing_btn_play_h"] forState:UIControlStateHighlighted];
        [self pause];
    }else{
        sender.tag=1;
        [sender setImage:[UIImage imageNamed:@"playing_btn_pause_n"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"playing_btn_pause_h"] forState:UIControlStateHighlighted];
        [self play];
    }
}

/**
 *  更新播放进度
 */
-(void)updateProgress{
    float progress= self.audioPlayer.currentTime /self.audioPlayer.duration;
    [self.playProgress setProgress:progress animated:true];
}


#pragma mark AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"播放完成");
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    NSLog(@"播放被打断");
    [self pause];
}


- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player{
    NSLog(@"播放被打断后继续");
    [self play];
}


//通知的方式处理中断，继续播放会从头开始，而上面代理（iOS 2.0~8.0）的方式不会
-(void)audioInterrupted:(NSNotification *)notification{
    NSDictionary *info=notification.userInfo;
    AVAudioSessionInterruptionType type=[info[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    if (type==AVAudioSessionInterruptionTypeBegan) {
        [self pause];
    }
    else{
        [self play];
    }
}


#pragma AudioRouteChanged
-(void)audioRouteChange:(NSNotification *)notification{
    NSDictionary *dic=notification.userInfo;
    int changeReason= [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            [self pause];
        }
    }
    else if (changeReason==AVAudioSessionRouteChangeReasonNewDeviceAvailable){
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Speaker"]) {
            [self play];
        }
    }
    else{
        [self pause];
    }
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@:%@",key,obj);
    }];
}

//received remote event
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    NSLog(@"event tyipe:::%ld   subtype:::%ld",event.type,event.subtype);
    //type==2  subtype==单击暂停键：103，双击暂停键104
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:{
                NSLog(@"play---------");
            }break;
            case UIEventSubtypeRemoteControlPause:{
                NSLog(@"Pause---------");
            }break;
            case UIEventSubtypeRemoteControlStop:{
                NSLog(@"Stop---------");
            }break;
            case UIEventSubtypeRemoteControlTogglePlayPause:{
                //单击暂停键：103
                NSLog(@"单击暂停键：103");
                if (self.audioPlayer.isPlaying) {
                    [self pause];
                }
                else{
                    [self play];
                }
            }break;
            case UIEventSubtypeRemoteControlNextTrack:{
                //双击暂停键：104
                NSLog(@"双击暂停键：104");
            }break;
            case UIEventSubtypeRemoteControlPreviousTrack:{
                NSLog(@"三击暂停键：105");
            }break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:{
                NSLog(@"单击，再按下不放：108");
            }break;
            case UIEventSubtypeRemoteControlEndSeekingForward:{
                NSLog(@"单击，再按下不放，松开时：109");
            }break;
            default:
                break;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
