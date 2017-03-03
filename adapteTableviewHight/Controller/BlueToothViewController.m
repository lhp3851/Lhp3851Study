//
//  BlueToothViewController.m
//  adapteTableviewHight
//
//  Created by LiuXuan on 2017/3/3.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "BlueToothViewController.h"

@interface BlueToothViewController ()<GKPeerPickerControllerDelegate,GKSessionDelegate>

@property(nonatomic,strong)GKSession *session;
@property(nonatomic,strong)GKPeerPickerController *picker;

@end

@implementation BlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self coonect];
}

-(void)initView{
    self.view.backgroundColor=[UIColor greenColor];
    self.navigationItem.title=NSLocalizedString(NSStringFromClass([self class]), nil);
}

-(void)coonect{
    _picker=[[GKPeerPickerController alloc]init];
    _picker.delegate=self;
    _picker.connectionTypesMask=GKPeerPickerConnectionTypeNearby;
    [_picker show];
}

-(void)sendData{
    NSString *message=@"发送的消息";
    NSData *data=[message dataUsingEncoding:NSUTF8StringEncoding];
    if (_session) {
        [_session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
    }
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context{
    id jsonObj=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSNumber *codeObj=[jsonObj objectForKey:@"code"];
//    if ([codeObj integerValue]==GAMING) {
//        NSNumber *countObj=[jsonObj objectForKey:@"conut"];
//        NSLog(@"conut:%@",codeObj);
//    }
}

-(void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
    
}

#pragma mark GKPeerPickerControllerDelegate
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    NSLog(@"建立连接");
    _session=session;
    _session.delegate=self;
    [_session setDataReceiveHandler:self withContext:nil];
    _picker.delegate=nil;
    [_picker dismiss];
    
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
    NSLog(@"连接状态改变了");
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker{
    NSLog(@"取消连接");
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
