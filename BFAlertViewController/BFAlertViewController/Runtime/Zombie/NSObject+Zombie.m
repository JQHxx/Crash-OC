//
//  NSObject+Zombie.m
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "NSObject+Zombie.h"
#import "NSObject+SwizzleMethod.h"
#import "ShieldZombieObject.h"
#import <objc/runtime.h>
#import "ShieldZombieSub.h"

#define ZoombieMaxCache 1024 * 1024 * 5

@implementation NSObject (Zombie)

/*
 拦截由于野指针引起的崩溃
*/
+ (void)SwizzleZombie
{
   static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSObject class] swizzleMethodWithOriginalSelector:NSSelectorFromString(@"dealloc") swizzleSelector:NSSelectorFromString(@"shield_zombie_dealloc")];

        [[ShieldZombieObject share] addBlackArray:@[[self class]]];
    });
}


- (void)shield_zombie_dealloc
{
    Class currentClass = self.class;

    // 不在黑名单里调系统原生释放方法
    if (![[ShieldZombieObject share].blackClassesSet containsObject:currentClass]) {
        [self shield_zombie_dealloc];
    }

    if ([ShieldZombieObject share].currentClassSize > ZoombieMaxCache) {//设置最大缓存上限5M
        id object = [[ShieldZombieObject share] objectFromCurrentClassesSet];
        [[ShieldZombieObject share] removeCurrentZombieClass:object_getClass(object)];
        object ? free(object) : nil;
    }

    // -fno-objc-arc
    objc_destructInstance(self);

    object_setClass(self, [ShieldZombieSub class]);
    [[ShieldZombieObject share] addCurrentZombieClass:currentClass];
}

@end
