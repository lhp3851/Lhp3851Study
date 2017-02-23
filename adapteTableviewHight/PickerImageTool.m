//
//  PickerImageTool.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PickerImageTool.h"
#import "TopViewController.h"
#import "WindowTool.h"
//#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface PickerImageTool ()
@property(nonatomic,assign)UIImagePickerControllerSourceType openType;
@property(nonatomic,assign)BOOL editable;
@property(nonatomic,strong)UIViewController *VControler;
@property(nonatomic,strong)UIImage *pickedImage;
@property(nonatomic)       PickedImageHandler pickerHandler;
@end

@implementation PickerImageTool

+(id)shareInstance{
    static PickerImageTool *tool=nil;
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        tool=[[PickerImageTool alloc]init];
    });
    return tool;
}

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController{
    self=[super init];
    if (self) {
        self.VControler=viewController;
        self.openType=type;
        self.editable=editable;
        [self initViewWithVC:viewController];
    }
    return self;
}

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController pickerImage:(PickedImageHandler)pickerImageHandler{
    self=[super init];
    if (self) {
        self.VControler=viewController;
        self.openType=type;
        self.editable=editable;
        self.pickerHandler=pickerImageHandler;
        [self initViewWithVC:viewController];
    }
    return self;
}

-(void)initViewWithVC:(UIViewController *)viewContrroler{
    UIAlertController *alertVC=[[UIAlertController alloc]init];
    UIAlertAction *actionLib=[UIAlertAction actionWithTitle   :@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotosLibraryWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotosLibraryWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:actionLib];
    [alertVC addAction:actionCamera];
    [alertVC addAction:actionCancel];
    [viewContrroler presentViewController:alertVC animated:YES completion:^{
        
    }];
}

-(void)openPhotosLibraryWithType:(UIImagePickerControllerSourceType)openType{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType   =openType;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate     =self;
    
    /**
     imagePicker.cameraViewTransform=CGAffineTransformMakeRotation(-1.5);
     http://upload-images.jianshu.io/upload_images/301562-6a1c1a444d6a9c3a.png?imageView2/2/w/1240/q/100
     http://upload-images.jianshu.io/upload_images/301562-bd6bbe0ebefb89d4.png?imageView2/2/w/1240/q/100
     */
    [self.VControler presentViewController:imagePicker animated:YES completion:^{
        UINavigationController *nav=imagePicker.navigationController;
        NSArray *viewControllers=[nav viewControllers];
        UIViewController *topImagePickerVC=nav.topViewController;
        
        NSLog(@"topVC:%@",topImagePickerVC);
        [viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"viewControllers :%ld-%@\n",idx,obj);
        }];
    }];
}

-(void)getPhotosCollectionList:(PickedCollectionListHandler)pickedCollectionListHandler{
    NSMutableArray *collectionList=[NSMutableArray array];
    NSMutableArray *collectionListItem=[NSMutableArray array];
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [collectionList addObject:smartAlbums];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"localizedTitle 1:%@",obj.localizedTitle);
        PHFetchResult<PHAsset *> *assetResult= [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        if (assetResult.count) {
            [collectionListItem addObject:obj];
        }
    }];
    
    // 列出所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    [collectionList addObject:topLevelUserCollections];
    [topLevelUserCollections enumerateObjectsUsingBlock:^(PHAssetCollection  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"localizedTitle 2:%@",obj.localizedTitle);
        PHFetchResult<PHAsset *> *assetResult= [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        if (assetResult.count) {
            [collectionListItem addObject:obj];
        }
    }];
    pickedCollectionListHandler(collectionList,collectionListItem);
}


-(void)getImageWithAsset:(PHAsset *)asset imageSize:(CGSize)size result:(ImageResult)pickedImageHandler{
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        pickedImageHandler(result,info);
    }];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.pickedImage=info[UIImagePickerControllerEditedImage];
    if (self.pickerHandler) {
        self.pickerHandler(self.pickedImage);
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
