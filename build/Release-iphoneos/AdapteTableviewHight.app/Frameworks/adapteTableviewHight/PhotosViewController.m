//
//  PhotosViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PhotosViewController.h"
#import "ImagePickerRootViewController.h"
#import "PHAssetViewController.h"
#import "PhotosTool.h"
#import "PickerImageTool.h"
#import "MainNavigationController.h"

@interface PhotosViewController ()<PHPhotoLibraryChangeObserver,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)PickerImageTool *pickerImageTool;
@end

@implementation PhotosViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.tabBarController.tabBar shadowImage];
//    self.tabBarController.tabBar.hidden=NO;
}

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
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(openSelfPhotoLibrary)];
    
    
    UIButton *photosBTN=[UIButton buttonWithType:UIButtonTypeCustom];
    [photosBTN setFrame:CGRectMake(kHMARGIN, kSCREENHEIGHT/2-20, kSCREENWIDTH-2*kHMARGIN, 40)];
    [photosBTN setTitle:@"系统相册" forState:UIControlStateNormal];
    [photosBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [photosBTN addTarget:self action:@selector(openPhotosLibrary) forControlEvents:UIControlEventTouchUpInside];
    photosBTN.backgroundColor=[UIColor blueColor];
    photosBTN.layer.cornerRadius=photosBTN.frame.size.height/2;
    photosBTN.layer.masksToBounds=YES;
    [self.view addSubview:photosBTN];
}

-(void)openPhotosLibrary{
    self.pickerImageTool=[[PickerImageTool alloc]initWithType:UIImagePickerControllerSourceTypePhotoLibrary allowEdit:YES ViewCotroler:self pickerImage:^(UIImage *image) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(kHMARGIN, kNAVIGATION_BAR_HEIGHT+kSTATUS_BAR_HEIGHT, 200, 200)];
        imageView.image=image;
        [self.view addSubview:imageView];
        self.pickerImageTool=nil;
    }];
}

-(void)openSelfPhotoLibrary{
    
    [[PickerImageTool shareInstance] getPhotosCollectionList:^(NSArray *collectionList, NSArray *collectionListItem) {
        ImagePickerRootViewController *imagePickerVC=[ImagePickerRootViewController shareImagePickerRootViewController];
        MainNavigationController *photosNav=[[MainNavigationController alloc]initWithRootViewController:imagePickerVC];
        PHAssetViewController *assetVC=[[PHAssetViewController alloc]init];
        assetVC.assetCollection=collectionListItem.firstObject;
        [photosNav setViewControllers:[NSArray arrayWithObjects:imagePickerVC,assetVC, nil]];
         [self presentViewController:photosNav animated:YES completion:^{
            
        }];
    }];
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
