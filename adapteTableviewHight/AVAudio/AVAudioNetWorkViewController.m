//
//  AVAudioNetWorkViewController.m
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/27.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "AVAudioNetWorkViewController.h"
#import "FSAudioStream.h"

@interface AVAudioNetWorkViewController ()
@property (nonatomic,strong) FSAudioStream *audioStream;
@end

@implementation AVAudioNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self.audioStream play];
}

-(void)setUpUI{
    self.view.backgroundColor=[UIColor whiteColor];
    
}
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"刘若英 - 原来你也在这里.mp3" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://m5.file.xiami.com/930/1930/1194678626/1772619217_11481960_l.mp3?auth_key=0aefe2f447e880493013797a9ad58c5f-1469836800-0-null";
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建FSAudioStream对象
 *
 *  @return FSAudioStream对象
 */
-(FSAudioStream *)audioStream{
    if (!_audioStream) {
        NSURL *url=[self getNetworkUrl];
        //创建FSAudioStream对象
        _audioStream=[[FSAudioStream alloc]initWithUrl:url];
        _audioStream.onFailure=^(FSAudioStreamError error,NSString *description){
            NSLog(@"播放过程中发生错误，错误信息：%@",description);
        };
        _audioStream.onCompletion=^(){
            NSLog(@"播放完成!");
        };
        [_audioStream setVolume:0.5];//设置声音
    }
    return _audioStream;
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
