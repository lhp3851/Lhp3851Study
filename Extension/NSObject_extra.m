//
//  NSObject_extra.m
//  sesame
//
//  Created by long on 11-5-13.
//  Copyright 2011 pingan. All rights reserved.
//所有生成的控件对象都要自己去释放

#import <QuartzCore/QuartzCore.h>
#import "NSObject_extra.h"
#import "NSMutableDictionary_extra.h"
#import "regex.h"//正则表达式
#import<CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>
#import "UIDeviceHardware.h"

@implementation NSObject (expand)
//压缩图片到适合大小，如 2M  = 2*1024*1024 targetImageLength
- (NSData *)JPEGRepresentationImage:(UIImage *)theImage targetImageLength:(int)targetImageLength{
    float _rate = 1.0;
    NSData *_imageData  = UIImageJPEGRepresentation(theImage, _rate);
    BOOL exitFlag = NO;
    while ([_imageData length]>targetImageLength && !exitFlag){
        //未达目标继续压缩
        _rate = _rate/2.0;
        _imageData  = UIImageJPEGRepresentation(theImage, _rate);
        NSLog(@"selectedImageData size1 ========= %lu, compress rate: %.4f",(unsigned long)[_imageData length],_rate);
        while ([_imageData length]<targetImageLength-5*1024) {
            //过度压缩，-5*1024为合理偏差值，再把压缩设置为_rate+_rate/2.0
            float _keyRate1 = _rate;
            _rate = _rate+_rate/2.0;
            _imageData  = UIImageJPEGRepresentation(theImage, _rate);
            NSLog(@"selectedImageData size2 ========= %lu, compress rate: %.4f",(unsigned long)[_imageData length],_rate);
            if ([_imageData length]>targetImageLength) {
                _rate = (_rate+_keyRate1)/2.0;
                _imageData = UIImageJPEGRepresentation(theImage, _rate);
                NSLog(@"selectedImageData size3 ========= %lu, compress rate: %.4f",(unsigned long)[_imageData length],_rate);
                exitFlag = YES;
                break;
            }
        }
    }
    return _imageData;
}

//生成uilable对象
- (UILabel *)newLabelWithText:(NSString*)text 
						frame:(CGRect)frame 
						 font:(UIFont *)font
					textColor:(UIColor *)textColor {
	
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.backgroundColor = [UIColor clearColor];
	if (text != nil) {
		label.text = text;
	}
	
	if (font != nil) {
		label.font = font;
	}
	
	if (textColor != nil) {
		label.textColor = textColor;
	}
	
	return label;
}

//生成uibutton对象
- (UIButton *)newButtonWithImage:(UIImage *)image 
				highlightedImage:(UIImage *)highlightedImage
						   frame:(CGRect)frame 
						   title:(NSString *)title
					  titleColor:(UIColor *)titleColor
				titleShadowColor:(UIColor *)titleShadowColor
							font:(UIFont *)font
						  target:(id)target
						  action:(SEL)action  {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	
	if (image != nil) {
		[button setBackgroundImage:image forState:UIControlStateNormal];
	}
	
	if (highlightedImage != nil) {
		[button	setBackgroundImage:highlightedImage  forState:UIControlStateHighlighted];

	}
	
	button.frame = frame;
	
	if (title != nil) {
		[button setTitle:title forState:UIControlStateNormal];
	}
	
	if (titleColor != nil) {
		[button setTitleColor:titleColor forState:UIControlStateNormal];
	}
	
	if (titleShadowColor != nil) {
		[button setTitleShadowColor:titleShadowColor forState:UIControlStateNormal];
	}
	
	if (font != nil) {
		button.titleLabel.font = font;
	} 

	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return button;	
}

- (UIImageView *)newImageViewWithImage:(UIImage *)image frame:(CGRect)frame {
	
	UIImageView *imageView =[[UIImageView alloc] initWithImage:image];
	imageView.frame = frame;
	
	return imageView;
}

- (UITableView *)newTableViewWithFrame:(CGRect)frame
								 style:(UITableViewStyle)style
					   backgroundColor:(UIColor *)backgroundColor
							  delegate:(id)delegate
							dataSource:(id)dataSource
						separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle {
	
	UITableView *tableView = [[UITableView alloc]  
								 initWithFrame:frame     
								 style:style];
	
	if (backgroundColor != nil) {
		[tableView setBackgroundColor:backgroundColor]; 
	}
	
	[tableView setDelegate:delegate]; 
	[tableView setDataSource:dataSource]; 
	[tableView setSeparatorStyle:separatorStyle]; 
		
	return tableView;
	
}

