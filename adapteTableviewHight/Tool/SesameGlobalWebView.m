//
//  SesameGlobalWebView.m
//  Sesame
//
//  Created by 刘文龙 on 13-11-25.
//  Copyright (c) 2013年 刘文龙. All rights reserved.
//

#import "SesameGlobalWebView.h"
#import "NSObject_extra.h"
//#import "Global.h"

@implementation SesameGlobalWebView
@synthesize webView;


- (id)initWithFrame:(CGRect)frame DataString:(NSString *)dataString
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *bottomImage = [UIImage imageNamed:@"bg_bottom_Image.png"];
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH,frame.size.height-bottomImage.size.height)];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
                NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:dataString]  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:40.0];
        [webView loadRequest:request];
        [self addSubview:webView];
        
        //底板的向前向后  刷新
        UIImageView *bottomImageView = [[UIImageView alloc] init];
        bottomImageView.frame = CGRectMake(0,webView.frame.origin.y+webView.frame.size.height, bottomImage.size.width, bottomImage.size.height);
        bottomImageView.image = bottomImage;
        [bottomImageView setUserInteractionEnabled:YES];
        [self addSubview:bottomImageView];
        
        
        UIImage *goBackImage = [UIImage imageNamed:@"bg_normalImage_goback.png"];
        goBackBtn = [self  newButtonWithImage:goBackImage highlightedImage:[UIImage imageNamed:@"bg_highImage_goback.png"] frame:CGRectMake(10, 0, goBackImage.size.width, goBackImage.size.height) title:nil titleColor:nil titleShadowColor:nil font:nil target:self action:@selector(goBackBtnAction)];
        goBackBtn.enabled = NO;
        [bottomImageView addSubview:goBackBtn];
        
        UIImage *goForwardImage = [UIImage imageNamed:@"bg_normalImage_goForward.png"];
        goForwardBtn = [self  newButtonWithImage:goForwardImage highlightedImage:[UIImage imageNamed:@"bg_highImage_goForward.png"] frame:CGRectMake(10+goBackBtn.frame.size.width+20, goBackBtn.frame.origin.y, goForwardImage.size.width, goBackBtn.frame.size.height) title:nil titleColor:nil titleShadowColor:nil font:nil target:self action:@selector(goForwardBtnAction)];
        goForwardBtn.enabled = NO;
        [bottomImageView addSubview:goForwardBtn];
        
        UIImage *goRefreshImage = [UIImage imageNamed:@"bg_normalImage_refresh.png"];
        UIButton *goRefreshBtn = [self  newButtonWithImage:goRefreshImage highlightedImage:[UIImage imageNamed:@"bg_highImage_refresh.png"] frame:CGRectMake(goForwardBtn.frame.origin.x+goForwardBtn.frame.size.width+130, goBackBtn.frame.origin.y, goRefreshImage.size.width, goBackBtn.frame.size.height) title:nil titleColor:nil titleShadowColor:nil font:nil target:self action:@selector(goRefreshBtnAction)];
        [bottomImageView addSubview:goRefreshBtn];
    
    }
    return self;
}

-(void)goBackBtnAction{
    [webView goBack];
}

-(void)goForwardBtnAction{
    [webView goForward];
}

-(void)goRefreshBtnAction{
    [webView reload];
}

#pragma mark - UIWebViewDelegate Methods
- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = request.URL;
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
            return NO;
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)aWebView{
	if (aWebView == webView) {
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.frame = CGRectMake(145, 200, 30, 30);
        [self addSubview:indicatorView];
        [indicatorView startAnimating];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView{
    if (aWebView == webView){
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
    goBackBtn.enabled = [aWebView canGoBack];
    goForwardBtn.enabled = [aWebView canGoForward];
}

- (void)webView:(UIWebView *)aWebView didFailLoadWithError:(NSError *)error{
    if (aWebView == webView){
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        indicatorView = nil;
    }
}


@end
