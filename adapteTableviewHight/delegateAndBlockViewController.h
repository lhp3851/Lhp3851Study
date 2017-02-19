//
//  delegateAndBlockViewController.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/25.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockViewController.h"
#import "DelegateViewController.h"

//定义一个协议
@protocol ViewControllerDelegate<NSObject>
- (void)selfDelegateMethod;
//协议传值
- (void)passTextValue:(NSString *)tfText;
@end

@interface delegateAndBlockViewController : UIViewController<ViewControllerDelegate>

@property (nonatomic,assign)id<ViewControllerDelegate>delegate;






//方法定义
-(IBAction)delegatePassContent:(id)sender;

-(IBAction)blockPassContent:(id)sender;
@end
