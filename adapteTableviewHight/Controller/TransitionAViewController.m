//
//  TransitionAViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/1.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "TransitionAViewController.h"
#import "TransitionBViewController.h"

@interface TransitionAViewController ()

@end

@implementation TransitionAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TransitionBViewController *BVC=[[TransitionBViewController alloc]init];
    BVC.navigationController.delegate=BVC;
    [self.navigationController pushViewController:BVC animated:YES];
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
