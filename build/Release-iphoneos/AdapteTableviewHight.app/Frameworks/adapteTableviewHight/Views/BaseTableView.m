//
//  TableView.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/4/5.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
    }
    return self;
}

-(void)setExternDelegate:(id)externDelegate{
    _externDelegate=externDelegate;
}

-(MJRefreshHeader *)headerRefresh{
    if (!_headerRefresh) {
        __weak typeof(self) weakSelf = self;
        _headerRefresh=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refreshDataWithState:MJRereshOperateRefresh];
        }];
        [_headerRefresh setTitle:@"下拉刷新"    forState:MJRefreshStateIdle];
        [_headerRefresh setTitle:@"松开刷新数据" forState:MJRefreshStatePulling];
        [_headerRefresh setTitle:@"刷新数据"    forState:MJRefreshStateRefreshing];
        [_headerRefresh setTitle:@"正在刷新"    forState:MJRefreshStateWillRefresh];
    }
    return _headerRefresh;
}

-(MJRefreshFooter *)footerRefresh{
    if (!_footerRefresh) {
        __weak typeof(self) weakSelf = self;
        _footerRefresh= [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf refreshDataWithState:MJRereshOperateLoad];
        }];
        [_footerRefresh setTitle:@"下拉刷新"       forState:MJRefreshStateIdle];
        [_footerRefresh setTitle:@"松开刷新数据"    forState:MJRefreshStatePulling];
        [_footerRefresh setTitle:@"刷新数据"       forState:MJRefreshStateRefreshing];
        [_footerRefresh setTitle:@"将要刷新"       forState:MJRefreshStateWillRefresh];
        [_footerRefresh setTitle:@"没有更多的数据了" forState:MJRefreshStateNoMoreData];
    }
    return _footerRefresh;
}

-(void)setRefreshControles:(RefreshControl)refreshControles{
    switch (refreshControles) {
        case HeadRefreshControl:
            self.mj_header = self.headerRefresh;
            break;
        case FootRefreshControl:{
            self.mj_footer = self.footerRefresh;
        }
            break;
        default:{
            self.mj_header = self.headerRefresh;
            self.mj_footer = self.footerRefresh;
        }
            break;
    }
}

-(void)refreshDataWithState:(MJRereshOperate)operate{
    if (operate == MJRereshOperateAuto || operate == MJRereshOperateRefresh) {
        [self refreshData];
    }
    else{
        [self loadData];
    }
}

-(void)refreshData{
    if (self.externDelegate && [self.externDelegate conformsToProtocol:@protocol(BaseTableViewDelegate)] &&[self.externDelegate respondsToSelector:@selector(refreshData)]) {
        [self.externDelegate refreshData];
    }
}

-(void)loadData{
    if (self.externDelegate && [self.externDelegate conformsToProtocol:@protocol(BaseTableViewDelegate)] &&[self.externDelegate respondsToSelector:@selector(loadData)]) {
        [self.externDelegate loadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseModel *model=self.dataList[indexPath.section][indexPath.row];
    Class cls = [BaseTableViewCell classWithCallssModel:model];
    __kindof UITableViewCell <BaseTableViewProtocol> *cell=[cls cellWithTableView:tableView model:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
