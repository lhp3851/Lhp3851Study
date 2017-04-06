//
//  QRCodeREsultViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/25.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "QRCodeREsultViewController.h"

@interface QRCodeREsultViewController ()

@end

@implementation QRCodeREsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"扫描结果";
    SesameGlobalWebView *globalView = [[SesameGlobalWebView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-kTABLE_BAR_HEIGHT+24) DataString:self.URLString];
    [self.view addSubview:globalView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
