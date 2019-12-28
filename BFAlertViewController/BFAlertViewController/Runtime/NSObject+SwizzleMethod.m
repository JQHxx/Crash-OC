//
//  NSObject+SwizzleMethod.m
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/13.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>

@implementation NSObject (SwizzleMethod)

- (void)swizzleMethodWithOriginalSelector:(SEL)originalSelector
                          swizzleSelector:(SEL)swizzelSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzeldMethod = class_getInstanceMethod(class, swizzelSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzeldMethod),
                                        method_getTypeEncoding(swizzeldMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzelSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzeldMethod);
    }
}

@end
