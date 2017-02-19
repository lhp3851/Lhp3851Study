//
//  AlertViewController.m
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2016/10/31.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#import "AlertViewController.h"
#import "AlertTool.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPannel];
}

-(void)setPannel{
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    AlertTool *alert=[[AlertTool alloc]initWithTitle:@"警告" message:@"警告测试" delegate:self];
    alert.buttonTitles=@[@"确定",@"取消"];
//    alert.actions=
    [alert showInViewController:self];
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
