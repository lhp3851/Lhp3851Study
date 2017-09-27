//
//  main.m
//  adapteTableviewHight
//
//  Created by ZizTour on 4/21/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SortProgramer.h"

//比较两个数的大小
static int compare_int(const void *int1,const void *int2){
    if (*(const int *)int1 > *(const int *)int2)
        return 1;
    else if (*(const int *)int1 < *(const int *)int2)
        return -1;
    else
        return 0;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
//        int array[8]={24,52,11,94,28,36,14,80};
//        qksort(array, sizeof(array), sizeof(int), 0, 7, compare_int);
//        
//        int a[4]={7,3,6,5};
//        issort(a, 4, sizeof(int), compare_int);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
