//
//  ExceptionProxy.m
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/29.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "ExceptionProxy.h"
#import "NSArray+Crash.h"
#import "NSMutableArray+Crash.h"
#import "NSDictionary+Crash.h"
#import "NSMutableDictionary+Crash.h"
#import "NSString+Crash.h"
#import "NSAttributedString+Crash.h"
#import "NSSet+Crash.h"
#import "NSMutableSet+Crash.h"
#import "NSObject+KVO.h"
#import "NSObject+KVC.h"
#import "NSTimer+Shield.h"
#import "NSObject+Selector.h"
#import "NSObject+Zombie.h"

@interface ExceptionProxy() {
    dispatch_semaphore_t _swizzleLock;
}

@end

@implementation ExceptionProxy

+(instancetype)shareExceptionProxy{
    static dispatch_once_t onceToken;
    static id exceptionProxy;
    dispatch_once(&onceToken, ^{
        exceptionProxy = [[self alloc] init];
    });
    return exceptionProxy;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _swizzleLock = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)setIsProtectException: (BOOL)isProtectException{
    dispatch_semaphore_wait(_swizzleLock, DISPATCH_TIME_FOREVER);
    if (_isProtectException != isProtectException) {
        _isProtectException = isProtectException;

        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"

         [NSArray performSelector:@selector(swizzleNSArray)];
         [NSMutableArray performSelector:@selector(swizzleNSMutableArray)];
         [NSSet performSelector:@selector(swizzleNSSet)];
         [NSMutableSet performSelector:@selector(swizzleNSMutableSet)];


        #pragma clang diagnostic pop
    }
    dispatch_semaphore_signal(_swizzleLock);
}

@end
