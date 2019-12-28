//
//  NSObject+KVO.m
//  BFAlertViewController
//
//  Created by  on 2019/12/28.
//  Copyright © 2019 . All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>

@implementation NSObject (KVO)

+ (void)load{
    [self switchMethod];
}

+ (void)switchMethod{

    SEL removeSel = @selector(removeObserver:forKeyPath:);
    SEL myRemoveSel = @selector(removeDasen:forKeyPath:);
    SEL addSel = @selector(addObserver:forKeyPath:options:context:);
    SEL myaddSel = @selector(addDasen:forKeyPath:options:context:);
    
    Method systemRemoveMethod = class_getClassMethod([self class],removeSel);
    Method DasenRemoveMethod = class_getClassMethod([self class], myRemoveSel);
    Method systemAddMethod = class_getClassMethod([self class],addSel);
    Method DasenAddMethod = class_getClassMethod([self class], myaddSel);
    method_exchangeImplementations(systemRemoveMethod, DasenRemoveMethod);
    method_exchangeImplementations(systemAddMethod, DasenAddMethod);
}

- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    @try {
        [self removeDasen:observer forKeyPath:keyPath];
    } @catch (NSException *exception) {
    }
}

- (void)addDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    [self addDasen:observer forKeyPath:keyPath options:options context:context];
}

@end
