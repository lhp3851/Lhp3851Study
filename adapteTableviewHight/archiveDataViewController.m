//
//  archiveDataViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/10/18.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "archiveDataViewController.h"
#import "archiveData.h"
#import "FMDB.h"

@interface archiveDataViewController (){
    FMDatabase *dataBase;
}

@end


#define kFileName @"kFileName"
#define kDataKey  @"kDataKey"


@implementation archiveDataViewController

-(NSString *) getFilePath{
    
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[array objectAtIndex:0] stringByAppendingPathComponent:kFileName];
    
    
    //
//    NSString *ourDocumentPath =[array objectAtIndex:0];
    //准备：获取主目录
//    NSString *sandboxPath = NSHomeDirectory();
    //第一步：设置目录
//    NSString *documentPath = [sandboxPath stringByAppendingPathComponent:@"Documents"];//将Documents添加到sandbox路径上，具体原因前面分析了！
    //第二步：设置文件名
//    NSString *FileName=[documentPath stringByAppendingPathComponent:@"fileTowrite"];//fileName就是保存文件的文件名
//    //第三步：往文件中写入数据：
//    NSData *wirteData=[@"张无忌" dataUsingEncoding:NSUTF8StringEncoding];//字符串转化成data
//    [wirteData writeToFile:FileName atomically:YES];//将NSData类型对象data写入文件，文件名为FileName
//    
//    //最后：从文件中读出数据：
//    NSData *readData=[NSData dataWithContentsOfFile:FileName options:0 error:NULL];//从FileName中读取出数据
//    NSLog(@"readData:%@",readData);
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getFilePath]]) {
        NSLog(@"filePAth:%@",[self getFilePath]);
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:[self getFilePath]];
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        //解档出数据模型Student
        archiveData *mStudent = [unarchiver decodeObjectForKey:kDataKey];
        [unarchiver finishDecoding];//一定不要忘记finishDecoding，否则会报错
        
        //接档后就可以直接使用了（赋值到相应的组件属性上）
        NSLog(@"archiveData:%@",mStudent.name);
        
        
        archiveData *archiveDataCopy=[mStudent copy];
        
        NSLog(@"archiveDataCopy:%@",archiveDataCopy.name);
    }
    
    //添加一个广播，用于注册当用户按下home键时，归档数据到闪存中
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAppDataWhenApplicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];

    [self initDatabase];
}



/**
 *当用户按下Home键，返回桌面时，归档当前数据到指定文件路径下
 */
-(void)saveAppDataWhenApplicationWillResignActive:(NSNotification*) notification{
    
    archiveData *saveStudent = [[archiveData alloc] init];
    saveStudent.name=@"张三丰";
    
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:saveStudent forKey:kDataKey];
    
    [archiver finishEncoding];
    
    [data writeToFile:[self getFilePath] atomically:YES];
}


#pragma mark DataBase operation

-(void)initDatabase{
    dataBase=[FMDatabase databaseWithPath:@"/tmp/tmp.db"];
    
    if ([dataBase open]) {
        NSLog(@"open success");
    }
    else{
        NSLog(@"erro:\n%@ \n%@  %d\n",[dataBase lastErrorMessage],[dataBase lastError],[dataBase lastErrorCode]);
    }
    
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
