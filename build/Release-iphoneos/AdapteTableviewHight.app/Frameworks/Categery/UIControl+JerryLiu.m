//
//  UIControl+JerryLiu.m
//  adapteTableviewHight
//
//  Created by lhp3851 on 16/5/18.
//  Copyright © 2016年 ZizTourabc. All rights reserved.
//

/*
 NSString *actionString = NSStringFromSelector(action);
 NSString *targetName = NSStringFromClass([target class]);
 NSDictionary *configDict = [self dictionaryFromUserStatisticsConfigPlist];
 eventID = configDict[targetName][@"ControlEventIDs"][actionString];
 */

#import "UIControl+JerryLiu.h"

@implementation UIControl (JerryLiu)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

#pragma mark - Method Swizzling
- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    [self performUserStastisticsAction:action to:target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];

}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    NSLog(@"\n***hook success:\n[1]action:%@\n[2]target:%@ \n[3]event:%ld", NSStringFromSelector(action), target, (long)event);
    //    [MobClick beginEvent:<#(NSString *)#>]
}
@end
