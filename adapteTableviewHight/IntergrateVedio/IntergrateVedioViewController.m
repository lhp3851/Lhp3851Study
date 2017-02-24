//
//  IntergrateVedioViewController.m
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/8/3.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import "IntergrateVedioViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface IntergrateVedioViewController ()

@end

@implementation IntergrateVedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self combVideos];
}

//Obj-c
- (void)combVideos {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *firstVideo = [mainBundle pathForResource:@"VID_20111202_200114" ofType:@"3gp"];
    NSString *secondVideo = [mainBundle pathForResource:@"VID_20120223_091825" ofType:@"3gp"];
    
    NSDictionary *optDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVAsset *firstAsset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:firstVideo] options:optDict];
    AVAsset *secondAsset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:secondVideo] options:optDict];
    
    AVMutableComposition *composition = [AVMutableComposition composition];
    //为视频类型的的Track
    AVMutableCompositionTrack *compositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    //由于没有计算当前CMTime的起始位置，现在插入0的位置,所以合并出来的视频是后添加在前面，可以计算一下时间，插入到指定位置
    //CMTimeRangeMake 指定起去始位置
    CMTimeRange firstTimeRange = CMTimeRangeMake(kCMTimeZero, firstAsset.duration);
    CMTimeRange secondTimeRange = CMTimeRangeMake(kCMTimeZero, secondAsset.duration);
    [compositionTrack insertTimeRange:secondTimeRange ofTrack:[secondAsset tracksWithMediaType:AVMediaTypeVideo][0] atTime:kCMTimeZero error:nil];
    [compositionTrack insertTimeRange:firstTimeRange ofTrack:[firstAsset tracksWithMediaType:AVMediaTypeVideo][0] atTime:kCMTimeZero error:nil];
    
    //只合并视频，导出后声音会消失，所以需要把声音插入到混淆器中
    //添加音频,添加本地其他音乐也可以,与视频一致
    AVMutableCompositionTrack *audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    [audioTrack insertTimeRange:secondTimeRange ofTrack:[firstAsset tracksWithMediaType:AVMediaTypeAudio][0] atTime:kCMTimeZero error:nil];
    [audioTrack insertTimeRange:firstTimeRange ofTrack:[firstAsset tracksWithMediaType:AVMediaTypeAudio][0] atTime:kCMTimeZero error:nil];
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"comp.3gp"];
    AVAssetExportSession *exporterSession = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetHighestQuality];
    exporterSession.outputFileType = AVFileTypeMPEG4;
    exporterSession.outputURL = [NSURL fileURLWithPath:filePath]; //如果文件已存在，将造成导出失败
    exporterSession.shouldOptimizeForNetworkUse = YES; //用于互联网传输
    [exporterSession exportAsynchronouslyWithCompletionHandler:^{
        switch (exporterSession.status) {
            case AVAssetExportSessionStatusUnknown:
                NSLog(@"exporter Unknow");
                break;
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"exporter Canceled");
                break;
            case AVAssetExportSessionStatusFailed:
                NSLog(@"exporter Failed");
                break;
            case AVAssetExportSessionStatusWaiting:
                NSLog(@"exporter Waiting");
                break;
            case AVAssetExportSessionStatusExporting:
                NSLog(@"exporter Exporting");
                break;
            case AVAssetExportSessionStatusCompleted:
                NSLog(@"exporter Completed");
                break;
        }
    }];
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