- (UIScrollView *)newScrollViewWithFrame:(CGRect)frame
							 contentSize:(CGSize)contentSize
						 backgroundColor:(UIColor *)backgroundColor
								delegate:(id)delegate
						   pagingEnabled:(BOOL)pagingEnabled {
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame]; 
	if (backgroundColor != nil) {
		[scrollView  setBackgroundColor:backgroundColor]; 
	}
	[scrollView  setDelegate:delegate]; 
    scrollView.contentSize = contentSize;
	scrollView.pagingEnabled = pagingEnabled;
	
	return scrollView;
}

/**
 * 功能：输入交易密码的同时认证是否符合规则
 * 参数：
 *		textFieldtext	待验证的TextField的Text
 *		string			当前输入的string
 *
 * Created by Joey at 2011/7/12
 */
-(BOOL)doCheckInputPassWord:(NSString *)textFieldtext replacementString:(NSString *)string{
	NSUInteger length_f = [textFieldtext length];
	
	if([string length]>1)
		return NO;
	
	if( [string isEqualToString:@""] )
		return YES;

	unichar curChar_f = [string characterAtIndex:0]; 
	
	if ([string isValidNumber:string]) 
	{
		if (length_f > 5) {
            return NO;
        }
		
		if( curChar_f>='0'&&curChar_f<='9' )
		{
			return YES;
		}else {
			return NO;
		}
	}else {
		return NO;
	}
	
	return YES;
}

//依字号取得string字段的像素长度
//输入字符串@“abcdefg”和字体大小，计算出字符串像素长度
-(CGFloat)getLengthOfStringForFont:(NSString *)string 
							  font:(UIFont *)font
{
	CGSize detailSize = [string sizeWithFont:font 
						   constrainedToSize:CGSizeMake(MAXFLOAT,MAXFLOAT) 
							   lineBreakMode:NSLineBreakByWordWrapping];
	return detailSize.width;
}

//正则表达式，比较函数
-(BOOL)regExpMatch:(NSString *)string 
	   withPattern:(NSString*)pattern
{
    regex_t reg;
    regmatch_t sub[10];
    int status=regcomp(&reg, [pattern UTF8String], REG_EXTENDED);
    if(status)return NO;
    status=regexec(&reg, [string UTF8String], 10, sub, 0);
    if(status==REG_NOMATCH)return NO;
    else if(status)return NO;
    return YES;
}

//验证email格式地址
-(BOOL)isValidEmail:(NSString *)email
{
	if (!email) {
		return NO;
	}
	else {
		NSString *pattern = @"^[a-z0-9A-Z._%-]+@[a-z0-9A-Z._%-]+\\.[a-zA-Z]{2,4}$";
		if ([self regExpMatch:email withPattern:pattern]) { 
			return YES;
		}
	}
	return NO;
}

//手机号码验证，现在只检查是数字
-(BOOL)isValidMobileNumber:(NSString *)number
{
	if (!number || number.length == 0) {
		return NO;
	}
	else {
		for (int index = 0; index<number.length; index++) {
			unichar curChar_f = [number characterAtIndex:index];
			if (!(curChar_f>='0'&& curChar_f<='9')) {
				return NO;
			}
		}
		return YES;
	}
}

//日期格式转换
//如：20111215－>2011－12－15
-(NSString *)addSeparatorForDate:(NSString *)date
{
	NSString *str = date;
	if ( date.length>=6 && [date rangeOfString:@"-"].length==0 ) {
		str = [date substringToIndex:4];
		
		NSRange aRange = NSMakeRange(4,2);
		str = [NSString stringWithFormat:@"%@-%@",str,[date substringWithRange:aRange]];
		aRange = NSMakeRange(6,2);
		str = [NSString stringWithFormat:@"%@-%@",str,[date substringWithRange:aRange]];
	}
	return str;
}

