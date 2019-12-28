//
//  NSObject+SwizzleMethod.h
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/13.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/// 日志标题线
UIKIT_EXTERN NSString * const ShieldTitleSeparator;
/// 日志分隔线
UIKIT_EXTERN NSString * const ShieldBottomSeparator;

static inline void zxp_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@interface NSObject (SwizzleMethod)
- (void)swizzleMethodWithOriginalSelector:(SEL)originalSelector
                          swizzleSelector:(SEL)swizzelSelector;

+ (void)shield_catchException:(NSException *)exception;
@end

NS_ASSUME_NONNULL_END
