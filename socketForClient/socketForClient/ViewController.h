//
//  ViewController.h
//  socketForClient
//
//  Created by lhp3851 on 15/9/28.
//  Copyright © 2015年 lhp3851. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define PORT 9000

@interface ViewController : UIViewController<NSStreamDelegate>{
     int flag ; //操作标志 0为发送 1为接收
}

@property (nonatomic, retain) NSInputStream  *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;

@end

