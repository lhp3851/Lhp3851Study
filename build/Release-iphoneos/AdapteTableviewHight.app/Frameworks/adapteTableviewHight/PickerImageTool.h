//
//  PickerImageTool.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

/**
    注意：申明变量的时候要强引用，否则打不开相册
     self.pickerImageTool=[[PickerImageTool alloc]initWithType:UIImagePickerControllerSourceTypePhotoLibrary allowEdit:YES ViewCotroler:self pickerImage:^(UIImage *image) {
         UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(HMARGIN, 64, 200, 200)];
         imageView.image=image;
         [self.view addSubview:imageView];
         self.pickerImageTool=nil;//避免浪费空间，记得释放
     }];
 */

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


typedef void(^PickedImageHandler)(UIImage *image);//取到照片后的处理
typedef void (^PickedCollectionListHandler)(NSArray *collectionList,NSArray *collectionListItem);//取到相册列表的处理
typedef void (^ImageResult)(UIImage * result, NSDictionary * info);//获取到的照片

@interface PickerImageTool : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

+(id)shareInstance;

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController;

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController pickerImage:(PickedImageHandler)pickerImageHandler;

/**
 获取所有PHCollectionList集合

 @param pickedCollectionListHandler 获取到所有照片集合后的回调处理
 */
-(void)getPhotosCollectionList:(PickedCollectionListHandler)pickedCollectionListHandler;

/**
 获取照片

 @param asset PHAsset
 @param size  预期的照片size
 @param result 获取到照片后的回调处理
 */
-(void)getImageWithAsset:(PHAsset *)asset imageSize:(CGSize)size result:(ImageResult)pickedImageHandler;

@end
