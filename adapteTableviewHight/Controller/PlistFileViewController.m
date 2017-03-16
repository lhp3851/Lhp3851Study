//
//  PlistFileViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/3.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PlistFileViewController.h"

@interface PlistFileViewController ()

@end

@implementation PlistFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self plistFileOperation];
}

-(void)initView{
    self.view.backgroundColor=[UIColor greenColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
}

//plist文件操作
-(void)plistFileOperation{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"plistdemo" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //添加一项内容
    [data setObject:@"add some content" forKey:@"c_key"];
    
    NSMutableArray *rootArray = [NSMutableArray arrayWithContentsOfFile:plistPath];//注意，如果想添加新的数据，需要NSMutable类型的
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil,@"6", nil];
    for (int i=0; i<array.count; i++) {
        if([array objectAtIndex:i]==nil){
            [array replaceObjectAtIndex:i withObject:[NSArray array]];
        }
    }
    
    rootArray =[NSMutableArray arrayWithObject:array];
    for (id __strong object in rootArray) {
        if (object==nil) {
            object=[NSArray array];
        }
    }
    [rootArray addObject:@"数组"];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];
    //输入写入
    [data writeToFile:filename atomically:YES];
    [rootArray writeToFile:filename atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
