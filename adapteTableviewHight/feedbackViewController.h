//
//  feedbackViewController.h
//  adapteTableviewHight
//
//  Created by ZizTour on 6/3/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"
#import "UMFeedbackViewController.h"
#import "UMPostTableViewCell.h"
#import "mapViewController.h"
#import "delegateAndBlockViewController.h"
#import "QRCodeViewController.h"
#import "THSpeechController.h"

@interface feedbackViewController : UIViewController<ChatViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *locationServic;
@property (weak, nonatomic) IBOutlet UIButton *feedback;
@property (weak, nonatomic) IBOutlet UIButton *inputHandleButton;
//定位
-(IBAction)locationService:(id)sender;
//友盟反馈
-(IBAction)userFeedback:(id)sender;
//第三方输入法处理
-(IBAction)inputHandleButton:(id)sender;
//新浪微博
-(IBAction)sinaWeiBo:(id)sender;
//去AppStore评分
-(IBAction)goToComment:(id)sender;
//代理和block
-(IBAction)delegateAndBlock:(id)sender;
//原生二维码扫描
-(IBAction)QRCodeScane:(id)sender;
//视图类
-(IBAction)ClassOfViews:(id)sender;
//archiveData
-(IBAction)archiveData:(id)sender;
//趣味数学题
-(IBAction)intrestMathmticQuestion:(id)sender;
//alerViewController
-(IBAction)alertViewController:(id)sender;
//CrashLog
-(IBAction)crashLog:(id)sender;
//scrollView
-(IBAction)scrollView:(id)sender;
//打开APP
-(IBAction)openApp:(id)sender;
//AFNetReachTest
-(IBAction)AFNetReachTest:(id)sender;
//AVFoundation
-(IBAction)AVFoundation:(id)sender;
//日期处理
-(IBAction)dateHandler:(id)sender;
//水波纹动画
-(IBAction)moireAnimation:(id)sender;
//音效
-(IBAction)palySoundEffect:(id)sender;
//通知
-(IBAction)notificaion:(id)sender;
//警告
-(IBAction)AlertControoler:(id)sender;
//相机📷
-(IBAction)camera:(id)sender;
//相册
-(IBAction)photos:(id)sender;
@end
