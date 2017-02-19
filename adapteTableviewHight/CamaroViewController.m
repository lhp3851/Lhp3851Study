//
//  CamaroViewController.m
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2016/11/1.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#import "CamaroViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CamaroViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic,strong)UIView *scanRectView;
@property(nonatomic,strong)AVCaptureDevice *device;
@property(nonatomic,strong)AVCaptureDeviceInput *inPut;
@property(nonatomic,strong)AVCaptureMetadataOutput *outPut;
@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation CamaroViewController

-(UIView *)scanRectView{
    if (!_scanRectView) {
        CGSize windowSize = [UIScreen mainScreen].bounds.size;
        CGSize scanSize = CGSizeMake(windowSize.width*3/4, windowSize.width*3/4);
        self.scanRectView = [UIView new];
        self.scanRectView.frame = CGRectMake(0, 0, scanSize.width, scanSize.height);
        self.scanRectView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
        self.scanRectView.layer.borderColor = [UIColor redColor].CGColor;
        self.scanRectView.layer.borderWidth = 1;
        [self.view addSubview:self.scanRectView];
    }
    return _scanRectView;
}

-(AVCaptureDevice *)device{
    if (!_device) {
        _device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}


-(AVCaptureInput *)inPut{
    if (!_inPut) {
        NSError *error=[NSError errorWithDomain:@"input.app" code:3344 userInfo:@{}];
        _inPut=[AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    }
    return _inPut;
}

-(AVCaptureOutput *)outPut{
    if (!_outPut) {
        CGSize windowSize = [UIScreen mainScreen].bounds.size;
        CGSize scanSize = CGSizeMake(windowSize.width*3/4, windowSize.width*3/4);
        CGRect scanRect = CGRectMake((windowSize.width-scanSize.width)/2, (windowSize.height-scanSize.height)/2, scanSize.width, scanSize.height);
        //计算rectOfInterest 注意x,y交换位置
        scanRect = CGRectMake(scanRect.origin.y/windowSize.height, scanRect.origin.x/windowSize.width, scanRect.size.height/windowSize.height,scanRect.size.width/windowSize.width);
        _outPut=[[AVCaptureMetadataOutput alloc]init];
        self.outPut.rectOfInterest = scanRect;
        [_outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _outPut;
}

-(AVCaptureSession *)session{
    if (!_session) {
        _session=[[AVCaptureSession alloc]init];
        [_session setSessionPreset:([UIScreen mainScreen].bounds.size.height<500)?AVCaptureSessionPreset640x480:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.inPut]) {
            [_session addInput:self.inPut];
        }
        if ([_session canAddOutput:self.outPut]) {
            [_session addOutput:self.outPut];
            [self.outPut setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        }
    }
    return _session;
}

-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
        [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        _previewLayer.frame = [UIScreen mainScreen].bounds;
        [_previewLayer setFrame:CGRectMake(self.view.center.x-100,self.view.center.y-100, 200,200)];
    }
    return _previewLayer;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)capturePhoto:(id)sender{
    
}


-(IBAction)captureVedio:(id)sender{
    
}


-(IBAction)scanQRCode:(id)sender{
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    [self.session startRunning];
}


#pragma mark 二维码扫描
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ( (metadataObjects.count==0) )
    {
        return;
    }
    
    if (metadataObjects.count>0) {
        
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        //输出扫描字符串
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:metadataObject.stringValue message:@"" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.session stopRunning];
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
