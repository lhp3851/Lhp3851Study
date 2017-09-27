//
//  DotAViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/3.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "DotAViewController.h"
#import "testDotA.h"

@interface DotAViewController ()

@end

@implementation DotAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self DotAFileTest];
}

-(void)initView{
    self.view.backgroundColor=[UIColor greenColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
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
