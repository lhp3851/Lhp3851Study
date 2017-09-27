//
//  UIVisibleViewViewController.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/26.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//
/**
 本类包含UIImageView、UILabel、UIProgressView、UIActivityIndicatorView...
 */
#import <UIKit/UIKit.h>

@interface UIVisibleViewViewController : UIViewController
{
    UILabel *lable;
}


@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end
