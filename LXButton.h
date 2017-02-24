//
//  LXButton.h
//  AVFoundatonStudy
//
//  Created by kankanliu on 16/7/25.
//  Copyright © 2016年 jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXButton : UIButton
+(instancetype)setTitle:(NSString *)title normaTitleColor:(UIColor *)normaTitleColor heilightTitleColor:(UIColor *)heilightTitleColor prohibitTitleColor:(UIColor *)prohibitTitleColor normaBackGroundColor:(UIColor *)normaBackGroundColor heilightBackGroundColor:(UIColor *)heilightBackGroundColor prohibitBackGroundColor:(UIColor *)prohibitBackGroundColor buttonType:(UIButtonType)buttonType;

+(instancetype)buttonWithImage:(UIImage *)image frame:(CGRect)buttonFrame normaBackGroundColor:(UIColor *)normaBackGroundColor heilightBackGroundColor:(UIColor *)heilightBackGroundColor prohibitBackGroundColor:(UIColor *)prohibitBackGroundColor buttonType:(UIButtonType)buttonType;

@end
