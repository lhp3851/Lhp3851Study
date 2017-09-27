//
//  TableViewCell.h
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewProtocol.h"

@interface BaseTableViewCell : UITableViewCell

@property(nonatomic,strong) BaseModel *cellModel;

+(Class)classWithCallssModel:(BaseModel *)model;

//初始化cell类
-(instancetype)initWithReuseIdentifier:(NSString*)reuseIdentifier;


@end
