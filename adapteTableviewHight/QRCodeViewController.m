//
//  QRCodeViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/25.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

/**
 当一个视图控制器被创建，并在屏幕上显示的时候。 代码的执行顺序
 
 1、 alloc                       创建对象，分配空间
 
 2、init (initWithNibName)       初始化对象，初始化数据
 
 3、loadView                     从nib载入视图 ，通常这一步不需要去干涉。除非你没有使用xib文件创建视图
 
 4、viewDidLoad                  载入完成，可以进行自定义数据以及动态创建其他控件
 
 5、viewWillAppear               视图将出现在屏幕之前，马上这个视图就会被展现在屏幕上了
 
 6、viewDidAppear                视图已在屏幕上渲染完成当一个视图被移除屏幕并且销毁的时候的执行顺序，这个顺序差不多和上面的相反
 
 1、viewWillDisappear            视图将被从屏幕上移除之前执行
 
 2、viewDidDisappear             视图已经被从屏幕上移除，用户看不到这个视图了
 
 3、dealloc                      视图被销毁，此处需要对你在init和viewDidLoad中创建的对象进行释放
 */

#import "QRCodeViewController.h"
#import "QRCodeREsultViewController.h"
#import "NSObject_extra.h"

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>


@end

@implementation QRCodeViewController

@synthesize Device,input,output,session,preLayer;


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (session!=nil) {
        [session startRunning];
    }
}

-(id)init{
    self=[super init];
    if (self) {
        if (session!=nil) {
            [session startRunning];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[self getDeviceHardware]);
    [self setTheDeviceIntilaEnviroment];
}


-(void)setTheDeviceIntilaEnviroment{
    
    NSError *error;
    Device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    input=[AVCaptureDeviceInput deviceInputWithDevice:self.Device error:&error];
    
    output=[[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    [ output setRectOfInterest : CGRectMake (( 124 )/ screenHight ,(( screenWidth - 220 )/ 2 )/ screenWidth , 220 / screenHight , 220 / screenWidth )];
    
    session=[[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,
                                 AVMetadataObjectTypePDF417Code,
                                 AVMetadataObjectTypeEAN13Code,
                                 AVMetadataObjectTypeEAN8Code,
                                 AVMetadataObjectTypeCode128Code,
                                 AVMetadataObjectTypeUPCECode,
                                 AVMetadataObjectTypeCode39Code,
                                 AVMetadataObjectTypeCode39Mod43Code,
                                 AVMetadataObjectTypeCode93Code,
                                 AVMetadataObjectTypeAztecCode,
                                 AVMetadataObjectTypeInterleaved2of5Code,
                                 AVMetadataObjectTypeITF14Code,
                                 AVMetadataObjectTypeDataMatrixCode];
    
    preLayer=[AVCaptureVideoPreviewLayer layerWithSession:session];
    preLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    preLayer.frame =CGRectMake(20,130,280,280);
    self.view.layer.backgroundColor=[UIColor whiteColor].CGColor;
    [self.view.layer insertSublayer:preLayer atIndex:0];
//    [self.view.layer addSublayer:preLayer];//区别
}

#pragma AVCaptureMetadataOutputObjectsDelegate mark
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue=nil;
    
    if (metadataObjects.count>0) {
        [session stopRunning];
        
        AVMetadataMachineReadableCodeObject *object=[metadataObjects objectAtIndex:0];
        
        stringValue=object.stringValue;
        
        NSLog(@"扫描结果：%@",stringValue);
        
        QRCodeREsultViewController *QRCodeResultVC=[[QRCodeREsultViewController alloc]init];
        QRCodeResultVC.URLString=stringValue;
        [self.navigationController pushViewController:QRCodeResultVC animated:YES];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
