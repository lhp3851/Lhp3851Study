//
//  H5JumpToAppViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/16.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "H5JumpToAppViewController.h"
#import "SesameGlobalWebView.h"

@interface H5JumpToAppViewController ()

@property(nonatomic,strong)SesameGlobalWebView *webview;

@end

@implementation H5JumpToAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initData{
    self.navigationItem.title=@"H5跳转APP";
}


-(SesameGlobalWebView *)webview{
    if (!_webview) {
        _webview=[[SesameGlobalWebView alloc]init];
    }
    return _webview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
