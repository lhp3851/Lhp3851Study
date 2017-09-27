//
//  PHCollectionAssetTableViewCell.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/2/22.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PHCollectionAssetTableViewCell.h"

@implementation PHCollectionAssetTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    [self.contentView addSubview:self.assetImageView];
    [self.contentView addSubview:self.title];
}

-(UIImageView *)assetImageView{
    if (!_assetImageView) {
        _assetImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 2.5f, 75, 75)];
        _assetImageView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _assetImageView;
}

-(UILabel *)title{
    if (!_title) {
        _title=[[UILabel alloc]initWithFrame:CGRectMake(95, 0, kSCREENWIDTH, 75)];
        _title.font=[UIFont systemFontOfSize:17];
    }
    return _title;
}

-(void)configCellWithModel:(PHAssetCollection *)assetCollection{
    PHFetchResult<PHAsset *> *assetResult= [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    CGSize imageSize=CGSizeMake(75.0f, 75.0f);
    [[PHImageManager defaultManager] requestImageForAsset:assetResult.lastObject targetSize:imageSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        _assetImageView.image=result;
    }];
    _title.text=[NSString stringWithFormat:@"%@(%ld张)",assetCollection.localizedTitle,assetResult.count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
