//
//  singleton.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/23.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "singleton.h"

@implementation singleton
//1.实例化一个nil实例变量
static singleton *singleInsistance=nil;
//2.获取单例的方法
+(singleton *)getInsistance{
    @synchronized (self){//创建一个互斥锁，保证此时没有其它线程对self对象进行修改,隐式的包含了异常处理
        if (singleInsistance==nil) {
            singleInsistance=[[super allocWithZone:NULL]init];
            
//            singleInsistance=[[self alloc]init];//b方法  也可以这样写
        }
    }
    return singleInsistance;
}
/*//第二种获取单例的方法
+(singleton *)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        singleInsistance=[[self alloc]init];
    });
    
    return singleInsistance;
}
 */

-(id)init{
    @synchronized(self) {
        
        if (self = [super init]){
            
            return self;
        }
        
        return nil;
    }
}

//3.限制用户只能通过获取单例的方法获取到单例
+(id)allocWithZone:(struct _NSZone *)zone{
    return [[self getInsistance] retain];//教材上这么写的，下面方法是官网的
//    @synchronized(self){//b方法
//        
//        if (!singleInsistance) {
//            
//            singleInsistance = [super allocWithZone:zone]; //确保使用同一块内存地址
//            
//            return singleInsistance;
//            
//        }
//        
//        return nil;
//    }
}


//4.以下都是保证单例只有一个正确的状态
-(id)copyWithZone:(NSZone *)zone{
    return self;
}


-(id)retain{
    return self;
}

-(NSUInteger)retainCount{
    return NSUIntegerMax;
}

-(oneway void)release{
    //不作处理
    NSLog(@"");
}

-(id)autorelease{
    return self;
}

@end
