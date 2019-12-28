//
//  NSObject+KVO.m
//  BFAlertViewController
//
//  Created by  on 2019/12/28.
//  Copyright © 2019 . All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import "KVODelegate.h"
#import "NSObject+SwizzleMethod.h"


static const char *KvoDelegateKey;

@interface NSObject()

// kvo代理
@property (strong, nonatomic) KVODelegate *kvoDelegate;

@end

@implementation NSObject (KVO)

/*
 拦截由于KVO引起的崩溃
*/
+ (void)swizzleKVO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.kvoDelegate = [[KVODelegate alloc] init];

        [[NSObject class] swizzleMethodWithOriginalSelector:@selector(addObserver:forKeyPath:options:context:) swizzleSelector:@selector(shield_addObserver:forKeyPath:options:context:)];

        [[NSObject class] swizzleMethodWithOriginalSelector:@selector(removeObserver:forKeyPath:context:) swizzleSelector:@selector(shield_removeObserver:forKeyPath:context:)];

        [[NSObject class] swizzleMethodWithOriginalSelector:@selector(removeObserver:forKeyPath:) swizzleSelector:@selector(shield_removeObserver:forKeyPath:)];


        [[NSObject class] swizzleMethodWithOriginalSelector:@selector(observeValueForKeyPath:ofObject:change:context:) swizzleSelector:@selector(shield_observeValueForKeyPath:ofObject:change:context:)];

        [[NSObject class] swizzleMethodWithOriginalSelector:NSSelectorFromString(@"dealloc") swizzleSelector:NSSelectorFromString(@"shield_kvo_dealloc")];
        
    });

}

#pragma mark - Private methods
- (void)shield_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if ([self.kvoDelegate.infoMaps objectForKey:keyPath]) {
        NSMutableArray<KVOInfo *> *infoArray = [self.kvoDelegate.infoMaps objectForKey:keyPath];
        for (KVOInfo *info in infoArray) {
            if (info.observer == observer) {
                NSLog(@"%@重复添加监听%@",observer,keyPath);
            } else {
                KVOInfo *info = [[KVOInfo alloc] init];
                info.observer = observer;

                [infoArray addObject:info];
                [self.kvoDelegate.infoMaps setObject:infoArray forKey:keyPath];
            }
        }

    } else {
        KVOInfo *info = [[KVOInfo alloc] init];
        info.observer = observer;

        NSMutableArray<KVOInfo *> *infoArray = [NSMutableArray arrayWithObject:info];
        [self.kvoDelegate.infoMaps setObject:infoArray forKey:keyPath];
        [self shield_addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)shield_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context
{
    if ([self.kvoDelegate.infoMaps objectForKey:keyPath]) {
        NSMutableArray<KVOInfo *> *infoArray = [self.kvoDelegate.infoMaps objectForKey:keyPath];
        for (KVOInfo *info in infoArray) {
            if (!info.observer || info.observer == observer) {
                [infoArray removeObject:info];
            }
        }

        [self.kvoDelegate.infoMaps setObject:infoArray forKey:keyPath];

        if (infoArray.count == 0) {
            [self.kvoDelegate.infoMaps removeObjectForKey:keyPath];
            [self shield_removeObserver:observer forKeyPath:keyPath context:context];
        }

    } else {
        NSLog(@"%@移除不存在的监听%@",observer,keyPath);
    }
}

- (void)shield_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    if ([self.kvoDelegate.infoMaps objectForKey:keyPath]) {
        NSMutableArray<KVOInfo *> *infoArray = [self.kvoDelegate.infoMaps objectForKey:keyPath];
        for (KVOInfo *info in infoArray) {
            if (!info.observer || info.observer == observer) {
                [infoArray removeObject:info];
            }
        }

        [self.kvoDelegate.infoMaps setObject:infoArray forKey:keyPath];

        if (infoArray.count == 0) {
            [self.kvoDelegate.infoMaps removeObjectForKey:keyPath];
            [self shield_removeObserver:observer forKeyPath:keyPath];
        }

    } else {
        NSLog(@"%@移除不存在的监听%@",observer,keyPath);
    }
}

- (void)shield_observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([self.kvoDelegate.infoMaps objectForKey:keyPath]) {
       NSMutableArray<KVOInfo *> *infoArray = [self.kvoDelegate.infoMaps objectForKey:keyPath];
       for (KVOInfo *info in infoArray) {
           if (info.observer) {
               // 调用系统原生方法
               [self shield_observeValueForKeyPath:keyPath ofObject:info.observer change:change context:context];
           } else {
               [infoArray removeObject:info];
           }
       }
       [self.kvoDelegate.infoMaps setObject:infoArray forKey:keyPath];
   }
}

- (void)shield_kvo_dealloc
{
    if (self.kvoDelegate.infoMaps) {
        [self.kvoDelegate.infoMaps removeAllObjects];
    }
    self.kvoDelegate = nil;
}

#pragma mark - lazy

- (KVODelegate *)kvoDelegate
{
    return objc_getAssociatedObject(self, &KvoDelegateKey);
}

- (void)setKvoDelegate:(KVODelegate *)kvoDelegate
{
    objc_setAssociatedObject(self, &KvoDelegateKey, kvoDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
