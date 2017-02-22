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


typedef void(^PickedImageHandler)(UIImage *image);//取到照片后的处理
typedef void (^PickedCollectionListHandler)(NSArray *collectionList,NSArray *collectionListItem);//取到相册列表的处理


@interface PickerImageTool : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

+(id)shareInstance;

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController;

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController pickerImage:(PickedImageHandler)pickerImageHandler;

-(void)getPhotosCollectionList:(PickedCollectionListHandler)pickedCollectionListHandler;
@end
