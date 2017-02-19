//
//  UIControlViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/26.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "UIControlViewController.h"

@interface UIControlViewController ()

@end

@implementation UIControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setTheScrollView];
    
}


-(void)setTheScrollView{
    scrollView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    [scrollView setContentSize:CGSizeMake(screenWidth, screenHight)];

//    for (int i=0; i<5; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHight)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"new%i",4]];
        [scrollView addSubview:imageView];
//    }
    
    [self.view addSubview:scrollView];
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
