//
//  PHCollectionAssetTableViewCell.h
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/2/22.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/PHCollection.h>
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>

@interface PHCollectionAssetTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *assetImageView;

@property(nonatomic,strong)UILabel *title;

-(void)configCellWithModel:(PHAssetCollection *)assetCollection;

@end
