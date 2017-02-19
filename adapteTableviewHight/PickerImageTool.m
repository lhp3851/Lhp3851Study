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

@interface PickerImageTool ()
@property(nonatomic,assign)UIImagePickerControllerSourceType openType;
@property(nonatomic,assign)BOOL editable;
@property(nonatomic,strong)UIViewController *VControler;
@property(nonatomic,strong)UIImage *pickedImage;
@property(nonatomic)       PikeredImageHandler pickerHandler;
@end

@implementation PickerImageTool

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

-(instancetype)initWithType:(UIImagePickerControllerSourceType)type allowEdit:(BOOL)editable ViewCotroler:(UIViewController *)viewController pickerImage:(PikeredImageHandler)pickerImageHandler{
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
    UIAlertAction *actionLib=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotosLibraryWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotosLibraryWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotosLibraryWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertVC addAction:actionLib];
    [alertVC addAction:actionCamera];
    [alertVC addAction:actionCancel];
    [viewContrroler presentViewController:alertVC animated:YES completion:^{
        
    }];
}

-(void)openPhotosLibraryWithType:(UIImagePickerControllerSourceType)openType{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.sourceType=openType;
    imagePicker.allowsEditing=YES;
    imagePicker.delegate     =self;
    [self.VControler presentViewController:imagePicker animated:YES completion:^{
        NSLog(@"完成");
    }];
}

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
