//
//  AVAudioRecordViewController.m
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/27.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "AVAudioRecordViewController.h"
#import "UIImage+Extension.h"
#import "LXButton.h"

#define kRecordAudioFile @"myRecord.caf"

@interface AVAudioRecordViewController ()<AVAudioRecorderDelegate>
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）

@property (strong, nonatomic)  UIButton *record;//开始录音
@property (strong, nonatomic)  UIButton *pause;//暂停录音
@property (strong, nonatomic)  UIButton *resume;//恢复录音
@property (strong, nonatomic)  UIButton *stop;//停止录音
@property (strong, nonatomic)  UIProgressView *audioPower;//音频波动
@end

@implementation AVAudioRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setAudioSession];
}

-(void)setUpUI{
    UIColor *backgroundColor=[UIColor colorWithRed:35.0f/255 green:73.0f/255 blue:105.0f/255 alpha:1];
    self.view.backgroundColor=backgroundColor;
    
    UIProgressView *recordProgress=[[UIProgressView alloc]initWithFrame:CGRectMake(kHMARGIN, kSCREENHEIGHT*0.45, kSCREENWIDTH-kHMARGIN*2, 1.5f)];
    recordProgress.progress=0.1;
    recordProgress.progressTintColor=[UIColor blueColor];
    [self.view addSubview:recordProgress];
    
    
    UIImage *redDotImage=[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(30, 30)];
    LXButton *audioRecordButton=[LXButton buttonWithImage:redDotImage frame:CGRectMake(kHMARGIN*2.5f, kSCREENHEIGHT*0.86f, 60, 60) normaBackGroundColor:[UIColor clearColor] heilightBackGroundColor:[UIColor groupTableViewBackgroundColor] prohibitBackGroundColor:[UIColor lightGrayColor] buttonType:UIButtonTypeCustom];
    audioRecordButton.imageView.layer.masksToBounds=YES;
    audioRecordButton.imageView.layer.cornerRadius=audioRecordButton.imageView.frame.size.width/2;
    [audioRecordButton addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:audioRecordButton];
    
    LXButton *audioRecordPauseButton=[LXButton buttonWithImage:redDotImage frame:CGRectMake(CGRectGetMaxX(audioRecordButton.frame)+15, kSCREENHEIGHT*0.86f, 60, 60) normaBackGroundColor:[UIColor clearColor] heilightBackGroundColor:[UIColor groupTableViewBackgroundColor] prohibitBackGroundColor:[UIColor lightGrayColor] buttonType:UIButtonTypeCustom];
    [audioRecordPauseButton addTarget:self action:@selector(pauseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:audioRecordPauseButton];
    
    LXButton *audioRecordResumeButton=[LXButton buttonWithImage:redDotImage frame:CGRectMake(CGRectGetMaxX(audioRecordPauseButton.frame)+15, kSCREENHEIGHT*0.86f, 60, 60) normaBackGroundColor:[UIColor clearColor] heilightBackGroundColor:[UIColor groupTableViewBackgroundColor] prohibitBackGroundColor:[UIColor lightGrayColor] buttonType:UIButtonTypeCustom];
    [audioRecordResumeButton addTarget:self action:@selector(resumeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:audioRecordResumeButton];
    
    UIImage *whiteRectImage=[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(30, 30)];
    LXButton *audioRecordStopButton=[LXButton buttonWithImage:whiteRectImage frame:CGRectMake(CGRectGetMaxX(audioRecordResumeButton.frame)+15, kSCREENHEIGHT*0.86f, 60, 60) normaBackGroundColor:[UIColor clearColor] heilightBackGroundColor:[UIColor groupTableViewBackgroundColor] prohibitBackGroundColor:[UIColor lightGrayColor] buttonType:UIButtonTypeCustom];
    [audioRecordStopButton addTarget:self action:@selector(stopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:audioRecordStopButton];
}

#pragma mark - 私有方法
/**
 *  设置音频会话
 */
-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
-(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}


/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    [self.audioPower setProgress:progress];
}

#pragma mark - UI事件
/**
 *  点击录音按钮
 *
 *  @param sender 录音按钮
 */
- (void)recordClick:(UIButton *)sender {
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate=[NSDate distantPast];
    }
}

/**
 *  点击暂定按钮
 *
 *  @param sender 暂停按钮
 */
- (void)pauseClick:(UIButton *)sender {
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        self.timer.fireDate=[NSDate distantFuture];
    }
}

/**
 *  点击恢复按钮
 *  恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
 *
 *  @param sender 恢复按钮
 */
- (void)resumeClick:(UIButton *)sender {
    [self recordClick:sender];
}

/**
 *  点击停止按钮
 *
 *  @param sender 停止按钮
 */
- (void)stopClick:(UIButton *)sender {
    [self.audioRecorder stop];
    self.timer.fireDate=[NSDate distantFuture];
    self.audioPower.progress=0.0;
}

#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
    NSLog(@"录音完成!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
