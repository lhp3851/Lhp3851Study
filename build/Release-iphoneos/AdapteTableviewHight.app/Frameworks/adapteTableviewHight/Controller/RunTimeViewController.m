//
//  RunTimeViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/16.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "RunTimeViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface RunTimeViewController ()
@property(nonatomic,strong)NSString *propertyName;
@end

@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
}

-(void)initData{
    objc_msgSend(_propertyName, @selector(setName:),@"balabala");
    NSString *name = (NSString *)objc_msgSend(_propertyName, @selector(getName));
    NSLog(@"name:%@",name);
}

-(NSString *)getName{
    return _propertyName;
}

-(void)setName:(NSString *)name{
    _propertyName=name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
