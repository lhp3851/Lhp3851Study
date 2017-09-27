//
//  PhotoBrowserViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/2/23.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PhotoBrowserViewController.h"
#import "PickerImageTool.h"

#define kIMAGESIZE CGSizeMake(kSCREENWIDTH, kSCREENHEIGHT)

@interface PhotoBrowserViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

{
    CGPoint currentOffSet;
}

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView  *currentImageView;

@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation PhotoBrowserViewController

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.scrollView];
}

-(void)setAssetCollection:(PHAssetCollection *)assetCollection{
    _assetCollection=assetCollection;
}

-(void)initData{
    [self loadDataWithPage:self.index];
}

-(PHFetchResult *)loadAssetData{
    PHFetchResult *result=[PHAsset fetchAssetsInAssetCollection:self.assetCollection options:nil];
    [self.scrollView setContentSize:CGSizeMake(kSCREENWIDTH*result.count, kSCREENHEIGHT)];
    return result;
}

-(void)loadDataWithPage:(NSInteger)page{
    PHFetchResult *resultAsset=[self loadAssetData];
    if (page<0||page>resultAsset.count-1) {
        return;
    }
    __weak typeof(self) weakSelf=self;
    
    PHAsset *indexAsset=[resultAsset objectAtIndex:page];
    [[PickerImageTool shareInstance] getImageWithAsset:indexAsset
                                             imageSize:kIMAGESIZE
                                                result:^(UIImage *result, NSDictionary *info) {
        UIImageView *imageView=weakSelf.currentImageView;
        CGRect frame={kSCREENWIDTH*(resultAsset.count-1-page),0,kIMAGESIZE};
        weakSelf.currentIndex=page;
        [imageView setFrame:frame];
        imageView.image=result;
        [weakSelf.scrollView addSubview:imageView];
        currentOffSet=frame.origin;
        [weakSelf.scrollView setContentOffset:currentOffSet animated:YES];
    }];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT)];
        _scrollView.delegate=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.directionalLockEnabled=YES;
    }
    return _scrollView;
}

-(UIImageView *)currentImageView{
    _currentImageView=[[UIImageView alloc]initWithFrame:self.scrollView.frame];
    _currentImageView.contentMode=UIViewContentModeScaleAspectFit;
    _currentImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGues=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToHideNavigation)];
    tapGues.delegate=self;
    [_currentImageView addGestureRecognizer:tapGues];
    return _currentImageView;
}



#pragma mark  scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x<=0||scrollView.contentOffset.x>=scrollView.contentSize.width) {
        return;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ((scrollView.contentOffset.x<currentOffSet.x)&&(scrollView.contentOffset.x>currentOffSet.x-kSCREENWIDTH)) {
        ++self.index;
    }
    else  if ((scrollView.contentOffset.x>currentOffSet.x)&&(scrollView.contentOffset.x<currentOffSet.x+kSCREENWIDTH)){
        --self.index;
    }
    [self loadDataWithPage:self.index];
}

-(void)tapToHideNavigation{
    [self.navigationController.navigationBar setHidden:!self.navigationController.navigationBar.hidden];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
