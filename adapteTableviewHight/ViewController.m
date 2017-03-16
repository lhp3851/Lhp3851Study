//
//  ViewController.m
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import "ViewController.h"
#import "SingleInstanceViewController.h"
#import "PlistFileViewController.h"
#import "BlueToothViewController.h"
#import "TransitionAViewController.h"
#import "OpenGELSViewController.h"
#import "RunTimeViewController.h"

@interface ViewController (){
    NSMutableArray *functionArray;  //tableView数据存放数组
}
@property(nonatomic,strong)NSMutableDictionary *funcDic;
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
}

-(void)initData{
    functionArray=[NSMutableArray arrayWithObjects:@[@".a文件",@"单例",@"plist文件",@"蓝牙",@"转场动画"],nil];
    
    _funcDic=[NSMutableDictionary dictionaryWithDictionary:@{@"SECTION0":@{@".a文件"    :@"DotAViewController",
                                                                           @"单例"      :@"SingleInstanceViewController",
                                                                           @"plist文件" :@"PlistFileViewController",
                                                                           @"蓝牙"      :@"BlueToothViewController",
                                                                           @"转场动画"   :@"TransitionAViewController",
                                                                           @"OpenGL ES" :@"OpenGELSViewController",
                                                                           @"Objc运行时":@"RunTimeViewController"},
                                                             @"SECTION1":@{@"SECTION1":@"SECTION1_ROW0"}}];
}



//初始化tableView;
-(void)initView{
    CGRect frame = self.view.frame;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x,0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _funcDic.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 5.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *subDic=[_funcDic objectForKey:[NSString stringWithFormat:@"SECTION%ld",(long)section]];
    return [subDic count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *subDic=[_funcDic objectForKey:[NSString stringWithFormat:@"SECTION%ld",(long)indexPath.section]];
    NSArray *keys=[subDic allKeys];
    cell.textLabel.text=[keys objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *subDic=[_funcDic objectForKey:[NSString stringWithFormat:@"SECTION%ld",(long)indexPath.section]];
    NSArray *values=[subDic allValues];
    Class cls=NSClassFromString(values[indexPath.row]);
    UIViewController *AVC=[[cls alloc] init];
    AVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:AVC animated:YES];
}





@end
