//
//  delegateAndBlockViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/25.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//

/**
 （1）在类中，定义一个Block变量，就像定义一个函数；
 
 （2）Block可以定义在方法内部，也可以定义在方法外部；
 
 （3）只有调用Block时候，才会执行其{}体内的代码；
 
 （4）Block其实也相当于代理
 
 （PS：关于第（2）条，定义在方法外部的Block，其实就是文件级别的全局变量）
*/

#import "delegateAndBlockViewController.h"

@interface delegateAndBlockViewController ()

@end

@implementation delegateAndBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
//------------------------------------------------block部分-----------------------------------------------
    //（1）定义无参无返回值的Block，定义在方法体内的block可当做私有函数
    void (^printBlock)() = ^(){
        printf("no number");
    };
    printBlock();
    
    printBlock(9);
    
    int mutiplier = 7;
    //（3）定义名为myBlock的代码块，返回值类型为int
    int (^myBlock)(int) = ^(int num){
        return num*mutiplier;
    };
    //使用定义的myBlock
    int newMutiplier = myBlock(3);
    printf("newMutiplier is %d",myBlock(newMutiplier));
    
    //(4)__block作用
    int __block x = 100;
    void (^sumXAndYBlock)(int) = ^(int y){
        x = x+y;
        printf("new x value is %d",x);
    };
    sumXAndYBlock(50);
    
//------------------------------------------------协议部分------------------------------------------------
    self.delegate = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selfDelegateMethod)]) {
        [self.delegate selfDelegateMethod];
    }
}

//定义在-viewDidLoad方法外部，定义在方法外部的Block，其实就是文件级别的全局变量
//（2）定义一个有参数，没有返回值的Block
void (^printNumBlock)(int) = ^(int num){
    printf("int number is %d",num);
};


#pragma mark - ViewControllerDelegate method

//实现协议中的方法
- (void)selfDelegateMethod
{
    NSLog(@"自己委托自己实现的方法，可以在他出调用");
}

-(IBAction)delegatePassContent:(id)sender{
    NSLog(@"delegate传值");
}

-(IBAction)blockPassContent:(id)sender{
    
    BlockViewController *blockVC=[[BlockViewController alloc]init];
    blockVC.blockPassValues=^(NSString *stringValue){
        return @"block传值";
    };
    [self.navigationController pushViewController:blockVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
