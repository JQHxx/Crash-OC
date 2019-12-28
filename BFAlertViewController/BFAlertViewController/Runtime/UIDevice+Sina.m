//
//  UIDevice+Sina.m
//  OFweekPhone
//
//  Created by OFweek01 on 2019/12/10.
//  Copyright © 2019 wayne. All rights reserved.
//

#import "UIDevice+Sina.h"
#import <objc/runtime.h>

@implementation UIDevice (Sina)

+ (void)load {
    //修复iOS13下 崩溃问题 验证为：模拟器下出现
    #if TARGET_IPHONE_SIMULATOR
    /// 交换方法实现
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if(@available(iOS 13.0, *)){
                Method origin = class_getClassMethod([UIDevice class], NSSelectorFromString(@"getUniqueStrByUUID"));
                //    IMP originImp = method_getImplementation(origin);
                
                Method swizz = class_getClassMethod([self class], @selector(swizz_getUniqueStrByUUID));
                //交换方法实现
                method_exchangeImplementations(origin, swizz);
            }
        });
    #endif
}

#pragma mark - 获取唯一标识 新浪
+ (NSString *)swizz_getUniqueStrByUUID{
    CFUUIDRef  uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString ;
}

@end
