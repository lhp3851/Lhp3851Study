//
//  uploadImgeViewController.m
//  adapteTableviewHight
//
//  Created by ZizTour on 4/22/15.
//  Copyright (c) 2015 ZizTourabc. All rights reserved.
//

#import "uploadImgeViewController.h"

@interface uploadImgeViewController ()

@end


NSString *TMP_UPLOAD_IMG_PATH=@"";


@implementation uploadImgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UILabel *attrLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 380, 400)];
    attrLabel.numberOfLines=0;
    [self.view addSubview:attrLabel];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(19,6)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:20.0] range:NSMakeRange(0, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:10.0] range:NSMakeRange(19, 6)];
    attrLabel.attributedText = str;
    
    // Do any additional setup after loading the view from its nib.
    [_uploadImage addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectZero];
//    [lable setFrame:CGRectMake(90, 20, 100, 0)];
    lable.translatesAutoresizingMaskIntoConstraints=NO;
    lable.text=@"约束";
    lable.layer.borderWidth=1.0;
    lable.layer.borderColor=[UIColor blueColor].CGColor;
    [lable setTextColor:[UIColor blueColor]];
    [self.view addSubview:lable];
    

    [self.uploadImage setBackgroundColor:[UIColor blackColor]];
    [self.uploadImage setBackgroundImage:[UIImage imageNamed:@"无白边徽章1"] forState:UIControlStateNormal];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lable
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:150]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lable
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-15]];
    
//    [self getFontFamily];
    [self getNumberlength:121];

}




-(void)getNumberlength:(NSInteger)number{
    NSString *string=[NSString stringWithFormat:@"%ld",number];
    NSLog(@"数字长度：%ld",string.length);
}

//获取系统字体
-(void)getFontFamily{
    NSArray *fontArray = [UIFont familyNames];
    //ios 默认字体   Heiti SC
    for (id object in fontArray) {
        NSLog(@"字体名字：%@",object);
    }
}


-(void)uploadImage:sender{

    UIActionSheet *menu=[[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"从相册上传", nil];
    menu.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    menu.delegate=self;
    [menu showInView:self.view];
}

#pragma actionSheetDelegate Method
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        if(buttonIndex==0){
        [self snapImage];
        
    }else if(buttonIndex==1){
        [self pickImage];
        
    }
    
}

- (void)onPostData:(id)sender {
    NSMutableDictionary * dir=[NSMutableDictionary dictionaryWithCapacity:7];
    //[dir setValue:@"save" forKey:@"m"];
    [dir setValue:@"IOS上传试试" forKey:@"title"];
    [dir setValue:@"IOS上传试试" forKey:@"content"];
    [dir setValue:@"28" forKey:@"clubUserId"];
    [dir setValue:@"1" forKey:@"clubSectionId"];
    [dir setValue:@"192.168.0.26" forKey:@"ip"];
    [dir setValue:@"asfdfasdfasdfasdfasdfasd=" forKey:@"sid"];
    NSString *url=@"http://192.168.0.26:8090/api/club/topicadd.do?m=save";
    NSLog(@"=======上传");
    if([TMP_UPLOAD_IMG_PATH isEqualToString:@""]){
        [RequestPostUploadHelper postRequestWithURL:url postParems:dir picFilePath:nil picFileName:nil];
    }else{
        NSLog(@"有图标上传");
        NSArray *nameAry=[TMP_UPLOAD_IMG_PATH componentsSeparatedByString:@"/"];
        [RequestPostUploadHelper postRequestWithURL:url postParems:dir picFilePath:TMP_UPLOAD_IMG_PATH picFileName:[nameAry objectAtIndex:[nameAry count]-1]];;
    }
    
}

//拍照
- (void) snapImage{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    ipc.delegate=(id)self;
    ipc.allowsEditing=NO;
    [self presentViewController:ipc animated:YES completion:^{}];
    
}

//从相册里找
- (void) pickImage{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate=(id)self;
    ipc.allowsEditing=NO;
    [self presentViewController:ipc animated:YES completion:^{}];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info{
    UIImage *img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if(picker.sourceType==UIImagePickerControllerSourceTypeCamera){
        //        UIImageWriteToSavedPhotosAlbum(img,nil,nil,nil);
    }
    UIImage *newImg=[self imageWithImageSimple:img scaledToSize:CGSizeMake(300, 300)];
    [self saveImage:newImg WithName:[NSString stringWithFormat:@"%@%@",[self generateUuidString],@".jpg"]];
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}


-(UIImage *) imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName

{
    NSLog(@"===TMP_UPLOAD_IMG_PATH===%@",TMP_UPLOAD_IMG_PATH);
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    // Now we get the full path to the file
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    // and then we write it out
    TMP_UPLOAD_IMG_PATH=fullPathToFile;
    NSArray *nameAry=[TMP_UPLOAD_IMG_PATH componentsSeparatedByString:@"/"];
    NSLog(@"===new fullPathToFile===%@",fullPathToFile);
    NSLog(@"===new FileName===%@",[nameAry objectAtIndex:[nameAry count]-1]);
    
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}



- (NSString *)generateUuidString
{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own     (NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid)
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    // transfer ownership of the string
    // to the autorelease pool
    
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{}];
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
