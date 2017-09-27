//
//  ConnactViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 2017/2/22.
//  Copyright © 2017年 lhp3851. All rights reserved.
//

#import "ConnactViewController.h"

@interface ConnactViewController ()<CNContactPickerDelegate>

@property(nonatomic,strong,readonly)CNContactPickerViewController * contactPickerVc;

@end

@implementation ConnactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    _contactPickerVc = [CNContactPickerViewController new];
    _contactPickerVc.delegate = self;
    
}

-(void)initData{
    //判断授权状态
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"授权成功");
                // 2. 获取联系人仓库
                CNContactStore * store = [[CNContactStore alloc] init];
                
                // 3. 创建联系人信息的请求对象
                NSArray * keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
                
                // 4. 根据请求Key, 创建请求对象
                CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
                
                // 5. 发送请求
                [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    
                    // 6.1 获取姓名
                    NSString * givenName = contact.givenName;
                    NSString * familyName = contact.familyName;
                    NSLog(@"姓名:%@--%@", givenName, familyName);
                    
                    // 6.2 获取电话
                    NSArray * phoneArray = contact.phoneNumbers;
                    for (CNLabeledValue * labelValue in phoneArray) {
                        
                        CNPhoneNumber * number = labelValue.value;
                        NSLog(@"电话:%@--%@", number.stringValue, labelValue.label);
                    }
                }];
            } else {
                NSLog(@"授权失败");
            }
        }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentViewController:_contactPickerVc animated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{
    for (CNContact *contact in contacts) {
         NSLog(@"nickname:%@",contact.nickname);
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties{
    [contactProperties enumerateObjectsUsingBlock:^(CNContactProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CNContact *contact = obj.contact;
        NSLog(@"property nickname:%@",contact.nickname);
    }];
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    NSLog(@"取消");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
