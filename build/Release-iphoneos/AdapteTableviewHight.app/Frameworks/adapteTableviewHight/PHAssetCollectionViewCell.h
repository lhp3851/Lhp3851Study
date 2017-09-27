//
//  PHAssetCollectionViewCell.h
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/2/22.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>

@interface PHAssetCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UIButton    *checkBtn;

@property(nonatomic,strong)UILabel     *durationLab;

-(void)configerCellWithModle:(PHAsset *)asset;

@end
