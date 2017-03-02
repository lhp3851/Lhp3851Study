//
//  ViewController.m
//  socketForClient
//
//  Created by lhp3851 on 15/9/28.
//  Copyright © 2015年 lhp3851. All rights reserved.
//

#import "ViewController.h"
#import "MessageTextfield.h"

static NSString *host=@"";
static NSString *port=@"";

@interface ViewController ()
@property(nonatomic,strong)MessageTextfield *msgTextField;
@end

@implementation ViewController

-(MessageTextfield *)msgTextField{
    if (!_msgTextField) {
        _msgTextField=[[MessageTextfield alloc]initWithDelegate:self];
        [_msgTextField setFrame:(CGRect){0,kSCREENHEIGHT-60,kSCREENWIDTH,60}];
    }
    return _msgTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self connectToHost];
}



-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.msgTextField];
}

/**
 连接服务器
 */
-(void)connectToHost{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)(host), (int)port.integerValue, &readStream, &writeStream);
    _inputStream =(__bridge_transfer NSInputStream  *)readStream;
    _outputStream=(__bridge_transfer NSOutputStream *)writeStream;
    
    _inputStream .delegate=self;
    _outputStream.delegate=self;
    [_inputStream  scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream  open];
    [_outputStream open];
}


/**
 关闭连接
 */
-(void)closeConnect{
    [_inputStream close];
    [_outputStream close];
    _inputStream.delegate=nil;
    _outputStream.delegate=nil;
    
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark 读了服务器返回的数据
-(void)readData{
    uint8_t buf[1024];
    NSInteger len=[_inputStream read:buf maxLength:sizeof(buf)];
    
    NSData *readData=[NSData dataWithBytes:buf length:len];
    NSString *readString=[[NSString alloc]initWithData:readData encoding:NSUTF8StringEncoding];
    NSLog(@"从服务器读取的数据：%@",readString);
}

#pragma mark 向服务器发送数据
-(void)sendDataToServer:(NSString *)messages{
    NSData *sendData=[messages dataUsingEncoding:NSUTF8StringEncoding];
    [_outputStream write:sendData.bytes maxLength:sendData.length];
}


#pragma mark NSStreamDelegate
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
        case NSStreamEventNone:
             NSLog(@"流状态未知");
            break;
        case NSStreamEventOpenCompleted:
            NSLog(@"输入输出流打开完成");
            break;
        case NSStreamEventHasBytesAvailable:
            [self readData];
            break;
        case NSStreamEventHasSpaceAvailable:
             NSLog(@"可以发送字节");
            [self sendDataToServer:@"Hello, server! I come from Client."];
            break;
        case NSStreamEventErrorOccurred:
            [self closeConnect];
            break;
        case NSStreamEventEndEncountered:
            [self closeConnect];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
