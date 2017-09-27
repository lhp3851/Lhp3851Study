//
//  sinaWeiBoTableViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/20.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "sinaWeiBoTableViewController.h"
#import "BookActivity.h"

@interface sinaWeiBoTableViewController (){

    NSMutableArray *socialMediaItem;
    
}

@end

@implementation sinaWeiBoTableViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    socialMediaItem=[[NSMutableArray alloc]init];//会导致页面崩溃，why？
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的微博";
     self.clearsSelectionOnViewWillAppear = NO;
    
    UIBarButtonItem *shareItem=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(sendWeiBo:)];
    
     self.navigationItem.rightBarButtonItem = shareItem;
    
    UIRefreshControl *RC=[[UIRefreshControl alloc]init];
    RC.attributedTitle=[[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [RC addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl=RC;
    
    socialMediaItem=[NSMutableArray arrayWithObjects:@"socialList",@"Facebook",@"Twitter",@"SinaWeiBo",@"Message",@"Mail",@"Print",@"PasteBoard",@"Contact",@"CameraRoll", @"TencentWeiBo",@"WeCaht",@"QQ",@"QZone", nil];
    
    [self.tableView reloadData];
}

-(void)refreshTableView{
    if (self.refreshControl.isRefreshing) {
        self.refreshControl.attributedTitle=[[NSAttributedString alloc]initWithString:@"加载中"];
        
        ACAccountStore *acount=[[ACAccountStore alloc]init];
        
        ACAccountType *acountType=[acount accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierSinaWeibo];
        [acount requestAccessToAccountsWithType:acountType options:nil completion:^(BOOL granted, NSError *error) {
            if (granted==YES) {
                NSArray *arrayOfAccounts=[acount accountsWithAccountType:acountType];
                
                if (arrayOfAccounts.count>0) {
                    ACAccount *weiboAccount=[arrayOfAccounts lastObject];
                    NSDictionary *parameter=[NSDictionary dictionaryWithObject:@"20" forKey:@"count"];
                    
                    NSURL *requestURL=[NSURL URLWithString:@"https://api.weibo.com/2/statuses/user_timeline.json"];
                    SLRequest *request=[SLRequest requestForServiceType:SLServiceTypeSinaWeibo requestMethod:SLRequestMethodGET URL:requestURL parameters:parameter];
                    request.account=weiboAccount;
                    
                    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                        NSError *erro;
                        id jsonObj=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&erro];
                        
                        if (!erro) {
                            _listArray=[jsonObj objectForKey:@"statuses"];
                            [socialMediaItem removeAllObjects];
                            [self.tableView reloadData];
                        }
                        else{
                            [self.refreshControl endRefreshing];
                            [self.tableView reloadData];
                        }
                        
                        NSLog(@"WeiBo HTTP response %li",(long)[urlResponse statusCode]);
                        
                        if (self.refreshControl) {
                            [self.refreshControl endRefreshing];
                            self.refreshControl.attributedTitle=[[NSAttributedString alloc]initWithString:@"下拉刷新"];
                        }
                    }];
                }
            }
        }
         ];
    }
}

-(void)sendWeiBo:(id)sender{
    sendWeiboViewController *sendWeiBoVC=[[sendWeiboViewController alloc]initWithNibName:@"sendWeiboViewController" bundle:nil];
    [self.navigationController pushViewController:sendWeiBoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_listArray.count>0) {
        return _listArray.count;
    }
    else{
        NSLog(@"socialMediaItem.count:%lu",(unsigned long)socialMediaItem.count);
        return socialMediaItem.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    if (_listArray.count>0) {
        NSDictionary *rowDic=[_listArray objectAtIndex:indexPath.row];
        cell.textLabel.text=[rowDic objectForKey:@"text"];
        cell.detailTextLabel.text=[rowDic objectForKey:@"created_at"];
    }
    else{
        if (indexPath.row==0) {
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            cell.textLabel.textColor=[UIColor blueColor];
        }
//        cell.imageView.image=[UIImage imageNamed:@""];
        cell.textLabel.text=[socialMediaItem objectAtIndex:indexPath.row];
    }
    
//    NSDictionary *rowDic=[_listArray objectAtIndex:indexPath.row];
//    cell.textLabel.text=[rowDic objectForKey:@"text"];
//    cell.detailTextLabel.text=[rowDic objectForKey:@"created_at"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_listArray.count>0) {
        
    }
    else{
       
        NSLog(@"selected：%@",[socialMediaItem objectAtIndex:indexPath.row]);
        
        switch (indexPath.row) {
            case 0:{
                NSString *textToShare=@"请大家登录《iOS云端与网络通讯》服务网站.";
                UIImage *imageToShare=[UIImage imageNamed:@"iosshare.jpg"];
                NSURL *urlToShare=[NSURL URLWithString:@"http://www.iosbook3.com"];
                NSArray *activtyItems=@[textToShare,imageToShare,urlToShare];
                
//                NSURL *urlToShare=[NSURL URLWithString:@"http://www.iosbook3.com/?page_id=4"];
//                NSArray *activtyItems=@[urlToShare];
                BookActivity *bookAcitvity=[BookActivity new];
            
                NSArray *applicationActivityes=@[bookAcitvity];//自定义分享选项
                
                UIActivityViewController *activityVC=[[UIActivityViewController alloc]initWithActivityItems:activtyItems applicationActivities:applicationActivityes];
                
                //不出现在活动项目
                activityVC.excludedActivityTypes=@[UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeMail,UIActivityTypeAddToReadingList];
                
                [self presentViewController:activityVC animated:YES completion:^{}];
                break;
            }
                
            case 3:{//撰写视图控制器
                SLComposeViewController *composeVC=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];

                if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
                    SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
                        [composeVC dismissViewControllerAnimated:YES completion:nil];
                        
                        switch (result) {
                            case SLComposeViewControllerResultCancelled:
                                NSLog(@"cancled");
                                break;
                              case SLComposeViewControllerResultDone:
                                NSLog(@"posted...");
                            default:
                                NSLog(@"cancled");
                                break;
                        }
                    };
                    
                    [composeVC addImage:[UIImage imageNamed:@"iosshare.jpg"]];
                    [composeVC setInitialText:@"请大家登录《iOS云端与网络通讯》服务网站."];
                    [composeVC addURL:[NSURL URLWithString:@"http://www.iosbook3.com"]];
                    [composeVC setCompletionHandler:completionHandler];
                    
                    [self presentViewController:composeVC animated:YES completion:^{}];
                    
                }
            }
                
            default:
                break;
        }
        
    }
}


-(void)shareAction{//自定义分享选项
    NSURL *urlToShare=[NSURL URLWithString:@"http://www.iosbook3.com/?page_id=4"];
    NSArray *activityItem=@[urlToShare];
    
    BookActivity *bookAcitvity=[BookActivity new];
    NSArray *applicationActivityes=@[bookAcitvity];
    
    UIActivityViewController *activityVC=[[UIActivityViewController alloc]initWithActivityItems:activityItem applicationActivities:applicationActivityes];
    [self presentViewController:activityVC animated:YES completion:^{}];
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
