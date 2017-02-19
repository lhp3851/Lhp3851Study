//
//  feedbackViewController.m
//  adapteTableviewHight
//
//  Created by ZizTour on 6/3/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import "feedbackViewController.h"
#import "thirdInputHandleViewController.h"
#import "sinaWeiBoTableViewController.h"
#import "UIVisibleViewViewController.h"
#import "archiveDataViewController.h"
#import "intrestMathmticQuestionViewController.h"
#import "CrashLogViewController.h"
#import "UIControlViewController.h"
#import "DateToolViewController.h"
#import "MoireViewController.h"
#import "AFNetworking.h"
#import "AudioEffectViewController.h"
#import "NotificationViewController.h"
#import "AlertViewController.h"
#import "CamaroViewController.h"

@interface feedbackViewController ()

@end

@implementation feedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.feedback.layer.cornerRadius=3;
    
    
}

-(IBAction)userFeedback:(id)sender{    
    UMFeedbackViewController *feedBackVc=[[UMFeedbackViewController alloc]init];
    feedBackVc.navigationController.navigationBar.hidden=YES;
    UMPostTableViewCell *cell=[[UMPostTableViewCell alloc]init];
    [cell setBackgroundColor:[UIColor greenColor]];
//    [UMFeedback feedbackViewController]
    [self.navigationController pushViewController:feedBackVc
                                         animated:YES];
//    [self presentViewController:[UMFeedback feedbackViewController] animated:YES completion:^{
    
//    }];
}

-(IBAction)locationService:(id)sender{
    mapViewController *mapVC=[[mapViewController alloc]init];
    [self.navigationController pushViewController:mapVC animated:YES];
}

-(IBAction)inputHandleButton:(id)sender{
    thirdInputHandleViewController *thirdInputVC=[[thirdInputHandleViewController alloc]init];
    [self.navigationController pushViewController:thirdInputVC animated:YES];
}


-(IBAction)sinaWeiBo:(id)sender{
    sinaWeiBoTableViewController *sinaWeiBoVC=[[sinaWeiBoTableViewController alloc]initWithNibName:@"sinaWeiBoTableViewController" bundle:nil];
    [self.navigationController pushViewController:sinaWeiBoVC animated:YES];
}

-(IBAction)goToComment:(id)sende{
    if (ios6) {
         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APPID"]];
    }
    else if (ios7) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APPID"]];
    }
    else if (ios8){
         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APPID&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    }
    else{
        //实测可行，但是很难知道该用户是不是真的评论了我的App，appleid与应用中用户名对应？
        NSLog(@"ios9");
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://appsto.re/cn/qumZ4.i"]];
    }
}


-(IBAction)delegateAndBlock:(id)sender{
    delegateAndBlockViewController *delegateAndBlockVC=[[delegateAndBlockViewController alloc]init];
    [self.navigationController pushViewController:delegateAndBlockVC animated:YES];
}

-(IBAction)QRCodeScane:(id)sender{
    QRCodeViewController *QRCodeVC=[[QRCodeViewController alloc]init];
    QRCodeVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:QRCodeVC animated:YES];
}


-(IBAction)ClassOfViews:(id)sender{
    UIVisibleViewViewController *visibleVC=[[UIVisibleViewViewController alloc]initWithNibName:@"UIVisibleViewViewController" bundle:nil];
    [self.navigationController pushViewController:visibleVC animated:YES];
}


-(IBAction)archiveData:(id)sender{
    archiveDataViewController *archiveDataVC=[[archiveDataViewController alloc]init];
    [self.navigationController pushViewController:archiveDataVC animated:YES];
}

-(IBAction)intrestMathmticQuestion:(id)sender{
    intrestMathmticQuestionViewController *intrestMathVC=[[intrestMathmticQuestionViewController alloc]initWithNibName:@"intrestMathmticQuestionViewController" bundle:nil];
    [self.navigationController pushViewController:intrestMathVC animated:YES];
}

