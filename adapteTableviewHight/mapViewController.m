//
//  mapViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/8/7.
//  Copyright (c) 2015年 ZizTourabc. All rights reserved.
//

#import "mapViewController.h"

@interface mapViewController ()

@end

@implementation mapViewController

-(void)viewWillAppear:(BOOL)animated{
    locationSerVice.delegate=self;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    locationSerVice.delegate=nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(15, 80, 60, 30)];
    button.titleLabel.text=@"定位";
    [button setTitle:@"定个位" forState:UIControlStateNormal];
    button.backgroundColor=[UIColor grayColor];
    button.layer.borderColor=[UIColor blueColor].CGColor;
    button.layer.cornerRadius=3;
    button.layer.masksToBounds=YES;
    [button addTarget:self action:@selector(StartLocation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    locationSerVice=[[BMKLocationService alloc]init];
    
}

-(void)StartLocation:(id)sender{
    NSLog(@"开始定位");
    [locationSerVice startUserLocationService];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation;
{
    NSLog(@"当前经纬度:%f-%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);

    [locationSerVice stopUserLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
