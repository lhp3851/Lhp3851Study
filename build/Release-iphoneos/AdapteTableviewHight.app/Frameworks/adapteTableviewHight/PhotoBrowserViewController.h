//
//  PhotoBrowserViewController.h
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/2/23.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PhotoBrowserViewController : UIViewController

@property(nonatomic,strong)PHAssetCollection *assetCollection;

@property(nonatomic,assign)__block NSInteger index;

@end
