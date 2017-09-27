//
//  BookActivity.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/21.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "BookActivity.h"

@implementation BookActivity

-(NSString *)activityType{
    return NSStringFromClass([self class]);
}

+ (UIActivityCategory)activityCategory{
    return UIActivityCategoryShare;
}

-(NSString *)activityTitle{
    return NSLocalizedStringFromTable(@"open Book", @"BookActivity", nil);
}

-(UIImage *)activityImage{
    return [UIImage imageNamed:@"iosshare.jpg"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSURL class]]) {
            if ([[UIApplication sharedApplication] canOpenURL:activityItem]) {
                return YES;
            }
        }
    }
    return NO;
}

-(void)prepareWithActivityItems:(NSArray *)activityItems{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSURL class]]) {
            _url=activityItem;
        }
    }
}


-(void)performActivity{
    BOOL completed=[[UIApplication sharedApplication] openURL:_url];
    [self activityDidFinish:completed];
}


#pragma  mark activityDataSuorce
//- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController{
//    
//}



- (nullable id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType{
    if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
        return NSLocalizedString(@"Like this!", nil);
    } else if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
        return NSLocalizedString(@"Retweet this!",nil);
    } else {
        return nil;
    }
}

@end
