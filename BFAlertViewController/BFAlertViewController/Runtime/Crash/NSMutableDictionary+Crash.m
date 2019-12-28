//
//  NSMutableDictionary+Crash.m
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/29.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "NSMutableDictionary+Crash.h"
#import "NSObject+SwizzleMethod.h"

@implementation NSMutableDictionary (Crash)

+ (void)swizzleNSMutableDictionary{
    zxp_swizzleSelector(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:), @selector(hookSetObject:forKey:));
    zxp_swizzleSelector(NSClassFromString(@"__NSDictionaryM"), @selector(removeObjectForKey:), @selector(hookRemoveObjectForKey:));
    zxp_swizzleSelector(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKeyedSubscript:), @selector(hookSetObject:forKeyedSubscript:));
}

- (void) hookSetObject:(id)object forKey:(id)key {
    if (object && key) {
        [self hookSetObject:object forKey:key];
    } else {
    }
}

- (void) hookRemoveObjectForKey:(id)key {
    if (key) {
        [self hookRemoveObjectForKey:key];
    } else {
    }
}

- (void) hookSetObject:(id)object forKeyedSubscript:(id<NSCopying>)key {
    if (key) {
        [self hookSetObject:object forKeyedSubscript:key];
    } else {
    }
}

@end
