//
//  MusicPlayerViewController.h
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/25.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface MusicPlayerViewController : UIViewController<MPMediaPickerControllerDelegate>
@property (strong, nonatomic) MPMediaPickerController *mediaPicker;//媒体选择控制器
@property (strong, nonatomic) MPMusicPlayerController *musicPlayer; //音乐播放器
//@property (nonatomic, strong) AVAudioPlayer *audioPlayer;//播放器
@property (strong, nonatomic) UIProgressView *playProgress;//播放进度
@property (strong, nonatomic) UIButton *playOrPause; //播放/暂停按钮(如果tag为0认为是暂停状态，1是播放状态)
@property (strong, nonatomic) UIButton *nextSong;//下一曲
@property (strong, nonatomic) UIButton *preSong;//上一曲
@property (strong, nonatomic) UILabel *controlPanel; //控制面板
@property (strong, nonatomic) UILabel *musicSinger; //演唱者
@property (strong, nonatomic) UIImageView *backGroundImageView;
@property (strong ,nonatomic) NSTimer *timer;//进度更新定时器

@end
