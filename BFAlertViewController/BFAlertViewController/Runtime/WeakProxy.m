//
//  WeakProxy.m
//  OFweekPhone
//
//  Created by OFweek01 on 2019/12/20.
//  Copyright © 2019 wayne. All rights reserved.
//

#import "WeakProxy.h"

@interface WeakProxy()

@property (nonatomic, weak) id target;

@end

@implementation WeakProxy

+ (instancetype)weakProxyWithTarget:(id)target
{
    WeakProxy *weakProxy = [WeakProxy alloc];
    weakProxy.target = target;
    
    return weakProxy;
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}


- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}


@end
