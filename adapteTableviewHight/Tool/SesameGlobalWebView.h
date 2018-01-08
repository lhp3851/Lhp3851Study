//
//  SesameGlobalWebView.h
//  Sesame
//
//  Created by 刘文龙 on 13-11-25.
//  Copyright (c) 2013年 刘文龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SesameGlobalWebView : UIView<UIWebViewDelegate>{
    UIActivityIndicatorView *indicatorView;
    UIWebView *webView;
    
    UIButton *goBackBtn;
    UIButton *goForwardBtn;
}
@property(nonatomic,retain)UIWebView *webView;
- (id)initWithFrame:(CGRect)frame DataString:(NSString *)dataString;
@end
