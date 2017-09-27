//
//  FileOperationViewController.h
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/26.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/NSFileManager.h>

@interface FileOperationViewController : UIViewController
{
    NSString *FileName;
    NSFileManager *FileManager;
    NSDictionary *FileAttr;
    
    NSDirectoryEnumerator *dirEnnum;
    NSArray *dirArray;
    
}
@end
