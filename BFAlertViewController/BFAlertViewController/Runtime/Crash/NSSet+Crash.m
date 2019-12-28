//
//  NSSet+Crash.m
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/29.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "NSSet+Crash.h"
#import "NSObject+SwizzleMethod.h"


@implementation NSSet (Crash)

+ (void)swizzleNSSet {
    [[NSSet class] swizzleMethodWithOriginalSelector:@selector(setWithObject:) swizzleSelector:@selector(hookSetWithObject:)];
}

+ (instancetype)hookSetWithObject:(id)object{
    if (object){
        return [self hookSetWithObject:object];
    }
    return nil;
}

@end
