//
//  UIControl+Limit.m
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/10.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import "UIControl+Limit.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval="UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent="UIControl_ignoreEvent";

@implementation UIControl (Limit)

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setIgnoreEvent:(BOOL)ignoreEvent {
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)ignoreEvent {
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

#pragma mark - Swizzing
+ (void)load {
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(swizzled_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

- (void)swizzled_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.ignoreEvent) {
        NSLog(@"按钮点击被拦截");
        return;
    }
    if (self.acceptEventInterval > 0) {
        self.ignoreEvent = YES;
        [self performSelector:@selector(setIgnoreEventWithNo) withObject:nil afterDelay:self.acceptEventInterval];
    }
    [self swizzled_sendAction:action to:target forEvent:event];
}

- (void)setIgnoreEventWithNo {
    self.ignoreEvent = NO;
}

@end
