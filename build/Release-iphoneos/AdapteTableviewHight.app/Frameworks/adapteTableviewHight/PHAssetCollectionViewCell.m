//
//  PHAssetCollectionViewCell.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/2/22.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PHAssetCollectionViewCell.h"

@implementation PHAssetCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.imageView];
    [self addSubview:self.checkBtn];
    [self addSubview:self.durationLab];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        CGSize imageSize=CGSizeMake(75.0f, 75.0f);
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

-(UIButton *)checkBtn{
    if (!_checkBtn) {
        _checkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame=CGRectMake(self.frame.size.width-20.0f-7.5f, kHMARGIN/2, 20.0f, 20.0f);
        [_checkBtn setFrame:frame];
        _checkBtn.layer.cornerRadius=frame.size.width/2;
        _checkBtn.layer.masksToBounds=YES;
        _checkBtn.backgroundColor=[UIColor lightGrayColor];
        [_checkBtn addTarget:self action:@selector(checkStatus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

-(UILabel *)durationLab{
    if (!_durationLab) {
        _durationLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 55.0f, self.frame.size.width-8, 20.0f)];
        _durationLab.font=[UIFont systemFontOfSize:12];
        _durationLab.textColor=[UIColor whiteColor];
        _durationLab.numberOfLines=2;
        _durationLab.textAlignment=NSTextAlignmentRight;
    }
    return _durationLab;
}

-(void)checkStatus:(id)sender{
    UIButton *button=(UIButton *)sender;
    button.selected=!button.selected;
    button.backgroundColor=button.selected?[UIColor blueColor]:[UIColor lightGrayColor];
}

-(void)configerCellWithModle:(PHAsset *)asset{
    CGSize imageSize=CGSizeMake(75.0f, 75.0f);
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:imageSize
                                              contentMode:PHImageContentModeAspectFill
                                                  options:nil
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        _imageView.image=result;
    }];
    if (asset.mediaType==PHAssetMediaTypeImage) {
        _durationLab.hidden=YES;
        _checkBtn.hidden=NO;
    }
    else if (asset.mediaType==PHAssetMediaTypeVideo){
        _durationLab.hidden=NO;
        _checkBtn.hidden=YES;
        float assetTime=asset.duration/kMinute;
        if (assetTime>60) {
            assetTime=assetTime/kMinute;
        }
        NSString *duration=[NSString stringWithFormat:@"%.2f",assetTime];
        _durationLab.text=[duration replaceCharcter:@"." withCharcter:@":"];
    }
}

@end
