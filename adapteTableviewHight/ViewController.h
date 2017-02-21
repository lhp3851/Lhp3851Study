//
//  ViewController.h
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userModel.h"
#import "TableViewCell.h"
#import "DateTool.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *tableView;

@end

