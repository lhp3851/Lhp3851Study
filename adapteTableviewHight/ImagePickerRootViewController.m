//
//  ImagePickerRootViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "ImagePickerRootViewController.h"
#import "PHAssetViewController.h"
#import <Photos/Photos.h>
#import "PHCollectionAssetTableViewCell.h"

typedef void (^ImageRequestResultBlock)(UIImage *__nullable result, NSDictionary *__nullable info);

@interface ImagePickerRootViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property(nonatomic,strong)UITableView *photoTableview;
@property(nonatomic,strong)NSMutableArray *collectionList;//相册
@property(nonatomic,strong)NSMutableArray *collectionListItem;//相册里的元素
@end

@implementation ImagePickerRootViewController

+(id)shareImagePickerRootViewController{
    static ImagePickerRootViewController *rootVC=nil;
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        rootVC=[self new];
    });
    return rootVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.photoTableview];
}

-(void)initData{
    self.navigationItem.title=NSLocalizedString(@"相册列表", nil);
    self.collectionListItem=[NSMutableArray array];
    self.collectionList=[NSMutableArray array];
    [self getPhotosCollectionList];
}

-(UITableView *)photoTableview{
    if (!_photoTableview) {
        _photoTableview=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _photoTableview.delegate=self;
        _photoTableview.dataSource=self;
    }
    return _photoTableview;
}

-(void)getPhotosCollectionList{
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [self.collectionList addObject:smartAlbums];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"localizedTitle 1:%@",obj.localizedTitle);
        PHFetchResult<PHAsset *> *assetResult= [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        if (assetResult.count) {
            [self.collectionListItem addObject:obj];
        }
    }];
    
    // 列出所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    [self.collectionList addObject:topLevelUserCollections];
    [topLevelUserCollections enumerateObjectsUsingBlock:^(PHAssetCollection  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"localizedTitle 2:%@",obj.localizedTitle);
        PHFetchResult<PHAsset *> *assetResult= [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        if (assetResult.count) {
            [self.collectionListItem addObject:obj];
        }
    }];
    
    // 列出所有时刻相册
//    PHFetchResult<PHCollectionList *> *photosResult= [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeMomentList subtype:PHCollectionListSubtypeAny options:nil];
//    [self.collectionList addObject:photosResult];
//    [photosResult enumerateObjectsUsingBlock:^(PHCollectionList  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"localizedTitle 3:%@",obj.localizedTitle);
//        [self.collectionListItem addObject:obj];
////        PHCollectionList *list=obj;
////        NSLog(@"localizedLocationNames：%@，localizedTitle：%@",list.localizedLocationNames,list.localizedTitle);
////        
////        PHFetchResult<PHAssetCollection *> *photoCollectionResult=[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
////        [photoCollectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////            PHFetchResult<PHAsset *> *assetResult=[PHAsset fetchAssetsInAssetCollection:obj options:nil];
////            NSLog(@"相册名字：%@，%ld",obj.localizedTitle,assetResult.count);
////            //            [assetResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////            //
////            //                [[PHImageManager defaultManager] requestImageForAsset:obj targetSize:CGSizeZero contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
////            ////                    UIImage *image=result;
////            ////                    NSLog(@"image.Description:%@",info);
////            //                }];
////            //            }];
////            //
////        }];
//    }];
    
    // 获取所有资源的集合，并按资源的创建时间排序
//    PHFetchOptions *options = [[PHFetchOptions alloc] init];
//    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
//    [assetsFetchResults enumerateObjectsUsingBlock:^(PHAsset  *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"localizedTitle  3:%@",obj.burstIdentifier);
//    }];
}

-(void)getLatestItemOfCollectionList:(PHAssetCollection *)assetCollection result:(ImageRequestResultBlock)imageRequestResultBlock{
//    [collectionList enumerateObjectsUsingBlock:^(PHCollectionList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//       PHFetchResult<PHCollection *> *collectionResult=[PHCollection fetchCollectionsInCollectionList:obj options:nil];
//        [collectionResult enumerateObjectsUsingBlock:^(PHCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            PHFetchResult<PHAssetCollection *> *assetCollectionResult=[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//            [assetCollectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                
//               PHFetchResult<PHAsset *> *assetResult= [PHAsset fetchAssetsInAssetCollection:obj options:nil];
//                CGSize imageSize=CGSizeMake(50.0f, 50.0f);
//                [[PHImageManager defaultManager] requestImageForAsset:assetResult.lastObject targetSize:imageSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                    
//                }];
//            }];
//        }];
//    }];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult<PHAsset *> *assetResult= [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    CGSize imageSize=CGSizeMake(150.0f, 150.0f);
    [[PHImageManager defaultManager] requestImageForAsset:assetResult.lastObject targetSize:imageSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        imageRequestResultBlock(result,info);
    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectionListItem.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifiler=@"cellIdentifiler";
    PHCollectionAssetTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifiler];
    if (cell==nil) {
        cell=[[PHCollectionAssetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifiler];
    }
    PHAssetCollection *assetCollection=self.collectionListItem[indexPath.row];
    [cell configCellWithModel:assetCollection];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PHAssetViewController *assetVC=[[PHAssetViewController alloc]init];
    assetVC.assetCollection=self.collectionListItem[indexPath.row];
    [self.navigationController pushViewController:assetVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
