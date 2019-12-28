//
//  NSDictionary+CrashHandle.m
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/13.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import "NSDictionary+Crash.h"
#import "NSObject+SwizzleMethod.h"
#import <objc/runtime.h>

@implementation NSDictionary (Crash)

+ (void)swizzleNSDictionary {
    [[NSDictionary class] swizzleMethodWithOriginalSelector:@selector(dictionaryWithObjects:forKeys:count:) swizzleSelector:@selector(hookDictionaryWithObject:forKey:)];
    [[NSDictionary class] swizzleMethodWithOriginalSelector:@selector(dictionaryWithObject:forKey:) swizzleSelector:@selector(hookDictionaryWithObjects:forKeys:count:)];

}

+ (instancetype) hookDictionaryWithObject:(id)object forKey:(id)key
{
    if (object && key) {
        return [self hookDictionaryWithObject:object forKey:key];
    }
    return nil;
}
+ (instancetype) hookDictionaryWithObjects:(const id [])objects forKeys:(const id [])keys count:(NSUInteger)cnt
{
    NSInteger index = 0;
    id ks[cnt];
    id objs[cnt];
    for (NSInteger i = 0; i < cnt ; ++i) {
        if (keys[i] && objects[i]) {
            ks[index] = keys[i];
            objs[index] = objects[i];
            ++index;
        }else{
        }
    }
    return [self hookDictionaryWithObjects:objs forKeys:ks count:index];
}
@end
