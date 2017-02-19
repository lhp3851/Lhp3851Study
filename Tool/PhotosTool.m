//
//  PhotosTool.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "PhotosTool.h"


@implementation PhotosTool

+(PHPhotoLibrary *)shareLibrary{
    return [PHPhotoLibrary sharedPhotoLibrary];
}

+(void)libraryAuthorizationStation:(PHStatus)PHStatus{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status==PHAuthorizationStatusAuthorized) {
            PHStatus(PHAuthorizationStatusAuthorized,YES);
        }
        else{
            PHStatus(status,NO);
            NSString *message=nil;
            switch (status) {
                case PHAuthorizationStatusDenied:
                    message=@"您拒绝了APP访问相册";
                    break;
                case PHAuthorizationStatusRestricted:
                    message=@"此APP不允许访问相册";
                    break;
                default:
                    message=@"您没有设置APP访问相册的权限";
                    break;
            }
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"去设置", nil];
            [alert show];
        }
    } ];
}


-(void)registerObserver{
    [[PhotosTool shareLibrary] registerChangeObserver:(id)self];
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    if (changeInstance) {
        NSLog(@"PHPhotoLibrary Changed");
    }
}

-(void)unRegisterObserver{
    [[PhotosTool shareLibrary] unregisterChangeObserver:(id)self];
}


+(PHFetchResult<PHCollectionList *> *)photosCollectionListWitTtype:(PHCollectionListType)type subtype:(PHCollectionListSubtype)subtype options:(nullable PHFetchOptions *)options{
    return [PHCollectionList fetchCollectionListsWithType:type subtype:subtype options:options];
}

@end
