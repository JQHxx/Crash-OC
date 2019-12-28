//
//  NSObject+KVC.m
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "NSObject+KVC.h"
#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>

@implementation NSObject (KVC)

+ (void)swizzleKVC {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSObject class] swizzleMethodWithOriginalSelector:@selector(setValue:forKey:) swizzleSelector:@selector(shield_setValue:forKey:)];

        [[NSObject class] swizzleMethodWithOriginalSelector:@selector(setValue:forKeyPath:) swizzleSelector:@selector(shield_setValue:forKeyPath:)];

        [[NSObject class] swizzleMethodWithOriginalSelector:@selector(setValue:forUndefinedKey:) swizzleSelector:@selector(shield_setValue:forUndefinedKey:)];

        [[NSObject class] swizzleMethodWithOriginalSelector:@selector(setValuesForKeysWithDictionary:) swizzleSelector:@selector(shield_setValuesForKeysWithDictionary:)];
    });

}

#pragma mark - Private methods
- (void)shield_setValue:(nullable id)value forKey:(NSString *)key
{
    @try {
        [self shield_setValue:value forKey:key];
    } @catch (NSException *exception) {

    } @finally {

    }
}

- (void)shield_setValue:(nullable id)value forKeyPath:(NSString *)keyPath
{
    @try {
        [self shield_setValue:value forKeyPath:keyPath];
    } @catch (NSException *exception) {

    } @finally {

    }
}

- (void)shield_setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    @try {
        [self shield_setValue:value forUndefinedKey:key];
    } @catch (NSException *exception) {

    } @finally {

    }
}

- (void)shield_setValuesForKeysWithDictionary:(NSDictionary<NSString *, id> *)keyedValues
{
    @try {
        [self shield_setValuesForKeysWithDictionary:keyedValues];
    } @catch (NSException *exception) {

    } @finally {

    }
}

@end
