//
//  PhotosViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PhotosViewController.h"
#import "ImagePickerRootViewController.h"
#import "PhotosTool.h"
#import "PickerImageTool.h"

@interface PhotosViewController ()<PHPhotoLibraryChangeObserver,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)PickerImageTool *pickerImageTool;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

-(void)initData{
    self.navigationItem.title=@"相册";
    
   [[PhotosTool shareLibrary] registerChangeObserver:self];
    
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *photosBTN=[UIButton buttonWithType:UIButtonTypeCustom];
    [photosBTN setFrame:CGRectMake(kHMARGIN, kSCREENHEIGHT/2-20, kSCREENWIDTH-2*kHMARGIN, 40)];
    [photosBTN setTitle:@"相册" forState:UIControlStateNormal];
    [photosBTN setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [photosBTN addTarget:self action:@selector(openPhotosLibrary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photosBTN];
}

-(void)openPhotosLibrary{
//    self.pickerImageTool=[[PickerImageTool alloc]initWithType:UIImagePickerControllerSourceTypePhotoLibrary allowEdit:YES ViewCotroler:self pickerImage:^(UIImage *image) {
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(HMARGIN, kNAVIGATION_BAR_HEIGHT+kSTATUS_BAR_HEIGHT, 200, 200)];
//        imageView.image=image;
//        [self.view addSubview:imageView];
//        self.pickerImageTool=nil;
//    }];
    ImagePickerRootViewController *imagePickerVC=[ImagePickerRootViewController shareImagePickerRootViewController];
    [self.navigationController pushViewController:imagePickerVC animated:YES];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image=info[UIImagePickerControllerEditedImage];
    NSLog(@"Media:%@,image:%@",info,image);
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    NSLog(@"lllll22");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.pickerImageTool = nil;
}

-(void)dealloc{
    self.pickerImageTool = nil;
}

@end
