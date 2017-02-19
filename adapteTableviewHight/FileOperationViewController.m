//
//  FileOperationViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/26.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

/**
 1.NSFileManager
 2.NSFileHandle
 3.NSBundle
 4.NSURL
 */


#import "FileOperationViewController.h"

@interface FileOperationViewController ()

@end

@implementation FileOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FileManager=[NSFileManager defaultManager];
    
}

//创建文件
-(void)creatFileAtPath:(NSString *)filePath withFileContents:(NSData *)fileData andFileAttribute:(NSDictionary *)Attribute{
    [FileManager createFileAtPath:filePath contents:fileData attributes:Attribute];
//    FileManager 
}

//文件是否可读
-(BOOL)isReadble:(NSString *)filePath{
    if ([FileManager isReadableFileAtPath:filePath]==YES) {
        NSLog(@"file is readble");
        return YES;
    }
    else{
        NSLog(@"file is not readble");
        return NO;
    }
}

-(BOOL)isWriteble:(NSString *)filePath{
    if ([FileManager isWritableFileAtPath:filePath]==YES) {
        NSLog(@"file is writeble");
        return YES;
    }
    else{
        NSLog(@"file is not writeble");
        return NO;
    }
}

//确定文件是否存在
-(BOOL)isFileExsit:(NSString *)fileName withPath:(NSString *)fielPath{
    if ([FileManager fileExistsAtPath:fielPath]==YES) {
        NSLog(@"file exsit");
        return 1;
    }
    else{
        NSLog(@"file not exsit");
        return NO;
    }
}

//复制文件
-(void)copyFileToPath:(NSString *)filePath fromFilePath:(NSString *)sourceFilePath{
    if ([FileManager copyItemAtPath:sourceFilePath toPath:filePath error:NULL]==NO) {
        NSLog(@"file copy failed");
        return;
    }
    else{
        NSLog(@"file copyed");
    }
}

//比较两个问价是否一致
-(BOOL)fileCompare:(NSString *)sourceFilePath andTargetFile:(NSString *)targetFilePath{
    if ([FileManager contentsEqualAtPath:sourceFilePath andPath:targetFilePath]==YES) {
        NSLog(@"the file are same");
        return YES;
    }
    else{
        NSLog(@"the file are diffrent");
        return NO;
    }
}

//重命名
-(void)reNameTheFile:(NSString *)fileName withFileName:(NSString *)reName{
    if ([FileManager moveItemAtPath:fileName toPath:reName error:NULL]==YES) {
        NSLog(@"reName succcess");
    }
    else{
        NSLog(@"reName failed");
    }
}

//获取文件信息
-(void)getFileAttribute:(NSString *)filePath{
    if ((FileAttr=[FileManager attributesOfItemAtPath:filePath error:NULL])==nil) {
        NSLog(@"coulde not get attribute");
    }
    else{
        NSLog(@"FileAttribute:%@",FileAttr);
        NSLog(@"FileAttribute size is %llu bytes",[[FileAttr objectForKey:NSFileSize] unsignedLongLongValue]);
    }
}

//删除文件
-(void)deleteFile:(NSString *)filePath{
    if ([FileManager removeItemAtPath:filePath error:NULL]==NO) {
        NSLog(@"delete fialed");
    }
    else{
        NSLog(@"delete success");
    }
}

//显示文件内容
-(void)contentsOfFile:(NSString *)filePath{
    NSLog(@"file data:%@",[FileManager contentsAtPath:filePath]);
    NSString *fileContent=[[NSString alloc]init];
    NSData *fileData=[FileManager contentsAtPath:filePath];
    
    
    
    NSLog(@"file content:%@",[fileContent initWithData:fileData encoding:NSUTF8StringEncoding]);
    NSLog(@"%@",[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL]);
}

//设置文件属性
-(void)setFileAttribute:(NSString *)filePath withAttribute:(NSDictionary *)attribute{
    if ([FileManager setAttributes:attribute ofItemAtPath:filePath error:NULL]==YES) {
        NSLog(@"set attribute success");
    }
    else{
        NSLog(@"set attribute failed");
    }
}

//获取当前目录
-(void)currentDirectory{
    NSLog(@"currentDirectory:%@",[FileManager currentDirectoryPath]);
}

//创建一个新目录
-(void)createNewDirectory:(NSString *)newDirectory{
    if ([FileManager createDirectoryAtPath:newDirectory withIntermediateDirectories:YES attributes:nil error:NULL]==YES) {
        NSLog(@"create success");
    }
    else{
        NSLog(@"creat failed");
    }
}

//重命名新的目录
-(void)reNameDirectory:(NSString *)directoryName withNewName:(NSString *)newDirectoryName{
    if ([FileManager moveItemAtPath:newDirectoryName toPath:directoryName error:NULL]==YES) {
        NSLog(@"rename success");
    }
    else{
        NSLog(@"rename failed");
    }
}

//更改当前目录到目标目录
-(void)changeDirectory:(NSString *)currentDirectory toDirectory:(NSString *)targetDirectory{
    if ([FileManager changeCurrentDirectoryPath:targetDirectory]) {
        NSLog(@"change directory success");
    }
    else{
        NSLog(@"change directory failed");
    }
}

//枚举目录
-(void)EnnumDirectory{
    FileName=[FileManager currentDirectoryPath];
    
    dirEnnum=[FileManager enumeratorAtPath:FileName];
    
    NSLog(@"contents of %@",FileName);
    
    while ((FileName=[dirEnnum nextObject])!=nil) {
        NSLog(@"%@",FileName);
    }
    
    //另一种枚举的方法
    dirArray=[FileManager contentsOfDirectoryAtPath:[FileManager currentDirectoryPath] error:NULL];
    NSLog(@"contents using contentsOfDirectoryAtPath:erro:");
    for (FileName in dirArray) {
        NSLog(@"%@",FileName);
    }
    
    //另二种枚举方法😜
    [dirArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"directorys:%@,%lu,%p",obj,(unsigned long)idx,stop);
    }];
    
}

//路径的基本操作
-(void)directoryOperator{
    //临时目录
    NSString *temDir=NSTemporaryDirectory();
    NSLog(@"temDir:%@",temDir);
    //提取基本目录
    FileName=[FileManager currentDirectoryPath];
    NSLog(@"base dir is:%@",[FileName lastPathComponent]);
    //创建file在当前目录的完整路径
    NSString *fullFilePath=[FileName stringByAppendingString:@"fName"];
    NSLog(@"fullPath to %@ is %@",FileName,fullFilePath);
    //获取文件拓展名
    NSString *extension=[fullFilePath pathExtension];
    NSLog(@"extension for %@ is %@",fullFilePath,extension);
    //用户的主目录
    NSString *homeDir=NSHomeDirectory();
    NSLog(@"your home dirctory is %@",homeDir);
    //拆分路径
    NSArray *components=[homeDir pathComponents];
    for (FileName in components) {
        NSLog(@"FileName path:%@",FileName);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
