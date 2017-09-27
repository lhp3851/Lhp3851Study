//
//  MusicPlayerViewController.m
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/25.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "MusicPlayerViewController.h"

@interface MusicPlayerViewController ()

@end

@implementation MusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"音乐播放器";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"曲库" style:UIBarButtonItemStyleDone target:self action:@selector(selectSongFromeSongLibrary:)];
    
    [self setUpUI];
}

-(void)setUpUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.musicSinger.text=@"歌手名字";
    [self.view addSubview:self.backGroundImageView];
    [self.view addSubview:self.playProgress];
    [self.view addSubview:self.playOrPause];
    [self.view addSubview:self.controlPanel];
    [self.view addSubview:self.musicSinger];
}

-(UIImageView *)backGroundImageView{
    if (!_backGroundImageView) {
        _backGroundImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"RuoyingLiu.jpg"]];
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
 *  获得音乐播放器
 *
 *  @return 音乐播放器
 */
-(MPMusicPlayerController *)musicPlayer{
    if (!_musicPlayer) {
        _musicPlayer=[MPMusicPlayerController systemMusicPlayer];
        [_musicPlayer beginGeneratingPlaybackNotifications];//开启通知，否则监控不到MPMusicPlayerController的通知
        [self addNotification];//添加通知
        //如果不使用MPMediaPickerController可以使用如下方法获得音乐库媒体队列
        //[_musicPlayer setQueueWithItemCollection:[self getLocalMediaItemCollection]];
    }
    return _musicPlayer;
}

/**
 *  创建媒体选择器
 *
 *  @return 媒体选择器
 */
-(MPMediaPickerController *)mediaPicker{
    if (!_mediaPicker) {
        //初始化媒体选择器，这里设置媒体类型为音乐，其实这里也可以选择视频、广播等
        //        _mediaPicker=[[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeMusic];
        _mediaPicker=[[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeAny];
        _mediaPicker.allowsPickingMultipleItems=YES;//允许多选
        //        _mediaPicker.showsCloudItems=YES;//显示icloud选项
        _mediaPicker.prompt=@"请选择要播放的音乐";
        _mediaPicker.delegate=self;//设置选择器代理
    }
    return _mediaPicker;
}


/**
 *  取得媒体队列
 *
 *  @return 媒体队列
 */
-(MPMediaQuery *)getLocalMediaQuery{
    MPMediaQuery *mediaQueue=[MPMediaQuery artistsQuery];
    for (MPMediaItem *item in mediaQueue.items) {
        NSLog(@"标题：%@,%@",item.title,item.albumTitle);
    }
    return mediaQueue;
}




/**
 *  取得媒体集合
 *
 *  @return 媒体集合
 */
-(MPMediaItemCollection *)getLocalMediaItemCollection{
    MPMediaQuery *mediaQueue=[MPMediaQuery songsQuery];
    NSMutableArray *array=[NSMutableArray array];
    for (MPMediaItem *item in mediaQueue.items) {
        [array addObject:item];
        NSLog(@"标题：%@,%@",item.title,item.albumTitle);
    }
    MPMediaItemCollection *mediaItemCollection=[[MPMediaItemCollection alloc]initWithItems:[array copy]];
    return mediaItemCollection;
}

#pragma mark - MPMediaPickerController代理方法
-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    MPMediaItem *mediaItem=[mediaItemCollection.items firstObject];//第一个播放音乐
    //注意很多音乐信息如标题、专辑、表演者、封面、时长等信息都可以通过MPMediaItem的valueForKey:方法得到,但是从iOS7开始都有对应的属性可以直接访问
    //    NSString *title= [mediaItem valueForKey:MPMediaItemPropertyAlbumTitle];
    //    NSString *artist= [mediaItem valueForKey:MPMediaItemPropertyAlbumArtist];
    //    MPMediaItemArtwork *artwork= [mediaItem valueForKey:MPMediaItemPropertyArtwork];
    //UIImage *image=[artwork imageWithSize:CGSizeMake(100, 100)];//专辑图片
    NSLog(@"标题：%@,表演者：%@,专辑：%@",mediaItem.title ,mediaItem.artist,mediaItem.albumTitle);
    [self.musicPlayer setQueueWithItemCollection:mediaItemCollection];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//取消选择
-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 通知
/**
 *  添加通知
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(playbackStateChange:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.musicPlayer];
}

/**
 *  播放状态改变通知
 *
 *  @param notification 通知对象
 */
-(void)playbackStateChange:(NSNotification *)notification{
    switch (self.musicPlayer.playbackState) {
        case MPMusicPlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMusicPlaybackStatePaused:
            NSLog(@"播放暂停.");
            break;
        case MPMusicPlaybackStateStopped:
            NSLog(@"播放停止.");
            break;
        default:
            break;
    }
}

-(void)updateProgress{
    NSLog(@"进度改变");
    float progress=self.musicPlayer.currentPlaybackTime/self.musicPlayer.nowPlayingItem.playbackDuration;
    [self.playProgress setProgress:progress animated:YES];
}

#pragma mark - UI事件
- (void)selectSongFromeSongLibrary:(UIButton *)sender {
    [self presentViewController:self.mediaPicker animated:YES completion:^{
        NSLog(@"打开音乐库");
        [self getLocalMediaQuery];
    }];
}

- (void)playClick:(UIButton *)sender {
    MPMediaQuery *queryItems=[self getLocalMediaQuery];
    MPMediaItemCollection *queryItemsCollection=[self getLocalMediaItemCollection];
    NSLog(@"%@,%@",queryItems,queryItemsCollection);
    if (self.musicPlayer.playbackState==MPMusicPlaybackStatePlaying) {
        [self.musicPlayer pause];
        self.timer.fireDate=[NSDate distantFuture];//恢复定时器
    }
    else{
        [self.musicPlayer play];
        self.timer.fireDate=[NSDate distantPast];//恢复定时器
    }
}

- (void)puaseClick:(UIButton *)sender {
    [self.musicPlayer pause];
}

- (void)stopClick:(UIButton *)sender {
    [self.musicPlayer stop];
}

- (void)nextClick:(UIButton *)sender {
    [self.musicPlayer skipToNextItem];
}

- (void)prevClick:(UIButton *)sender {
    [self.musicPlayer skipToPreviousItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.musicPlayer endGeneratingPlaybackNotifications];//音乐播放器停止接受通知
    
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
