//
//  NSString+NSStringCatagery.h
//  adapteTableviewHight
//
//  Created by kankanliu on 16/5/3.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//
/*
 1.自定义的名字在后面，向NSString类添加扩展的方法。类别（ category ）是 Objective-C 语言的新特性，为现有的类添加新方法的方式。
   局限性：1、无法添加新的实例变量。2、与类本身的方法名称冲突。当名称冲突时，类别具有更高的优先级。
   作用：1、利用类别分散实现。2、使用类别创建前向引用。3、非正式协议和委托类别。
 2.虽然Category不能够为类添加新的成员变量，但是Category包含类的所有成员变量，即使是@private的。
 3.Category可以重新定义新方法，也可以override继承过来的方法。
 
*/

#import <Foundation/Foundation.h>

@interface NSString (NSStringCatagery)
- (BOOL)isScope;

-(BOOL)isBlank;

-(BOOL)isValid;

- (NSString *)removeWhiteSpacesFromString;

- (NSUInteger)countNumberOfWords;

- (BOOL)containsString:(NSString *)subString;

- (BOOL)isBeginsWith:(NSString *)string;

- (BOOL)isEndssWith:(NSString *)string;

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;

- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;

- (NSString *)addString:(NSString *)string;

- (NSString *)removeSubString:(NSString *)subString;

- (BOOL)containsOnlyLetters;

- (BOOL)containsOnlyNumbers;

- (BOOL)containsOnlyNumbersAndLetters;

- (BOOL)containsNoneNumbersAndLetters;

- (BOOL)containsChineseCharacters;

- (BOOL)isInThisarray:(NSArray*)array;

- (BOOL)containsAddressCharacters;

+ (NSString *)getStringFromArray:(NSArray *)array;

- (NSArray *)getArray;

+ (NSString *)getMyApplicationVersion;

+ (NSString *)getMyApplicationName;

- (NSData *)convertToData;

+ (NSString *)getStringFromData:(NSData *)data;

- (BOOL)isValidEmail;

- (BOOL)isVAlidPhoneNumber;

- (BOOL)isValidUrl;

- (BOOL)isValidNomalString;

- (BOOL)isValidMobileNumberOrPhoneNumber;

- (BOOL)isVAlidMobelNumber;


@end
