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

@property(nonatomic,strong)UIWebView *webview;

@end

@implementation H5JumpToAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.webview];
}

-(void)initData{
    self.navigationItem.title=@"H5跳转APP";
    
    NSURL *URL=[[NSBundle mainBundle] URLForResource:@"H5JumpToApp" withExtension:@"html"];
    NSURLRequest *request=[NSURLRequest requestWithURL:URL];
    [self.webview loadRequest:request];
    
}

-(void)loadData:(id)object{
    
}

-(UIWebView *)webview{
    if (!_webview) {
        _webview=[[UIWebView alloc]initWithFrame:self.view.frame];
    }
    return _webview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
