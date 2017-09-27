//
//  PHAssetViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/2/22.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PHAssetViewController.h"
#import "PHAssetCollectionViewCell.h"
#import "PhotoBrowserViewController.h"
#import "AVVedioMovePlayerViewController.h"

static NSString *cellID=@"cellID";

@interface PHAssetViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *assetCollectionView;

@property(nonatomic,strong)PHFetchResult <PHAsset *> *assets;
@end

@implementation PHAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.assetCollectionView];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(dismisFromCurrent)];
}

-(void)initData{
    self.navigationItem.title=NSLocalizedString(self.assetCollection.localizedTitle, nil);
}

-(UICollectionView *)assetCollectionView{
    if (!_assetCollectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _assetCollectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _assetCollectionView.backgroundColor=[UIColor whiteColor];
        _assetCollectionView.delegate=self;
        _assetCollectionView.dataSource=self;
        [_assetCollectionView registerClass:NSClassFromString(@"PHAssetCollectionViewCell") forCellWithReuseIdentifier:cellID];
    }
    return _assetCollectionView;
}

-(void)setAssetCollection:(PHAssetCollection *)assetCollection{
    _assetCollection=assetCollection;
    PHFetchResult <PHAsset *> *asset=[PHAsset fetchAssetsInAssetCollection:_assetCollection options:nil];
    _assets=asset;
}


#pragma mark collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.assets.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80.0f, 80.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 0, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.0f;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAssetCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    PHAsset *asset=self.assets[self.assets.count-1 -indexPath.row];
    [cell configerCellWithModle:asset];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset *asset=self.assets[self.assets.count-1 -indexPath.row];
    if (asset.mediaType==PHAssetMediaTypeImage) {
        NSLog(@"indexPath:%@-%ld",indexPath,asset.mediaType);
        PhotoBrowserViewController *photoBrowserVC=[[PhotoBrowserViewController alloc]init];
        photoBrowserVC.assetCollection=self.assetCollection;
        photoBrowserVC.index=self.assets.count-1 -indexPath.row;
        [self.navigationController pushViewController:photoBrowserVC animated:YES];
    }else if (asset.mediaType==PHAssetMediaTypeVideo){
        AVVedioMovePlayerViewController *avVedioVC=[AVVedioMovePlayerViewController shareVedioPlayer];
        avVedioVC.PHAssetVedio=asset;
        [self.navigationController pushViewController:avVedioVC animated:YES];
    }
}

-(void)dismisFromCurrent{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
