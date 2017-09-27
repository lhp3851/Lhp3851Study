//
//  TableViewCell.m
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import "BaseTableViewCell.h"

static Class class;

static NSDictionary *cellAndModeDic;

static NSString *cellID = @"BaseTableViewCell";

@interface BaseTableViewCell ()
//用户名
@property(nonatomic,retain) UILabel *name;
//用户介绍
@property(nonatomic,retain) UILabel *introduction;
//用户头像
@property(nonatomic,retain) UIImageView *userImage;



//给用户介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;
@end

@implementation BaseTableViewCell

+(void)cellAndModelDic{
    cellAndModeDic=@{@(ModelTypeNormal):@"BaseTableViewCell",
                     };
}

+(Class)classWithCallssModel:(BaseModel *)model{
    NSString *className = cellAndModeDic[@(model.type)];
    Class cls=NSClassFromString(className);
    class =cls;
    return cls;
}

-(instancetype)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView model:(BaseModel *)model{
    BaseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


//初始化控件
-(void)initLayuot{
   
}

//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString*)text{

}


/**
 显示数据

 @param cellModel cell要显示的数据
 */
-(void)setCellModel:(BaseModel *)cellModel{
    _cellModel=cellModel;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}



@end
