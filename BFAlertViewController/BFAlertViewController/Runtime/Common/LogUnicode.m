//
//  ZXPUnicode.m
//
//  blog : http://blog.csdn.net/biggercoffee
//  github : https://github.com/biggercoffee/ZXPUnicode
//
//  Created by Mango on 2017/3/31.
//  Copyright © 2017年 coffee. All rights reserved.
//

#import "LogUnicode.h"
#import <objc/runtime.h>
#import "NSObject+SwizzleMethod.h"

@implementation NSString (LogUnicode)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (LogUnicode)

#if DEBUG
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}
#endif

/**
 *  我觉得 
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 */

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (LogUnicode)

#if DEBUG
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}
#endif

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (ZXPUnicode)

#if DEBUG
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}
#endif

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

