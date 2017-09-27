//
//  AVVedioMovePlayerViewController.h
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/29.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Photos/Photos.h>
//#import <AssetsLibrary/ALAsset.h> ALAssetsLibrary-->ALAssetsGroup-->ALAsset-->ALAssetRepresentation

@interface AVVedioMovePlayerViewController : UIViewController
@property (nonatomic,strong) AVAsset *vedioAsset;
@property (nonatomic,strong) PHAsset *PHAssetVedio;

@property (nonatomic,strong) NSString *resuorcePath;
@property (nonatomic,strong) NSString *mediaType;

/**
 播放器单例

 @return 播放器单例
 */
+(id)shareVedioPlayer;

/**
 暂停播放
 */
-(void)pause;

/**
 停止播放
 */
-(void)stop;
@end
