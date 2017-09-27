//
//  NSString+NSStringCatagery.m
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/3.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

#import "NSString+NSStringCatagery.h"

@implementation NSString (NSStringCatagery)
//价格数量预付
- (BOOL)isScope{
    if(!([self doubleValue] >0)|| self.length == 0){
        
        return YES;
        
    }else{
        return NO;
    }
}

// Checking if String is Empty

-(BOOL)isBlank

{
    
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
    
}

//Checking if String is empty or nil

-(BOOL)isValid

{
    
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil|| self.length==0 || [self isEqualToString:@"(null)"]) ? NO :YES;
    
}

// remove white spaces from String

- (NSString *)removeWhiteSpacesFromString

{
    
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return trimmedString;
    
}

// Counts number of Words in String

- (NSUInteger)countNumberOfWords

{
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    
    while ([scanner scanUpToCharactersFromSet: whiteSpace intoString: nil]) {
        
        count++;
        
    }
    
    return count;
    
}

// If string contains substring

- (BOOL)containsString:(NSString *)subString

{
    
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
    
}

// If my string starts with given string

- (BOOL)isBeginsWith:(NSString *)string

{
    
    return ([self hasPrefix:string]) ? YES : NO;
    
}

// If my string ends with given string

- (BOOL)isEndssWith:(NSString *)string

{
    
    return ([self hasSuffix:string]) ? YES : NO;
    
}

// Replace particular characters in my string with new character

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar

{
    
    return [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
    
}

// Get Substring from particular location to given lenght

- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end

{
    NSAssert(self.length<end, @"子字符串过长");
    
    NSRange r;
    
    r.location = begin;
    
    r.length = end - begin;
    
    return [self substringWithRange:r];
    
}

// Add substring to main String

- (NSString *)addString:(NSString *)string

{
    
    if(!string || string.length == 0)
        
        return self;
    
    return [self stringByAppendingString:string];
    
}

// Remove particular sub string from main string

-(NSString *)removeSubString:(NSString *)subString

{
    
    if ([self containsString:subString])
        
    {
        
        NSRange range = [self rangeOfString:subString];
        
        return [self stringByReplacingCharactersInRange:range withString:@""];
        
    }
    
    return self;
    
}

// If my string contains ony letters

- (BOOL)containsOnlyLetters
{
    
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
    
}

// If my string contains only numbers

- (BOOL)containsOnlyNumbers

{
    
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
    
}

- (BOOL)containsChineseCharacters
{
    
    for(int i=0; i< [self length];i++){
        
        int a = [self characterAtIndex:i];
        
        if( a > 0x4e00 && a < 0x9fff){
            
            return YES;
            
        }
    }
    
    return NO;
    
}

- (BOOL)containsAddressCharacters

{
    
    for(int i=0; i< [self length];i++){
        
        int a = [self characterAtIndex:i];
        
        if( a < 0x4e00 || a > 0x9fff){
            
            NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
            
            NSRange userNameRange = [[self substringFromIndex:i] rangeOfCharacterFromSet:nameCharacters];
            
            if (userNameRange.location != NSNotFound) {
                
                NSLog(@"%@",[self substringWithRange:NSMakeRange(i, 1)]);
                
                //NSRange range = [[self substringWithRange:NSMakeRange(i, 1)] rangeOfString:@"#*/"];//判断字符串是否包含
                
                if (![[self substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"/"] &&
                    
                    (![[self substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"#"] &&
                     
                     ![[self substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"*"])) {
                        
                        return NO;
                        
                    }
                
                //                if (range.location ==NSNotFound)//不包含
                
                //                {
                
                //                    return NO;
                
                //                }
                
            }
            
        }
        
    }
    
    return YES;
    
}

// If my string contains letters and numbers

- (BOOL)containsOnlyNumbersAndLetters

{
    
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
    
}

// If my string contains none letters and numbers

- (BOOL)containsNoneNumbersAndLetters

{
    
    NSCharacterSet *numAndLetterCharSet = [NSCharacterSet alphanumericCharacterSet];
    
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
    
}

// If my string is available in particular array

- (BOOL)isInThisarray:(NSArray*)array

{
    
    for(NSString *string in array) {
        
        if([self isEqualToString:string]) {
            
            return YES;
            
        }
        
    }
    
    return NO;
    
}

// Get String from array

+ (NSString *)getStringFromArray:(NSArray *)array

{
    
    return [array componentsJoinedByString:@" "];
    
}

// Convert Array from my String

- (NSArray *)getArray

{
    
    return [self componentsSeparatedByString:@" "];
    
}

// Get My Application Version number

+ (NSString *)getMyApplicationVersion

{
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *version = [info objectForKey:@"CFBundleVersion"];
    
    return version;
    
}

// Get My Application name

+ (NSString *)getMyApplicationName

{
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    NSString *name = [info objectForKey:@"CFBundleDisplayName"];
    
    return name;
    
}

// Convert string to NSData
- (NSData *)convertToData

{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// Get String from NSData
+ (NSString *)getStringFromData:(NSData *)data

{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
}

// Is Valid Email
- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTestPredicate evaluateWithObject:self];
}

// Is Valid Phone

- (BOOL)isVAlidPhoneNumber
{
    NSString *regex = @"(\\d{3,4}-)?\\d{6,8}(-\\d{3})?";
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [test evaluateWithObject:self];
}

- (BOOL)isVAlidMobelNumber
{
    NSString *regex = @"[1][358][0-9]{9}";
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [test evaluateWithObject:self];
}

// Is Valid URL

- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [urlTest evaluateWithObject:self];
}

// ^[A-Za-z0-9\u4E00-\u9FA5_-]+$

- (BOOL)isValidNomalString{// 只包含中英文字符、数字和"_"或减号
    
    NSString *regex =@"^[A-Za-z0-9\u4E00-\u9FA5_-]+$";
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [test evaluateWithObject:self];
}

// 判断是否为合法的手机号或者电话号码

- (BOOL)isValidMobileNumberOrPhoneNumber

{
    
    NSString *mobileNum = self;
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10        * 中国移动：China Mobile
     11        * 134[0-8],135,136,137,138,139,150,151,157,158,159,181,182,187,188
     12        */
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    /**
     15        * 中国联通：China Unicom
     16        * 130,131,132,152,155,156,185,186
     17        */
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     20        * 中国电信：China Telecom
     21        * 133,1349,153,180,189
     22        */
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25        * 大陆地区固话及小灵通
     26        * 区号：010,020,021,022,023,024,025,027,028,029
     27        * 号码：七位或八位
     28        */
    
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        
        || ([regextestphs evaluateWithObject:mobileNum] == YES)
        
        )
    {
        return YES;
    }
    
    else
        
    {
        return NO;
    }
}
@end
