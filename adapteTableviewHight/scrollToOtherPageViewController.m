//
//  scrollToOtherPageViewController.m
//  adapteTableviewHight
//
//  Created by ZizTour on 6/24/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import "scrollToOtherPageViewController.h"

#define ARC4RANDOM_MAX	0x100000000

@interface scrollToOtherPageViewController ()
{
    NSMutableArray*    viewControllerArray;
}
@end

@implementation scrollToOtherPageViewController
@synthesize dmlazyScollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // PREPARE PAGES
    NSUInteger numberOfPages = 10;
    viewControllerArray = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
    for (NSUInteger k = 0; k < numberOfPages; ++k) {
        [viewControllerArray addObject:[NSNull null]];
    }
    
    // PREPARE LAZY VIEW
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    dmlazyScollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    [dmlazyScollView setEnableCircularScroll:YES];
    [dmlazyScollView setAutoPlay:YES];
    
    __weak __typeof(&*self)weakSelf = self;
    dmlazyScollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    dmlazyScollView.numberOfPages = numberOfPages;
    // lazyScrollView.controlDelegate = self;
    [self.view addSubview:dmlazyScollView];
}


- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > viewControllerArray.count || index < 0) return nil;
    id res = [viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        UIViewController *contr = [[UIViewController alloc] init];
        contr.view.backgroundColor = [UIColor colorWithRed: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                     green: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                      blue: (CGFloat)arc4random()/ARC4RANDOM_MAX
                                                     alpha: 1.0f];
        
        UILabel* label = [[UILabel alloc] initWithFrame:contr.view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%ld",index];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:50];
        [contr.view addSubview:label];
        
        [viewControllerArray replaceObjectAtIndex:index withObject:contr];
        return contr;
    }
    return res;
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
