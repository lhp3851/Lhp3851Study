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
}

-(void)initView{
    self.view.backgroundColor=[UIColor greenColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
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
