//
//  scrollToOtherPageViewController.h
//  adapteTableviewHight
//
//  Created by ZizTour on 6/24/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMLazyScrollView.h"

@interface scrollToOtherPageViewController : UIViewController<DMLazyScrollViewDelegate>

@property (nonatomic,strong)DMLazyScrollView *dmlazyScollView;

@end
