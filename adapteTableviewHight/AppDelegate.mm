//
//  AppDelegate.m
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import "AppDelegate.h"
#import "archiveData.h"


@interface AppDelegate ()<UIAlertViewDelegate>{
    BMKMapManager* _mapManager;
}

@end

@implementation AppDelegate

// 设置一个C函数，用来接收崩溃信息
void UncaughtExceptionHandler(NSException *exception){
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的，例如下面的symbols数组就是我们的崩溃堆栈。
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSLog(@"异常：%@%@%@",symbols,reason,name);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //收集异常信息
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
//    NSUncaughtExceptionHandler *handler = NSGetUncaughtExceptionHandler();

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [UMFeedback setAppkey:@"556e833d67e58e0bc50037a0"];
    [UMOpus setAudioEnable:YES];
    
    _mapManager=[[BMKMapManager alloc]init];//百度地图
    BOOL ret=[_mapManager start:@"CSSyVewN38PiyOb3QPXWSfEP" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    //注册通知
    [application registerForRemoteNotifications];
    
    MainTabBarController *tabBarController=[[MainTabBarController alloc]init];
    self.window.rootViewController=tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *urlStr = [url absoluteString];
    if ([urlStr hasPrefix:@"lhp3851://"]) {
        NSLog(@"TestAppDemo1 request params: %@", urlStr);
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"lhp3851://" withString:@""];
        NSArray *paramArray = [urlStr componentsSeparatedByString:@"&"];
        NSLog(@"paramArray: %@", paramArray);
        NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        for (int i = 0; i < paramArray.count; i++) {
            NSString *str = paramArray[i];
            NSArray *keyArray = [str componentsSeparatedByString:@"="];
            NSString *key = keyArray[0];
            NSString *value = keyArray[1];
            [paramsDic setObject:value forKey:key];
            NSLog(@"key:%@ ==== value:%@", key, value);
        }
        
    }
    return NO;
}

- (void)registerUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    NSLog(@"注册通知成功");
}

/**
 接受本地通知

 @param notification 通知内容
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification{
    NSLog(@"Local Notification:%@",notification);
    // 获取通知所带的数据
    NSString *notMess = [notification.userInfo objectForKey:@"key"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地通知"
                                                    message:notMess
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    // 在不需要再推送时，可以取消推送
//    [HomeViewController cancelLocalNotificationWithKey:@"key"];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    NSLog(@"收到远程通知");
}

// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;  
            }  
        }  
    }  
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier{
    return YES;
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}


- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}



@end
