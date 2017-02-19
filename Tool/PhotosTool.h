//
//  PhotosTool.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/19.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef void(^PHStatus)(PHAuthorizationStatus status, BOOL result);

@interface PhotosTool : NSObject

/**
 Photos单例

 @return Photos单例
 */
+(PHPhotoLibrary *)shareLibrary;

/**
 获取APP对于相册的权限

 @param PHStatus APP相册的权限 的block
 */
+(void)libraryAuthorizationStation:(PHStatus)PHStatus;




+(PHFetchResult<PHCollectionList *> *)photosCollectionListWitTtype:(PHCollectionListType)type subtype:(PHCollectionListSubtype)subtype options:(nullable PHFetchOptions *)options;


/**
 注册观察者
 */
-(void)registerObserver;

/**
 移除观察者
 */
-(void)unRegisterObserver;
@end
