//
//  mapViewController.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/8/7.
//  Copyright (c) 2015年 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>


@interface mapViewController : UIViewController<BMKLocationServiceDelegate>

{
    BMKLocationService *locationSerVice;
}

@end
