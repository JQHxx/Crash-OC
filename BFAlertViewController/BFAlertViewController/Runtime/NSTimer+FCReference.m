//
//  NSTimer+FCReference.m
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "NSTimer+FCReference.h"

@implementation NSTimer(FCReference)

+ (NSTimer *)resolve_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block{
    
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(resolve_blcokInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)resolve_blcokInvoke:(NSTimer *)timer {
    
    void (^block)(NSTimer *timer) = timer.userInfo;
    
    if (block) {
        block(timer);
    }
}

@end
