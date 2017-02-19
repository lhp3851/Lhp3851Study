//
//  uploadImgeViewController.h
//  adapteTableviewHight
//
//  Created by ZizTour on 4/22/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestPostUploadHelper.h"

@interface uploadImgeViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *uploadImage;

@end
