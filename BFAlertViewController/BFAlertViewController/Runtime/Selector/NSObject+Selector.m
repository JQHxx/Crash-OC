//
//  NSObject+Selector.m
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "NSObject+Selector.h"
#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>

@implementation NSObject (Selector)

#pragma mark - Public methods
/*
 拦截由于未找到方法引起的崩溃
 */
+ (void)swizzleUnrecognizedSelector{

    //Class Method
    zxp_swizzleSelector([self class], @selector(methodSignatureForSelector:), @selector(classMethodSignatureForSelectorSwizzled:));
    zxp_swizzleSelector([self class], @selector(forwardInvocation:), @selector(forwardClassInvocationSwizzled:));

    //Instance Method
    zxp_swizzleSelector([self class], @selector(methodSignatureForSelector:), @selector(methodSignatureForSelectorSwizzled:));
    zxp_swizzleSelector([self class], @selector(forwardInvocation:), @selector(forwardInvocationSwizzled:));
}

+ (NSMethodSignature*)classMethodSignatureForSelectorSwizzled:(SEL)aSelector {
    NSMethodSignature* methodSignature = [self classMethodSignatureForSelectorSwizzled:aSelector];
    if (methodSignature) {
        return methodSignature;
    }

    return [self.class checkObjectSignatureAndCurrentClass:self.class];
}

- (NSMethodSignature*)methodSignatureForSelectorSwizzled:(SEL)aSelector {
    NSMethodSignature* methodSignature = [self methodSignatureForSelectorSwizzled:aSelector];
    if (methodSignature) {
        return methodSignature;
    }

    return [self.class checkObjectSignatureAndCurrentClass:self.class];
}

/**
 * Check the class method signature to the [NSObject class]
 * If not equals,return nil
 * If equals,return the v@:@ method
 @param currentClass Class
 @return NSMethodSignature
 */
+ (NSMethodSignature *)checkObjectSignatureAndCurrentClass:(Class)currentClass{
    IMP originIMP = class_getMethodImplementation([NSObject class], @selector(methodSignatureForSelector:));
    IMP currentClassIMP = class_getMethodImplementation(currentClass, @selector(methodSignatureForSelector:));

    // If current class override methodSignatureForSelector return nil
    if (originIMP != currentClassIMP){
        return nil;
    }

    // Customer method signature
    // void xxx(id,sel,id)
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

/**
 Forward instance object
 @param invocation NSInvocation
 */
- (void)forwardInvocationSwizzled:(NSInvocation*)invocation{
    NSString* message = [NSString stringWithFormat:@"Unrecognized instance class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(invocation.selector)];
    NSLog(@"%@", message);
}

/**
 Forward class object
 @param invocation NSInvocation
 */
+ (void)forwardClassInvocationSwizzled:(NSInvocation*)invocation{
    NSString* message = [NSString stringWithFormat:@"Unrecognized static class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(invocation.selector)];
    NSLog(@"%@", message);
}

@end
