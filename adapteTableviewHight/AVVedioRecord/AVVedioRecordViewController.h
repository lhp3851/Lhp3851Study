//
//  AVVedioRecordViewController.h
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/8/1.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface AVVedioRecordViewController : UIViewController<AVCaptureFileOutputRecordingDelegate>
@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设备之间的数据传递
@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层
@property (assign,nonatomic) BOOL enableRotation;//是否允许旋转（注意在视频录制过程中禁止屏幕旋转）
@property (assign,nonatomic) CGRect *lastBounds;//旋转的前大小
@property (assign,nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifier;//后台任务标识
@property (strong, nonatomic) UIView *viewContainer;
@property (strong, nonatomic) UIButton *takeButton;//拍照按钮
@property (strong, nonatomic) UIImageView *focusCursor; //聚焦光标
@end
