//
//  NotificationViewController.h
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2016/10/30.
//  Copyright © 2016年 lhp3851. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *noticeTitle;
@property (weak, nonatomic) IBOutlet UITextView *noticeContent;
@property (weak, nonatomic) IBOutlet UITextField *noticeURL;
@property (weak, nonatomic) IBOutlet UIButton *noticeImage;


-(IBAction)selectImage:(id)sender;
-(IBAction)pushNotice:(id)sender;

@end
