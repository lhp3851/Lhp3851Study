//
//  ImagePickerRootViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "ImagePickerRootViewController.h"

@interface ImagePickerRootViewController ()

@end

@implementation ImagePickerRootViewController

+(id)shareImagePickerRootViewController{
    static ImagePickerRootViewController *rootVC=nil;
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        rootVC=[self new];
    });
    return rootVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
