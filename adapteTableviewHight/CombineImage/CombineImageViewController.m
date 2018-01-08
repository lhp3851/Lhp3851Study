//
//  CombineImageViewController.m
//  AdapteTableviewHight
//
//  Created by lhp3851 on 2018/1/4.
//  Copyright © 2018年 lhp3851. All rights reserved.
//

#import "CombineImageViewController.h"

@interface CombineImageViewController ()

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UIImageView *imageView_width;

@property(nonatomic,strong)UIImageView *imageView_height;

@end

@implementation CombineImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPannle];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        CGRect frame = CGRectMake(122.5, 84, 120, 120);
        _imageView = [UIImageView new];
        _imageView.frame = frame;
        UIImage *image = [UIImage composeImageWithShap:ImageShapTypeSquare backgroundSize:frame.size backgroundColor:RGBA(226, 226, 230, 1) centerImage:@"icon"];
        _imageView.image = image;
    }
    return _imageView;
}

-(UIImageView *)imageView_width{
    if (!_imageView_width) {
        CGRect frame = CGRectMake(60, CGRectGetMaxY(self.imageView.frame) + 10, kSCREENWIDTH - 120, 120);
        _imageView_width = [UIImageView new];
        _imageView_width.frame = frame;
        UIImage *image = [UIImage composeImageWithShap:ImageShapTypeRectangle_Width backgroundSize:frame.size backgroundColor:RGBA(226, 226, 226, 1) centerImage:@"icon"];
        _imageView_width.image = image;
    }
    return _imageView_width;
}

-(UIImageView *)imageView_height{
    if (!_imageView_height) {
        CGRect frame = CGRectMake(122.5, CGRectGetMaxY(self.imageView_width.frame) + 10, 120, 200);
        _imageView_height = [UIImageView new];
        _imageView_height.frame = frame;
        UIImage *image = [UIImage composeImageWithShap:ImageShapTypeRectangle_Height backgroundSize:frame.size backgroundColor:RGBA(226, 226, 226, 1) centerImage:@"icon"];
        _imageView_height.image = image;
    }
    return _imageView_height;
}

-(void)initPannle{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.imageView_width];
    [self.view addSubview:self.imageView_height];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
