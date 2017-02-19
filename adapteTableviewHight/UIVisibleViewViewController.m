//
//  UIVisibleViewViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/26.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "UIVisibleViewViewController.h"
#import "uploadImgeViewController.h"
#import "feedbackViewController.h"

@interface UIVisibleViewViewController (){
    UIButton *uploadImageButton;
}

@end

@implementation UIVisibleViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheNavigationItem];
    [self setTheLabel];
}

-(void)setTheNavigationItem{
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithCustomView:[self navigationRightBar]],[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(ResetEnviroment:)], nil];
}


//label
-(void)setTheLabel{
    
    self.label1.translatesAutoresizingMaskIntoConstraints=NO;
    self.label2.translatesAutoresizingMaskIntoConstraints=NO;
    //metrics定义了一些vfl中要用的参数
    NSDictionary *viewsDictionary = @{@"label1":self.label1};//,@"label2":_label2
    // 2. Define the redView Size
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label1(100)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[label1(100)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    [self.label1 addConstraints:constraint_H];
    [self.label1 addConstraints:constraint_V];
    
    // 3. Define the redView Position
    NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[label1]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label1]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:viewsDictionary];
    
    // 3.B ...and try to change the visual format string
    //NSArray *constraint_POS_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label1]-30-|" options:0 metrics:nil views:viewsDictionary];
    //NSArray *constraint_POS_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label1]" options:0 metrics:nil views:viewsDictionary];
    
    [self.view addConstraints:constraint_POS_H];
    [self.view addConstraints:constraint_POS_V];
}

-(void)ResetEnviroment:(id)sender{
    feedbackViewController *feedbackVC=[[feedbackViewController alloc]initWithNibName:@"feedbackViewController" bundle:nil];
    feedbackVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:feedbackVC animated:YES];
    
}

-(UIButton *)navigationRightBar{
    uploadImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [uploadImageButton setFrame:CGRectMake(0, 0, 80, 34)];
    [uploadImageButton addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    uploadImageButton.layer.cornerRadius=3;
    uploadImageButton.layer.borderWidth=1.0;
    uploadImageButton.layer.borderColor=[UIColor blueColor].CGColor;
    uploadImageButton.layer.masksToBounds=YES;
    [uploadImageButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [uploadImageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [uploadImageButton setTitle:@"上传照片" forState:UIControlStateNormal];
    return uploadImageButton;
}

-(void)uploadImage:(id)sender{
    uploadImgeViewController *uploadImageVc=[[uploadImgeViewController alloc]initWithNibName:@"uploadImgeViewController" bundle:nil];
    uploadImageVc.title=@"上传照片";
    uploadImageVc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:uploadImageVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
