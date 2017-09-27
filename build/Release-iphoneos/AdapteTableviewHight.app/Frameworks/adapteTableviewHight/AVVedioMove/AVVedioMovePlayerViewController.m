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
//视频播放控制器，NS_CLASS_DEPRECATED_IOS(2.0,9.0,"insteaded by AVPlayerViewController");
//NS_CLASS_DEPRECATED_IOS(2.0,9.0,"insteaded by AVPlayerViewController");
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic,strong) AVPlayerViewController  *controller;
@property (nonatomic,strong) AVPlayer                *vedioPlayer;

//播放控制状态
@property(nonatomic,assign)CMTime currentPlayTime;

@end

@implementation AVVedioMovePlayerViewController

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_vedioPlayer pause];
    _vedioPlayer=nil;
}

+(id)shareVedioPlayer{
    static AVVedioMovePlayerViewController *playerVC=nil;
    static dispatch_once_t oneceT;
    dispatch_once(&oneceT, ^{
        playerVC=[AVVedioMovePlayerViewController new];
    });
    return playerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];//添加通知
    _session = [AVAudioSession sharedInstance];
    [_session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self setUpUI];
}

-(void)setUpUI{
    self.view.backgroundColor=[UIColor whiteColor];
}

/**
 播放 Asset
 
 @param vedioAsset 视频Asset
 */
-(void)setVedioAsset:(AVAsset *)vedioAsset{
    _vedioAsset=vedioAsset;
}

/**
 播放资源，视频路径
 
 @param type 视频类型
 */
-(void)setResuorcePath:(NSString *)resuorcePath{
    _resuorcePath=resuorcePath;
}

/**
 播放资源，视频类型
 
 @param type 视频类型
 */
-(void)setMediaType:(NSString *)mediaType{
    _mediaType   =mediaType;
}

/**
 PHAsset 转化为 AVAsset

 @param PHAssetVedio 设置的 AVAsset
 */
-(void)setPHAssetVedio:(PHAsset *)PHAssetVedio{
    _PHAssetVedio=PHAssetVedio;
    [self AVAssetWithPHAsset:_PHAssetVedio];
}

-(void )AVAssetWithPHAsset:(PHAsset *)phAsset{
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version      = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        _vedioAsset=asset;
        [self play];
    }];
}

#pragma mark - 获取文件路径
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrlWithPath:(NSString *)path type:(NSString *)type{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:path ofType:type];//@"demo_large_video_share"_@"mp4"
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr=self.resuorcePath;//@"http://192.168.1.161/The New Look of OS X Yosemite.mp4";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 根据文件路径——文件类型获取AVAsset

 @param path 文件路径
 @param type 文件类型
 @return AVAsset
 */
-(AVAsset *)vedioAssetWithURL:(NSString *)path type:(NSString *)type{
    NSURL *sourceMovieURL      = [self getFileUrlWithPath:path type:type];
    AVAsset *movieAsset        = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    return movieAsset;
}
#pragma mark 播放器播放视频
/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        _moviePlayer=[[MPMoviePlayerController alloc]init];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

#pragma mark AVPlayer AVPlayerViewController
/**
 当前控制器子视图方式播放

 @return AVPlayer
 */
-(AVPlayer *)vedioPlayer{
    if (!_vedioPlayer) {
        AVAsset *movieAsset        = self.vedioAsset!=nil?self.vedioAsset:[self vedioAssetWithURL:self.resuorcePath type:self.mediaType];
        AVPlayerItem *playerItem   = [AVPlayerItem playerItemWithAsset:movieAsset];
        _vedioPlayer               = [AVPlayer playerWithPlayerItem:playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_vedioPlayer];
        playerLayer.frame          = (CGRect){0,kNAVIGATION_BAR_HEIGHT+kSTATUS_BAR_HEIGHT,kSCREENWIDTH,kSCREENHEIGHT/2};
        playerLayer.videoGravity   = AVLayerVideoGravityResizeAspect;
        [self.view.layer addSublayer:playerLayer];
    }
    return _vedioPlayer;
}

/**
 模态视图方式播放
 */
-(void)AVPlayerViewControllerPlayVideo{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self.resuorcePath ofType:self.mediaType];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    self.controller.player = [AVPlayer playerWithURL:sourceMovieURL];
    self.controller.delegate=self;
    if (self.controller.readyForDisplay) {
        [self presentViewController:self.controller animated:YES completion:^{
            NSLog(@"视频时长：%lld",(self.controller.player.currentItem.asset.duration.value)/(self.controller.player.currentItem.asset.duration.timescale));
        }];
    }
}

/**
 播放控制器子视图方式播放
 
 @return AVPlayerViewController
 */
-(AVPlayerViewController *)controller{
    if (!_controller) {
        _controller              =[[AVPlayerViewController alloc]init];
        _controller.player       = self.vedioPlayer;
        _controller.delegate     = self;
        _controller.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _controller.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
        _controller.showsPlaybackControls          = true;
        
        _controller.view.translatesAutoresizingMaskIntoConstraints = YES;//AVPlayerViewController内部可能是用约束写的，这句可以禁用自动约束，消除报错
//        _controller.view.frame   = self.view.bounds;
//        [self.view addSubview:_controller.view];
        [self addChildViewController:_controller];
    }
    return _controller;
}


//（恢复/重新）播放
-(void)play{
    if ((!self.vedioAsset)&&(!(self.resuorcePath||self.mediaType))) {
        return;
    }
    
    if (kSYSYTEM_VERSION>9.0) {
        if (self.controller) {
            //            [self AVPlayerViewControllerPlayVideo];//presentVC
            [self.controller.player play];//addChildVC
        }
        else {
            [self.vedioPlayer play];
        }
        
    }
    else{
        self.moviePlayer.contentURL=[self getFileUrlWithPath:self.resuorcePath type:self.mediaType];
        [self.moviePlayer play];
    }
}

/**
 暂停播放
 */
-(void)pause{
    self.currentPlayTime = _vedioPlayer.currentTime;
    [_vedioPlayer pause];
    [_moviePlayer pause];
}

/**
 停止播放
 */
-(void)stop{
    if (_moviePlayer.playbackState==MPMoviePlaybackStatePlaying||_moviePlayer.playbackState==MPMoviePlaybackStatePaused) {
        [_moviePlayer stop];
    }
    self.currentPlayTime=CMTimeMake(0, 0);
    [_vedioPlayer pause];
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

#pragma mark 通知管理
/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:_moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayer];
}
/**
 *移除所有通知监控
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_vedioPlayer pause];
    _vedioPlayer=nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
