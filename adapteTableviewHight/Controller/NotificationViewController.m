//
//  NotificationViewController.m
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2016/10/30.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#import "NotificationViewController.h"

#import <UserNotifications/UserNotifications.h>

@interface NotificationViewController ()<UNUserNotificationCenterDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSFileManagerDelegate>

@property (nonatomic,strong)UNUserNotificationCenter *notificationCenter;
@property (nonatomic,strong)UNMutableNotificationContent *notificationContent;
@property (nonatomic,strong)UNNotificationTrigger *trigger;

@property (nonatomic,strong)UIImagePickerController *pickerC;
@property (nonatomic,strong)NSFileManager *fileManager;
@end

@implementation NotificationViewController

-(UNUserNotificationCenter *)notificationCenter{
    if (!_notificationCenter) {
        _notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        _notificationCenter.delegate = self;
    }
    return _notificationCenter;
}

-(UNMutableNotificationContent *)notificationContent{
    if (!_notificationContent) {
        _notificationContent=[[UNMutableNotificationContent alloc] init];
        UNNotificationSound *sound = [UNNotificationSound defaultSound];
        _notificationContent.sound = sound;//通知声音
    }
    return _notificationContent;
}

-(UNNotificationTrigger *)trigger{
    if (!_trigger) {
        _trigger=[UNNotificationTrigger new];
    }
    return _trigger;
}

-(UIImagePickerController *)pickerC{
    if (!_pickerC) {
        _pickerC=[UIImagePickerController new];
        _pickerC.delegate=self;
        _pickerC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _pickerC.allowsEditing = YES;
        
    }
    return _pickerC;
}

-(NSFileManager *)fileManager{
    if (!_fileManager) {
        _fileManager=[NSFileManager defaultManager];
        _fileManager.delegate=self;
    }
    return _fileManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self regisiteNotification];
}

/**
 选取照片

 @param sender sender description
 */
-(IBAction)selectImage:(id)sender{
    [self presentViewController:self.pickerC animated:YES completion:^{
        
    }];
}

-(IBAction)pushNotice:(id)sender{
    [self makeUpNoticeCotent];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"push" content:self.notificationContent trigger:self.trigger];//参数就是触发时机和通知组建
    
    [self.notificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

-(void)makeUpNoticeCotent{
    self.notificationContent.badge              =@3;
    self.notificationContent.title              =self.noticeTitle.text;
    self.notificationContent.launchImageName    =@"iosshare.jpg";
    self.notificationContent.subtitle           =@"副标题";
    self.notificationContent.body               =@"来了通知";
    self.notificationContent.userInfo           =@{@"key":self.noticeContent.text};
    NSString *localPath                         = [[self imageFilePath] stringByAppendingPathComponent:@"NoticePNGImage.png"];
    self.notificationContent.categoryIdentifier = @"uid";
    self.notificationContent.threadIdentifier   = @"threadIdentifier";
    if (localPath && ![localPath isEqualToString:@""]) {
        UNNotificationAttachment * attachment   = [UNNotificationAttachment attachmentWithIdentifier:@"photo" URL:[NSURL URLWithString:[@"file://" stringByAppendingString:localPath]] options:nil error:nil];
        if (attachment) {
            self.notificationContent.attachments= @[attachment];
        }
    }
    
    self.trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];//5秒后推送
}


-(void)regisiteNotification{
    //    注册推送通知,iOS10之后不论是否本地通知与远程推送通知，都将采用注册，以及请求发送的形式
    [self.notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        NSLog(@"%d--%@", granted, error);
        
    }];
    //    [NotificationViewController registerLocalNotification:10];
}

// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  @"该起床了...";
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"开始学习iOS开发了" forKey:@"key"];
    notification.userInfo  = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = kCFCalendarUnitDay;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}


#pragma mark UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@" %@将要推送通知 ",NSStringFromClass([self class]));
    // 允许在前台展示消息，不设置的话，默认是不行的
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    UNNotification *notice=response.notification;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:notice.request.content.badge.integerValue];
    NSString *action=response.actionIdentifier;
    NSLog(@"action:%@",action);
}

#pragma mark ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    if (image) {
        [self.noticeImage setBackgroundImage:image forState:UIControlStateNormal];
        [self.noticeImage setTitle:nil forState:UIControlStateNormal];
        [self saveImage:image];
    }
    
}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)saveImage:(UIImage *)image{
    NSString *text=@"abcdefg";
    NSData *imageData=UIImagePNGRepresentation(image);
    NSData *textdata = [text dataUsingEncoding: NSUTF8StringEncoding];
    NSString *imagePath=[self imageFilePath];
    NSString *textPath =[self textFilePath];
    if ([self.fileManager isWritableFileAtPath:imagePath]) {
        NSString *path=[imagePath stringByAppendingPathComponent:@"NoticePNGImage.png"];
//        BOOL result=[self.fileManager createFileAtPath:path contents:imageData attributes:nil];
        BOOL success=[imageData writeToFile:path atomically:YES];
        if(success){
            NSLog(@"存储图片成功");
        }
        else{
            NSLog(@"存储图片失败0");
        }
    }
    else{
        NSLog(@"存储图片失败");
    }
    
    if ([self.fileManager isWritableFileAtPath:textPath]) {
        NSString *path       =[textPath stringByAppendingPathComponent:@"NoticeContent.text"];
        if ([self.fileManager createFileAtPath:path contents:textdata attributes:nil]) {
            NSLog(@"存储文件成功");
        }
        else{
            NSLog(@"存储文件失败0");
        }
    }
    else{
        NSLog(@"存储文件失败");
    }
    
}

-(UIImage *)getNoticeImage{
    NSString *imagePath=[self imageFilePath];
    NSData *data=[self.fileManager contentsAtPath:imagePath];
    UIImage *image=[UIImage imageWithData:data];
    return image;
}

-(NSString *)imageFilePath{
    NSArray *dirctoryPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesDir  =[dirctoryPath objectAtIndex:0];
    NSString *filesPath  =[cachesDir stringByAppendingPathComponent:@"NoticeImage"];
    NSString *path       =[filesPath stringByAppendingPathComponent:@"NoticePNGImage"];
    [self.fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return path;
}

-(NSString *)textFilePath{
    NSArray *dirctoryPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesDir  =[dirctoryPath objectAtIndex:0];
    NSString *filesPath  =[cachesDir stringByAppendingPathComponent:@"Notice"];
    [self.fileManager createDirectoryAtPath:filesPath withIntermediateDirectories:YES attributes:nil error:nil];
    return filesPath;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
