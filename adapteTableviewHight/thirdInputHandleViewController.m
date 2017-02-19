//
//  thirdInputHandleViewController.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/9/16.
//  Copyright (c) 2015年 ZizTourabc. All rights reserved.
//

#import "thirdInputHandleViewController.h"

#define Screen_Width [[UIScreen mainScreen]bounds].size.width
#define Screen_Height [[UIScreen mainScreen]bounds].size.height
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgb(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f]
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0]
@interface thirdInputHandleViewController ()<UITextFieldDelegate>{
    //输入框
    UITextField *userNameTextFiled;
    //键盘出来第一次就处理，否则不处理
    BOOL keyBoardShowned;
    //键盘高度
    float keyBoardHight;
}

@end

@implementation thirdInputHandleViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"第三方输入法处理";
    self.view.backgroundColor=[UIColor grayColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChange:) name:UITextFieldTextDidChangeNotification object:nil];
    CGRect frame=CGRectMake(56, Screen_Height-136, Screen_Width-112, 38);
    userNameTextFiled=[[UITextField alloc]initWithFrame:frame];
    userNameTextFiled.delegate=self;
    userNameTextFiled.textAlignment=NSTextAlignmentCenter;
    userNameTextFiled.layer.borderWidth=1.0;
    userNameTextFiled.textColor=[UIColor whiteColor];
    userNameTextFiled.font=[UIFont systemFontOfSize:14];
    userNameTextFiled.placeholder=@"请输入您的企业邮箱";
    userNameTextFiled.autocorrectionType=UITextAutocorrectionTypeNo;
    userNameTextFiled.autocapitalizationType=UITextAutocapitalizationTypeNone;
    userNameTextFiled.backgroundColor=[UIColor whiteColor];
    [userNameTextFiled setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"];
    userNameTextFiled.layer.borderColor=[UIColor blueColor].CGColor;
    userNameTextFiled.keyboardType=UIKeyboardTypeEmailAddress;
    userNameTextFiled.returnKeyType=UIReturnKeyGo;
    [userNameTextFiled addTarget:self action:@selector(textFieldEditChange:) forControlEvents:UIControlEventValueChanged];
    NSUserDefaults *userLoginDefault=[NSUserDefaults standardUserDefaults];
    NSString *user=[userLoginDefault  stringForKey:@"username"];
    if (user) {
        userNameTextFiled.text=user;
    }
    [self.view addSubview:userNameTextFiled];
    
    NSLog(@"userNameTextFiled.frame.origin.y0:%f",userNameTextFiled.frame.origin.y);

    
}

-(void)textFieldEditChange:(id)object{
    UITextField *textFiled=[object objectForKey:@"object"];
    
    NSLog(@"%@",textFiled.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
- (void)keyboardWillBeHiddenR:(NSNotification*)aNotification{
    NSLog(@"keyboard is hide");
    if (keyBoardHight) {//keyBoardShowned||
        keyBoardShowned=!keyBoardShowned;
        [userNameTextFiled setFrame:CGRectMake(userNameTextFiled.frame.origin.x, userNameTextFiled.frame.origin.y+keyBoardHight, userNameTextFiled.frame.size.width, userNameTextFiled.frame.size.height)];
    }
//    keyBoardShowned=!keyBoardShowned;
//    [userNameTextFiled setFrame:CGRectMake(userNameTextFiled.frame.origin.x, userNameTextFiled.frame.origin.y+keyBoardHight, userNameTextFiled.frame.size.width, userNameTextFiled.frame.size.height)];
}

- (void)keyboardWasShownR:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"keyBoardShowned hight:%f",kbSize.height);
    if (kbSize.height!=0) {
        if (!keyBoardShowned) {//键盘出来第一次就处理，否则不处理
            NSLog(@"keyboard is show");
            keyBoardShowned=!keyBoardShowned;
            keyBoardHight=kbSize.height;
            [userNameTextFiled setFrame:CGRectMake(userNameTextFiled.frame.origin.x, userNameTextFiled.frame.origin.y-keyBoardHight, userNameTextFiled.frame.size.width, userNameTextFiled.frame.size.height)];
            NSLog(@"userNameTextFiled.frame.origin.y:%f",userNameTextFiled.frame.origin.y);
        }
//        else{
//            NSLog(@"重复调用");
//            keyBoardShowned=!keyBoardShowned;
//            [userNameTextFiled setFrame:CGRectMake(userNameTextFiled.frame.origin.x, userNameTextFiled.frame.origin.y, userNameTextFiled.frame.size.width, userNameTextFiled.frame.size.height)];
//            NSLog(@"userNameTextFiled.frame.origin.ys:%f",userNameTextFiled.frame.origin.y);
//        }
    }
}

-(void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShownR:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiddenR:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [userNameTextFiled resignFirstResponder];
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
