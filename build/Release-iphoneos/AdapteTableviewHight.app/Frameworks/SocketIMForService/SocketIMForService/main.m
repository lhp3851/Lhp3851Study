//
//  main.m
//  SocketIMForService
//
//  Created by lhp3851 on 15/9/28.
//  Copyright © 2015年 lhp3851. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>


#define PORT 9000

void AcceptCallBack(CFSocketRef,CFSocketCallBackType,CFDataRef,const void*,void*);

void WriteStreamClientCallBack(CFWriteStreamRef stream,CFStreamEventType eventType,void *);

void ReadStreamClientCallBack(CFReadStreamRef stream,CFStreamEventType eventTypr,void *);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CFSocketRef sserver;
        //创建socket context
        CFSocketContext CTX={0,NULL,NULL,NULL,NULL};//用来配置socket对象的行为，提供程序定义数据和回掉函数
        
        
        sserver=CFSocketCreate(NULL, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketAcceptCallBack,(CFSocketCallBack)AcceptCallBack, &CTX);//创建socket对象
        
        if (sserver==NULL) {
            return -1;
        }
        
        
        //设定是否重新绑定标志
        int yes=1;
        //设置socket属性SOL_SOKET 是设置tcp SO_REUSEADDR重新绑定，yes是否重新绑定
        setsockopt(CFSocketGetNative(sserver), SOL_SOCKET, SO_REUSEADDR, (void *)&yes, sizeof(yes));//
        
        //设置端口和地址
        struct sockaddr_in addr;
        memset(&addr, 0, sizeof(addr));//对指定的内存地址复制
        addr.sin_len        =sizeof(addr);//
        addr.sin_family     =AF_INET;//设置IPv4
        addr.sin_port       =htons(PORT);//无符号短整型转换成“网络字节序”
        addr.sin_addr.s_addr=htonl(INADDR_ANY);//INADDR_ANY 有内核分配，htonl函数 无符号长整型装换成“网络字节序”
        
        //从指定字节缓冲区复制，一个不可变的CFData;
        CFDataRef address=CFDataCreate(kCFAllocatorDefault, (UInt8 *)&addr, sizeof(addr));
        
        //绑定socket
        if (CFSocketSetAddress(sserver, (CFDataRef)address)!=kCFSocketSuccess) {
            fprintf(stderr, "socket 绑定失败");
            return -1;
        }
        
        //创建一个run loop socket
        CFRunLoopSourceRef sourceRef=CFSocketCreateRunLoopSource(kCFAllocatorDefault, sserver, 0);
        //socket源添加到 run loop 中
        CFRunLoopAddSource(CFRunLoopGetCurrent(), sourceRef, kCFRunLoopCommonModes);
        
        printf("socket listening on port %d\n",PORT);
        //运行run loop
        CFRunLoopRun();
        
        
    }
    return 0;
}

//接受客户端请求后，回调函数
void AcceptCallBack(CFSocketRef socket,
                    CFSocketCallBackType type,
                    CFDataRef address,
                    const void *data,
                    void *info){
    CFReadStreamRef  readStream=NULL;
    CFWriteStreamRef writeStream=NULL;
    
    //data参数含义是，如果回调类型是 kCFSocketAcceptCallBack data就是 CFSocketNativeHandle类型的指针
    CFSocketNativeHandle sock=* (CFSocketNativeHandle *)data;
    
    //创建socket读写流
    CFStreamCreatePairWithSocket(kCFAllocatorDefault, sock, &readStream, &writeStream);
    
    if (!readStream||!writeStream) {
        close(sock);
        fprintf(stderr, "CFStreamCreatePairWithSocket 失败");
        return;
    }
    
    CFStreamClientContext stramCTxt={0,NULL,NULL,NULL,NULL};
    //注册两种回调函数
    CFReadStreamSetClient (readStream,  kCFStreamEventHasBytesAvailable, ReadStreamClientCallBack, &stramCTxt);
    CFWriteStreamSetClient(writeStream, kCFStreamEventCanAcceptBytes, WriteStreamClientCallBack, &stramCTxt);
    
    //加入到循环队列中
    CFReadStreamScheduleWithRunLoop(readStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    CFWriteStreamScheduleWithRunLoop(writeStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
    
    CFReadStreamOpen(readStream);
    CFWriteStreamOpen(writeStream);
}
//读取流操作，客户端有数据过来时调用
void ReadStreamClientCallBack(CFReadStreamRef stream,
                               CFStreamEventType evnetType,
                               void *clientCallBackInfo){
    UInt8 buff[255];
    CFReadStreamRef inputStream=stream;
    
    if (NULL!=inputStream) {
        CFReadStreamRead(stream, buff, 255);
        printf("接收到数据：%s\n",buff);
        CFReadStreamClose(inputStream);
        CFReadStreamUnscheduleFromRunLoop(inputStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        inputStream=NULL;
    }
}


//写入操作流 客户端在读取数据时调用
void WriteStreamClientCallBack(CFWriteStreamRef stream,
                              CFStreamEventType eventType,
                              void *clientCallBackInfo){
    CFWriteStreamRef outputStream=stream;
    //输出
    UInt8 buff[]="hello client";
    if (NULL!=outputStream) {
        CFWriteStreamWrite(outputStream, buff, strlen((const char *)buff)+1);
        CFWriteStreamClose(outputStream);
        CFWriteStreamUnscheduleFromRunLoop(outputStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        outputStream=NULL;
    }
    
}


