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


typedef void(^PikeredImageHandler)(UIImage *image);

@interface PickerImageTool : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController;

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController pickerImage:(PikeredImageHandler)pickerImageHandler;

@end