//日期格式转换
//如：2011－12－15－>20111215
-(NSString *)removeSeparatorForDate:(NSString *)date
{
	if (date && date.length>=8) {
		date = [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
	}
	return date;
}

//验证字符串是否是纯数字
-(BOOL)isValidNumber:(NSString*)str
{
	for (int i=0;i<[str length];i++) 
	{
		char c=[str characterAtIndex:i];
		if (c<48||c>57) {
			return FALSE;
		}
	}
	return TRUE;
}

//根据key值对数组进行 降序 排序
- (NSArray*)sortWithArray:(NSMutableArray*)array ByKey:(NSString*)key {
	NSString *keyString = [NSString stringWithFormat:@"%@", key];
	NSString *currentKey = nil;
	NSString *lastKey = nil;
	for (int i=0; i<[array count]; i++) {
		for (int j=1; j<[array count]-i; j++) {
			currentKey = [[array objectAtIndex:j] getObjectByKey:keyString];
			lastKey = [[array objectAtIndex:j-1] getObjectByKey:keyString];
			if ([currentKey intValue]>[lastKey intValue]) {
				[array exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
			}
		}
	}
	return array;
}

//根据key值对数组进行 升序 排序 
- (NSArray*)sortAscendingWithArray:(NSMutableArray*)array ByKey:(NSString*)key {
	NSString *keyString = [NSString stringWithFormat:@"%@", key];
	NSString *currentKey = nil;
	NSString *lastKey = nil;
	for (int i=0; i<[array count]; i++) {
		for (int j=1; j<[array count]-i; j++) {
			currentKey = [[array objectAtIndex:j] getObjectByKey:keyString];
			lastKey = [[array objectAtIndex:j-1] getObjectByKey:keyString];
			if ([currentKey intValue]<[lastKey intValue]) {
				[array exchangeObjectAtIndex:j-1 withObjectAtIndex:j];
			}
		}
	}
	return array;
}

/**
 * 功能：将阿拉伯数字的金额转换成中文大写格式显示出来
 *	   Created by 曾佩琪 on 2011-6-15.
 * 参数：  NSString  arabString   要转换的阿拉伯数字字符串
 */
- (NSString *)stringArabToChinese:(NSString *)arabString
{
	NSString *chineseString = nil;
	
	/** 大写数字 */
	NSArray *NUMBERS = [[NSArray alloc] initWithObjects: @"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆",
						@"柒", @"捌", @"玖",nil];
	/** 整数部分的单位 */
	NSArray *IUNIT = [[NSArray alloc] initWithObjects:@"元",@"拾",@"佰", @"仟", @"万", @"拾", @"佰",
					  @"仟", @"亿", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟" ,nil];
	/** 小数部分的单位 */
	NSArray *DUNIT = [[NSArray alloc] initWithObjects:@"角", @"分", @"厘",nil];
	
	arabString = [arabString stringByReplacingOccurrencesOfString:@"," withString:@""];// 去掉","
	arabString = [arabString stringByReplacingOccurrencesOfString:@" " withString:@""];//去掉" "
	NSString *integerStr = nil;// 整数部分数字
	NSString *decimalStr = nil;// 小数部分数字
	
	// 获得小数点所在的位置
	int index = -1;
	if ([arabString length] > 0) {
		for (int i = 0; i < [arabString length]-1; i++) {
			NSRange range = {i,1};
			if ([[arabString substringWithRange:range] isEqualToString:@"."]) {
				index = i;
			}
		}
	}else {
		index = -1;
	}
	
	// 初始化：分离整数部分和小数部分
	if (index > 0) {
		integerStr = [arabString substringToIndex:index];
		NSRange range = {index +1,[arabString length]-index - 1};
		decimalStr = [arabString substringWithRange:range];
	}else if (index == 0) {
		integerStr = @"";
		NSRange range = {1,[arabString length] - 1};
		decimalStr = [arabString substringWithRange:range];
	}else {
		integerStr = arabString;
		decimalStr = @"";
	}
	
	//清除整数部分最前面的0
	for (int i = 0; i < [integerStr length]; i++) {
		NSString *firstLetter = [integerStr substringToIndex:1];
		if ([firstLetter isEqualToString:@"0"]) {
			integerStr = [integerStr substringFromIndex:1];
		}
	}
	
	//清除小数部分最后面的0
	for (int i = 0; i < [decimalStr length]; i++) {
		NSString *lastLetter = [decimalStr substringFromIndex:[decimalStr length] - 1];
		if ([lastLetter isEqualToString:@"0"]) {
			decimalStr = [decimalStr substringToIndex:[decimalStr length]-1];
		}
	}
	
	// overflow超出处理能力，直接返回
	if ([integerStr length] > [IUNIT count]) {
		NSLog(@" %@ :超出处理能力",arabString);
		return arabString;
	}
	
	//整数部分转换为数组，从高位至低位
	NSMutableArray *integers = [[NSMutableArray alloc] init];
	for (int i = 0; i < [integerStr length]; i++) {
		NSRange range = {i,1};
		NSString *tempStr = [integerStr substringWithRange:range];
		[integers addObject:tempStr];
	}
	
	//小数部分转换为数组，从高位至低位
	NSMutableArray *decimals = [[NSMutableArray alloc] init];
	for (int i = 0; i < [decimalStr length]; i++) {
		NSRange range = {i,1};
		NSString *tempStr = [decimalStr substringWithRange:range];
		[decimals addObject:tempStr];
	}
	
	BOOL isMust5;// 设置万单位
	NSUInteger length = [integerStr length];
	if (length > 4) {
		NSString *subInteger = @"";
		if (length > 8) {
			// 取得从低位数，第5到第8位的字串
			NSRange range1 = {length - 8,4};
			subInteger = [integerStr substringWithRange:range1];
		} else {
			subInteger = [integerStr substringToIndex:length - 4];
		}
		if ([subInteger intValue] > 0) {
			isMust5 = YES;
		}else {
			isMust5 = NO;
		}
	} else {
		isMust5 = NO;
	}
	
	//allStr把整数和小数部分中文金额字符串合并
	NSMutableString *allStr = [NSMutableString string];
	
	//整数部分的中文大写字符串
	NSMutableString *chineseInteger = [[NSMutableString alloc]	init];
	NSMutableString *key = [NSMutableString string];
	length = [integers count];
	for (int i = 0; i < length; i++) {
		// 0出现在关键位置：1234(万)5678(亿)9012(万)3456(元)
		// 特殊情况：10(拾元、壹拾元、壹拾万元、拾万元)
		if ([[integers objectAtIndex:i] isEqualToString:@"0"]){
			if ((length - i) == 13) 
				key = [IUNIT objectAtIndex:4];
			else if ((length - i) == 9)// 亿(必填)
				key = [IUNIT objectAtIndex:8];
			else if ((length - i) == 5 && isMust5)// 万(不必填)
				key = [IUNIT objectAtIndex:4];
			else if ((length - i) == 1)// 元(必填)
				key = [IUNIT objectAtIndex:0];
			else {
				key = [NSMutableString stringWithFormat:@""];
			}
			
			// 0遇非0时补零，不包含最后一位
			if ((length - i) > 1 && ![[integers objectAtIndex:(i+1)] isEqualToString:@"0"])
				[key appendString:[NUMBERS objectAtIndex:0]];
		}
		NSInteger numindex = [[integers objectAtIndex:i] intValue];
		
		if ([[integers objectAtIndex:i] isEqualToString:@"0"]) {
			[chineseInteger appendString:key];
		}else {
			[chineseInteger appendString:[NUMBERS objectAtIndex:numindex]];
			[chineseInteger appendString: [IUNIT objectAtIndex:length - i - 1]];
		}
	}
	[allStr appendString:chineseInteger];
	
	
	//小数部分的中文大写字符串
	NSMutableString *chineseDecimal = [[NSMutableString alloc] init];	
	for (int i = 0; i < [decimals count]; i++) {
		// 舍去3位小数之后的
		if (i == 3)
			break;
		NSInteger numberIndex = [[decimals objectAtIndex:i] intValue];
		if (![[decimals objectAtIndex:i] isEqualToString:@"0"]) {
			[chineseDecimal appendString:[NUMBERS objectAtIndex:numberIndex]];
			[chineseDecimal appendString:[DUNIT objectAtIndex:i]];
		}
	}
	[allStr appendString:chineseDecimal];
	
	
	//判断最后要不要加“整”字
	if ([allStr length] > 0) {
		
		NSString *getLastLetter = [allStr substringFromIndex:[allStr length] - 1];//获取最后一个字符
		if ([getLastLetter isEqualToString:@"元"] || [getLastLetter isEqualToString:@"角"]) {
			[allStr appendString:@"整"];
		}
		
		NSString *getFirstLetter = [allStr substringToIndex:1];
		if ([getFirstLetter isEqualToString:@"元"]) {//如元一角二分，第一个字符为元的情况，应当去掉元
			
			allStr = [NSMutableString stringWithFormat:@"%@",[allStr substringFromIndex:1]];
		}
	}
	
	if ([allStr isEqualToString:@"整"]|| [allStr length] == 0) {
		
		allStr = [NSMutableString stringWithFormat:@"%@",@"零元整"];
	}
	
	chineseString = [NSString stringWithFormat:@"%@",allStr];
	
		
	return chineseString;
}
/**
 * 功能：读取图片二进制 转换 成 NSString 类型
 * 参数：
 *		path	图片的名称 带 扩展名 
 *		t     YES：Document目录
 *			NO：bundle目录
 *
 * Created by wangmeng at 2011/8/18
 */

-(NSMutableString*)getStringFromImagePath:(NSString*)path inDocument:(BOOL)t{
	NSMutableString *_imageString = [[NSMutableString alloc] init];
	NSString *s;
	
	if (!t) {
		s = [[NSBundle mainBundle] pathForResource:path ofType:nil];
	}else {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		s = [documentsDirectory stringByAppendingPathComponent:path];
	}
	const char *c = [s cStringUsingEncoding:NSMacOSRomanStringEncoding];
	int ch;
	FILE* fp;
	fp=fopen(c,"r"); //只供读取
	if(fp==NULL) //如果失败了
	{
		NSLog(@"读取文件失败，请确认文件名！ %@",s);
		return nil;
	}
	while((ch=getc(fp))!=EOF)	
		[_imageString appendFormat:@"%d,",ch];
	fclose(fp); //关闭文件 

	if ([_imageString length]>0) {
		[_imageString deleteCharactersInRange:NSMakeRange([_imageString length]-1, 1)];	
	}

	return _imageString;
}

//获取运营商的信息
- (NSString*)getCellularProviderName
{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    NSString *cellularProviderName = carrier.carrierName;
//    NSString *mcc = [carrier mobileCountryCode];
//    NSString *mnc = [carrier mobileNetworkCode];
    return cellularProviderName;
}

//系统版本号
- (float) getsystemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue]; 
}

//    获得手机类型
- (NSString* )getDeviceHardware{
    UIDeviceHardware *hardWare=[[UIDeviceHardware alloc] init];
    NSString *hardWareString = [hardWare platformString];
    return hardWareString;
}

// 应用的版本
- (NSString *)getVersionString{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* versionNumString = [infoDict objectForKey:@"CFBundleVersion"];
    return  versionNumString;
}

//获取设备的uuid
-(NSString* ) getUuidString{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

//字符串的截取
- (NSString *)subVersionString:(NSString *)subString{
    if (subString==nil||[subString length] == 0) {
        subString = nil;
    }
    else {
        NSArray *subArray = [subString componentsSeparatedByString:@"."];
        NSString *firstString = [subArray objectAtIndex:0];
        NSString *secondString = [subArray objectAtIndex:1];
        NSString *returnString = [NSString stringWithFormat:@"%@%@",firstString,secondString];
        subString = returnString;
    }
    return subString;
}

- (void)alertWithFistButton:(NSString*)firstStr
               SencodButton:(NSString*)secondStr
                    Message:(NSString*)theMessageg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:theMessageg delegate:self cancelButtonTitle:firstStr otherButtonTitles:secondStr, nil];
    [alert show];
}

