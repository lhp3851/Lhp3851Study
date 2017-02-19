//
//  MainNavigationController.m
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/4.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "MainNavigationController.h"

@implementation MainNavigationController
//+(void)initialize{
//    
//}
-(id)init{
    for (UINavigationItem *item in self.navigationBar.items) {
        NSLog(@"item:%@",item);
    }
    
    
    
    return self;
}
@end
