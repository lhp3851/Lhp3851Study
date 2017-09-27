//
//  archiveData.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 15/10/18.
//  Copyright © 2015年 ZizTourabc. All rights reserved.
//
/**
 1.NSUserDefaults：用来保存应用程序设置和属性、用户保存的数据。用户再次打开程序或开机后这些数据仍然存在。NSUserDefaults可以存储的数据类型包括：NSData、NSString、NSNumber、NSDate、NSArray、NSDictionary。如果要存储其他类型，则需要转换为前面的类型，才能用NSUserDefaults存储。
 */
#import "archiveData.h"

@implementation archiveData


#define knameKey @"name"
#define kageKey @"age"
#define kweightKey @"weight"
#define khobbyKey @"hobby"
#define kotherKey @"others"

@synthesize name;
@synthesize age;
@synthesize weight;
@synthesize hobby;
@synthesize others;

#pragma mark-NSCoding
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:name forKey:knameKey];
    [aCoder encodeInt:age forKey:kageKey];
    [aCoder encodeDouble:weight forKey:kweightKey];
    [aCoder encodeObject:hobby forKey:khobbyKey];
    [aCoder encodeObject:others forKey:kotherKey];
    
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
        name   =  [aDecoder decodeObjectForKey:knameKey];
        age    =  [aDecoder decodeIntForKey:kageKey];
        weight =  [aDecoder decodeDoubleForKey:kweightKey];
        hobby  =  [aDecoder decodeObjectForKey:khobbyKey];
        others =  [aDecoder decodeObjectForKey:kotherKey];
    }
    
    return self;
}


-(id)copyWithZone:(NSZone *)zone{
    archiveData *copy = [[[self class] allocWithZone:zone] init];
    copy.name   = [self.name copyWithZone:zone];
    copy.age    = self.age;
    copy.weight = self.weight;
    copy.hobby  = [self.hobby copyWithZone:zone];
    copy.others = [self.others copyWithZone:zone];
    
    return copy;
}

@end