//缓存数据存放在沙盒里面
- (void)saveCacheUrlString:(NSString *)typeString andNSDictionary:(NSDictionary *)cacheNSDictionary{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString * key = [NSString stringWithFormat:@"%@",typeString];
    [setting setObject:cacheNSDictionary forKey:key];
    [setting synchronize];
}

//清除沙盒中的缓存数据
-(void)deleteCacheUrlString:(NSString *)typeString andNSDictionary:(NSDictionary *)cacheNSDictionary{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString * key = [NSString stringWithFormat:@"%@",typeString];
    [setting removeObjectForKey:key];
    [setting synchronize];
}

//判断本地沙盒是否有当前的数据
- (NSString *)getCacheUrlString:(NSString *)typeString
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"%@",typeString];
    NSString *value = [settings objectForKey:key];
    return  value;
}
//
-(NSDictionary *)getCacheDataDictionaryString:(NSString *)typeString{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"%@",typeString];
    NSDictionary *cacheDictionary = [settings objectForKey:key];
    
    return cacheDictionary;
}

//消除空格和html标签
-(NSString *)replaceCharctAndHtmlString:(NSString *)contentString
{
//    /\<\>/   /`\<\>/  
    NSString *replaceString = [contentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *htmlPString = [replaceString stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    NSString *htmlNextPString = [htmlPString stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    NSString *htmlStrongPString = [htmlNextPString stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    NSString *htmlNextStrongPString = [htmlStrongPString stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    NSString *brNextStrongPString = [htmlNextStrongPString stringByReplacingOccurrencesOfString:@"</br>" withString:@""];
    NSString *contentNextStrongPString = [brNextStrongPString stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];

	return contentNextStrongPString;
}
@end

