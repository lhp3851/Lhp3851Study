//
//  CrashLogViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/12/24.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "CrashLogViewController.h"

@interface CrashLogViewController ()

@end

@implementation CrashLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setCrashLogButton];
}

/**
 *  崩溃
 */
-(void)setCrashLogButton{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, tablebarHight, kSCREENWIDTH/3, 45)];
    button.center=self.view.center;
    [button setTitle:@"Crash" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(crash:) forControlEvents:UIControlEventTouchUpInside
     ];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.layer.masksToBounds=YES;
    button.layer.cornerRadius=3;
    button.layer.borderWidth=0.5f;
    button.layer.borderColor=[UIColor blueColor].CGColor;
    [self.view addSubview:button];
}


-(void)crash:(id)sender{
    NSArray *array=[[NSArray alloc]initWithObjects:@"1", nil];
   [array objectAtIndex:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
