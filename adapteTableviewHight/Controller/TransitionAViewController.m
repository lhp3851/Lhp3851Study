//
//  TransitionAViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/1.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "TransitionAViewController.h"
#import "TransitionBViewController.h"

@interface TransitionAViewController ()<UINavigationControllerDelegate>

@end

@implementation TransitionAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TransitionBViewController *BVC=[[TransitionBViewController alloc]init];
    self.navigationController.delegate=BVC;
    [self.navigationController pushViewController:BVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
