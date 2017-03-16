//
//  SingleInstanceViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/3.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "SingleInstanceViewController.h"
#import "singleton.h"

@interface SingleInstanceViewController ()

@end

@implementation SingleInstanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self singletonModle];
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
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
