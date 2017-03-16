//
//  intrestMathmticQuestionViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/10/24.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

#import "intrestMathmticQuestionViewController.h"
#import "SortProgramer.h"
#import <math.h>


@interface intrestMathmticQuestionViewController ()

@end

@implementation intrestMathmticQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)FermatLastTheorem:(id)sender{
    
    NSLog(@"%f",MAXFLOAT);
    
    for (long double x=0; x<=1000; x++) {
        
        if (x>1000) {
            break;
        }
        
        for (long double y=0; y<=1000; y++) {
            
            if (x>1000||y>1000) {
                continue;
            }
            
            for (long double z=0; z<=1000; z++) {
                if (x>1000||y>1000||z>1000) {
                    continue;
                }
                
                if (x*x*x+y*y*y==z*z*z-1) {
                    NSLog(@"(x,y,z):(%.0Lf,%.0Lf,%.0Lf)",x,y,z);
                }
            }
        }
    }
    
}

//冒泡排序
-(IBAction)bubbleSort:(id)sender{
    bubble_sort(nil, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
