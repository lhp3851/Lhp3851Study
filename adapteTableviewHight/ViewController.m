//
//  ViewController.m
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import "ViewController.h"
#import "testDotA.h"
#import "singleton.h"
#import "TransitionAViewController.h"


//#import <CoreBluetooth/CoreBluetooth.h>
//#import <GameKit/GameKit.h>
@interface ViewController (){
    NSMutableArray *functionArray;  //tableView数据存放数组
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed=YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
    
    [self DotAFileTest];
    [self singletonModle];

 //plis文件操作
    [self plistFileOperation];
//   bubble_sort(nil, SIZE);
//    NSString *name = (NSString *)objc_msgSend(obj, @selector(getName));
//    objc_msgSend(obj, @selector(setName:),@"balabala");
    
}

-(void)initData{
    functionArray=[NSMutableArray arrayWithObjects:@[@".a文件",@"单例",@"plist文件",@"蓝牙",@"转场动画"],nil];
}

//.a文件验证
-(void)DotAFileTest{
    testDotA *testInsistance=[[testDotA alloc]init];
    //类方法
    [testDotA printa];
    //静态输出方法
    [testInsistance printA];
    //字符串输出方法
    [testInsistance printString:@"string"];
    //对象输出方法
    [testInsistance print:[NSDate date]];
}

//单例验证
-(void)singletonModle{
    singleton *A = [[singleton alloc] init];
    
    NSLog(@"A:%p",A);
    
    singleton *B = [singleton getInsistance];
    
    NSLog(@"B:%p",B);
    
    singleton *C = [A copy];
    
    NSLog(@"C:%p",C);
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

//初始化tableView;
-(void)initView{
    CGRect frame = self.view.frame;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x,0, frame.size.width, frame.size.height)];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return functionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *subArray=[functionArray objectAtIndex:section];
    return [subArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *subArray=[functionArray objectAtIndex:indexPath.section];
    cell.textLabel.text=[subArray objectAtIndex:indexPath.row];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TransitionAViewController *AVC=[[TransitionAViewController alloc] init];
    [self.navigationController pushViewController:AVC animated:YES];
}





@end
