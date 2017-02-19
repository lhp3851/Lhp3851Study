//
//  QRCodeViewController.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/25.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRCodeViewController : UIViewController

@property(nonatomic,strong)AVCaptureDevice *Device;

@property(nonatomic,strong)AVCaptureDeviceInput *input;

@property(nonatomic,strong)AVCaptureMetadataOutput *output;

@property(nonatomic,strong)AVCaptureSession *session;

@property(nonatomic,strong)AVCaptureVideoPreviewLayer *preLayer;


@end
