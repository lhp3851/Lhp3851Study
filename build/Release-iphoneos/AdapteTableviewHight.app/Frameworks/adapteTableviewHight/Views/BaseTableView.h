//
//  TableView.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/4/5.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import <MJRefresh/MJRefresh.h>

typedef NS_OPTIONS(NSUInteger, RefreshControl) {
    HeadRefreshControl  = 1 << 0,
    FootRefreshControl  = 1 << 1,
    BoothRefreshControl = HeadRefreshControl | FootRefreshControl,
};

@protocol BaseTableViewDelegate <NSObject>

-(void)refreshData;

-(void)loadData;

@end

@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)id externDelegate;//设置外部代理

@property(nonatomic,strong)NSMutableArray <NSMutableArray *>*dataList;//数组最好呈二维的形式传进来，便于tableView分组

@property(nonatomic,assign)RefreshControl refreshControles;

@property(nonatomic,strong)MJRefreshNormalHeader *headerRefresh;

@property(nonatomic,strong)MJRefreshAutoNormalFooter *footerRefresh;

@end
