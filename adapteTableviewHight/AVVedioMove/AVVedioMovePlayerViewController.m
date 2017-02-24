//
//  AVVedioMovePlayerViewController.m
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/29.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "AVVedioMovePlayerViewController.h"

@interface AVVedioMovePlayerViewController ()<AVPlayerViewControllerDelegate>{
    AVAudioSession              *_session;
}

/**
    三种播放视频的方式
 */
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器，insteaded by AVPlayerViewController
@property (nonatomic,strong) AVPlayerViewController *controller;
@property (nonatomic,strong) AVPlayer *vedioPlayer;

@end

@implementation AVVedioMovePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];//添加通知
    _session = [AVAudioSession sharedInstance];
    [_session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self setUpUI];
    [self play];
}

-(void)setUpUI{
    self.view.backgroundColor=[UIColor whiteColor];
}

//播放


-(void)play{
    if (kSYSYTEM_VERSION>=8.0) {
        if (self.vedioPlayer) {
            [self.vedioPlayer play];
        }
        else{
            //二选一
//            [self AVPlayerViewControllerPlayVideo];
            [self addChildViewController:self.controller];
        }
    }
    else{
        [self.moviePlayer play];
    }
}

#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"demo_large_video_share" ofType:@"mp4"];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://192.168.1.161/The New Look of OS X Yosemite.mp4";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getFileUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

-(AVPlayer *)vedioPlayer{
    if (!_vedioPlayer) {
        NSString *filePath         = [[NSBundle mainBundle] pathForResource:@"demo_large_video_share" ofType:@"mp4"];
        NSURL *sourceMovieURL      = [NSURL fileURLWithPath:filePath];
        AVAsset *movieAsset        = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        AVPlayerItem *playerItem   = [AVPlayerItem playerItemWithAsset:movieAsset];
        _vedioPlayer               = [AVPlayer playerWithPlayerItem:playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_vedioPlayer];
        playerLayer.frame          = self.view.layer.bounds;
        playerLayer.videoGravity   = AVLayerVideoGravityResizeAspect;
        [self.view.layer addSublayer:playerLayer];
    }
    return _vedioPlayer;
}

-(AVPlayerViewController *)controller{
    if (!_controller) {
        _controller        =[[AVPlayerViewController alloc]init];
        _controller.player = self.vedioPlayer;
        _controller.delegate=self;
        _controller.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _controller.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
        _controller.showsPlaybackControls = true;
        _controller.view.translatesAutoresizingMaskIntoConstraints = true;//AVPlayerViewController内部可能是用约束写的，这句可以禁用自动约束，消除报错
        _controller.view.frame = self.view.bounds;
        [self.view addSubview:_controller.view];
    }
    return _controller;
}


-(void)AVPlayerViewControllerPlayVideo{
    _controller        =[[AVPlayerViewController alloc]init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo_large_video_share" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    _controller.player = [AVPlayer playerWithURL:sourceMovieURL];
    _controller.delegate=self;
    if (_controller.readyForDisplay) {
        [self presentViewController:_controller animated:YES completion:^{
            NSLog(@"视频时长：%lld",(_controller.player.currentItem.asset.duration.value)/(_controller.player.currentItem.asset.duration.timescale));
        }];
    }
}



/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
