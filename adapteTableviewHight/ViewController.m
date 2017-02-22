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



//#import <CoreBluetooth/CoreBluetooth.h>
//#import <GameKit/GameKit.h>
@interface ViewController (){
    NSMutableArray *tableData;  //tableView数据存放数组
    
    UISwipeGestureRecognizer *swipLeftGesture;
    UISwipeGestureRecognizer *swipRightGesture;

    
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tableData = [[NSMutableArray alloc] init];
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
    [NSThread sleepForTimeInterval:3];
//    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
//    [self setHidesBottomBarWhenPushed:YES];

    [self initTableView];
    [self createUserData];
    
    [self DotAFileTest];
    [self singletonModle];

 //plis文件操作
    [self plistFileOperation];
//   bubble_sort(nil, SIZE);
//    NSString *name = (NSString *)objc_msgSend(obj, @selector(getName));
//    objc_msgSend(obj, @selector(setName:),@"balabala");
    
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

//我需要一点测试数据，直接复制老项目东西
-(void)createUserData{
    tableData=[[NSMutableArray alloc]init];
    userModel *user = [[userModel alloc] init];
    [user setUsername:@"胖虎"];
    [user setIntroduction:@"我是胖虎我怕谁!!我是胖虎我怕谁!!我是胖虎我怕谁!!"];
    [user setImagePath:@"panghu.jpg"];
    userModel *user2 = [[userModel alloc] init];
    [user2 setUsername:@"多啦A梦"];
    [user2 setIntroduction:@"我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!我是多啦A梦我有肚子!!"];
    [user2 setImagePath:@"duolaameng.jpg"];
    userModel *user3 = [[userModel alloc] init];
    [user3 setUsername:@"大雄"];
    [user3 setIntroduction:@"我是大雄我谁都怕，我是大雄我谁都怕，我是大雄我谁都怕，我是大雄我谁都怕，我是大雄我谁都怕，我是大雄我谁都怕，"];
    [user3 setImagePath:@"daxiong.jpg"];
    
    [tableData addObject:user];
    [tableData addObject:user2];
    [tableData addObject:user3];
}

//plist文件操作
-(void)plistFileOperation{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"plistdemo" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    NSLog(@"data:%@", data);
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
-(void)initTableView{
    CGRect frame = self.view.frame;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x,0, frame.size.width, frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}




-(void)swipGesture{
    if (swipLeftGesture.direction==UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"左划⬅️");
        [_tableView removeFromSuperview];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        [_tableView setFrame:CGRectMake(self.view.frame.origin.x+100, self.view.frame.origin.y+tablebarHight+38, self.view.frame.size.width, self.view.frame.size.height-tablebarHight*2)];
        _tableView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_tableView];
        [UIView commitAnimations];
    }
    else{
        NSLog(@"左划bug");
    }
}


-(void)swipRightGesture{
    if (swipRightGesture.direction==UISwipeGestureRecognizerDirectionRight){
        NSLog(@"右划→");
        
    }
    else{
        NSLog(@"右划bug");
    }
}




-(void)changePageCount:(UISegmentedControl *)sender{
    UISegmentedControl *segments=(UISegmentedControl *)sender;
    NSLog(@"第%ld页",(long)segments.selectedSegmentIndex);
    [self createUserData];
    if (segments.selectedSegmentIndex==0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [_tableView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+tablebarHight+38, self.view.frame.size.width, self.view.frame.size.height-tablebarHight*2)];
        [_tableView reloadData];
        [self.view addSubview:_tableView];
        
        [UIView commitAnimations];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = (TableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"Cell";
    //自定义cell类
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    userModel *user = [tableData objectAtIndex:indexPath.row];
    cell.name.text = user.username;
    [cell.userImage setImage:[UIImage imageNamed:user.imagePath]];
    [cell setIntroductionText:user.introduction];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





@end
