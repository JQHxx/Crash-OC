//
//  NSDictionary+CrashHandle.m
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/13.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import "NSDictionary+CrashHandle.h"
#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>

@implementation NSDictionary (CrashHandle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSDictionaryM") swizzleMethodWithOriginalSelector:@selector(setObject:forKey:) swizzleSelector:@selector(swizzled_mutableSetObject:forKey:)];
        }
    });
}

- (void)swizzled_mutableSetObject:(id)obj forKey:(NSString *)key {
    if (obj && key) {
        [self swizzled_mutableSetObject:obj forKey:key];
    }
}

@end