//alerViewController
-(IBAction)alertViewController:(id)sender{
    [self alertViewController];
}
//CrashLog
-(IBAction)crashLog:(id)sender{
    CrashLogViewController *crashLogVC=[[CrashLogViewController alloc]init];
    [self.navigationController pushViewController:crashLogVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)scrollView:(id)sender{
    UIControlViewController *crashLogVC=[[UIControlViewController alloc]init];
    [self presentViewController:crashLogVC animated:YES completion:^{
        
    }];
//    [self.navigationController pushViewController:crashLogVC animated:YES];
}

//打开APP
-(IBAction)openApp:(id)sender{
    NSURL * myURL_APP_A = [NSURL URLWithString:@"StarZone://"];
    if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
        NSLog(@"canOpenURL");
        [[UIApplication sharedApplication] openURL:myURL_APP_A];
    }
}

-(IBAction)AFNetReachTest:(id)sender{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [AFNetworkReachabilityManager managerForDomain:@"https://www.baidu.com"];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"网络状况：%ld,%@",reachabilityManager.networkReachabilityStatus,reachabilityManager.localizedNetworkReachabilityStatusString);
        }
        else if (status==AFNetworkReachabilityStatusReachableViaWWAN){
            NSLog(@"网络状况：%ld,%@",reachabilityManager.networkReachabilityStatus,reachabilityManager.localizedNetworkReachabilityStatusString);
        }
        else if (status==AFNetworkReachabilityStatusReachableViaWiFi){
            NSLog(@"网络状况：%ld,%@",reachabilityManager.networkReachabilityStatus,reachabilityManager.localizedNetworkReachabilityStatusString);
        }
        else{
            NSLog(@"网络状况：%ld,%@",reachabilityManager.networkReachabilityStatus,reachabilityManager.localizedNetworkReachabilityStatusString);
        }
    }];
    
    [reachabilityManager startMonitoring];
    
}

-(IBAction)AVFoundation:(id)sender{
    THSpeechController *speechContrrler=[THSpeechController speechController];
    [speechContrrler beginConversation];
}

//日期处理
-(IBAction)dateHandler:(id)sender{
    DateToolViewController *dateVC=[[DateToolViewController alloc]initWithNibName:@"DateToolViewController" bundle:nil];
    [self.navigationController pushViewController:dateVC animated:YES];
}

//通知
-(IBAction)notificaion:(id)sender{
    NSLog(@"通知");
    NotificationViewController *notiVC=[NotificationViewController new];
    [self.navigationController pushViewController:notiVC animated:YES];
}

//警告
-(IBAction)AlertControoler:(id)sender{
    AlertViewController *alertVC=[AlertViewController new];
    [self.navigationController pushViewController:alertVC animated:YES];
}

//相机📷
-(IBAction)camera:(id)sender{
    CamaroViewController *cameraVC=[[CamaroViewController alloc]initWithNibName:@"CamaroViewController" bundle:nil];
    cameraVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:cameraVC animated:YES];
}

//水波纹动画
-(IBAction)moireAnimation:(id)sender{
    MoireViewController *moireVC=[[MoireViewController alloc]initWithNibName:@"MoireViewController" bundle:nil];
    moireVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:moireVC animated:YES];
}

-(IBAction)palySoundEffect:(id)sender{
    AudioEffectViewController *AudioEffectVC=[[AudioEffectViewController alloc]init];
    [self.navigationController pushViewController:AudioEffectVC animated:YES];
}

-(void)alertViewController{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              NSLog(@"you selected ok");
                                                          }];
    
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"CANCLE" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               NSLog(@"you selected CANCLE");
                                                           }];
    
    UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"DESTRUCT" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               NSLog(@"you selected DESTRUCT");
                                                           }];
    
    
    [alert addAction:defaultAction];
    [alert addAction:defaultAction1];
    [alert addAction:defaultAction2];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
