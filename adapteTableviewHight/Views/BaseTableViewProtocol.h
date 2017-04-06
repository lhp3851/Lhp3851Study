//
//  BaseTableViewProtocol.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/4/6.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@protocol BaseTableViewProtocol <NSObject>

@required
+(instancetype)cellWithTableView:(UITableView *)tableView model:(BaseModel *)model;


@optional




@end
