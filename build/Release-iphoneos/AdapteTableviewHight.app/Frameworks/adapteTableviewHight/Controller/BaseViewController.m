//
//  BaseViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/16.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initData{
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
