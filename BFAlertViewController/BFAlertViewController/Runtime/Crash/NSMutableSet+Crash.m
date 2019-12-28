//
//  NSMutableSet+Crash.m
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/29.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "NSMutableSet+Crash.h"
#import "NSObject+SwizzleMethod.h"

@implementation NSMutableSet (Crash)

+ (void)swizzleNSMutableSet {
    NSMutableSet* instanceObject = [NSMutableSet new];
    Class cls =  object_getClass(instanceObject);

    zxp_swizzleSelector(cls,@selector(addObject:), @selector(hookAddObject:));
    zxp_swizzleSelector(cls,@selector(removeObject:), @selector(hookRemoveObject:));
}

- (void) hookAddObject:(id)object {
    if (object) {
        [self hookAddObject:object];
    } else {
    }
}

- (void) hookRemoveObject:(id)object {
    if (object) {
        [self hookRemoveObject:object];
    } else {

    }
}


@end
