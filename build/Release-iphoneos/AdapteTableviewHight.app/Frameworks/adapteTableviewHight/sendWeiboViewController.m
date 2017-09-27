//
//  sendWeiboViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/20.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "sendWeiboViewController.h"

@interface sendWeiboViewController ()

@end

@implementation sendWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发送微博";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(sendWeiBo:)];
    
}

-(void)sendWeiBo:(id)sender{
    ACAccountStore *account=[[ACAccountStore alloc]init];
    ACAccountType *acountTyoe=[account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierSinaWeibo];
    
    [account requestAccessToAccountsWithType:acountTyoe options:nil completion:^(BOOL granted, NSError *error) {
        if (granted==YES) {
            NSArray *arrayOfAccounts=[account accountsWithAccountType:acountTyoe];
            
            if (arrayOfAccounts.count>0) {
                ACAccount *weiBoAccount=[arrayOfAccounts lastObject];
                NSDictionary *parameter=[NSDictionary dictionaryWithObject:self.contenttextView.text forKey:@"status"];
                NSURL *requestURL=[NSURL URLWithString:@"https://api.weibo.com/2/statuses/update.json"];
                
                SLRequest *request=[SLRequest requestForServiceType:SLServiceTypeSinaWeibo requestMethod:SLRequestMethodPOST URL:requestURL parameters:parameter];
                request.account=weiBoAccount;
                
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    NSLog(@"WeiBo HTTP response:%li",(long)[urlResponse statusCode]);
                    
                }];
            }
            
        }
    }];
    
    [self.contenttextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *content=self.contenttextView.text;
    NSInteger count=140-content.length;
    
    if (count<=0) {
        self.chareCount.text=@"0";
        return NO;
    }
    self.chareCount.text=[NSString stringWithFormat:@"%li",(long)count];
    return YES;
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
