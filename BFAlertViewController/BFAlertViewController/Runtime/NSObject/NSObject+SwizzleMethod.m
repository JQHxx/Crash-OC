//
//  NSObject+SwizzleMethod.m
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/13.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import "NSObject+SwizzleMethod.h"

NSString * const ShieldTitleSeparator  = @"************************ Crash Info **************************";
NSString * const ShieldBottomSeparator = @"****************************************************************";

@implementation NSObject (SwizzleMethod)

- (void)swizzleMethodWithOriginalSelector:(SEL)originalSelector
                          swizzleSelector:(SEL)swizzelSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzeldMethod = class_getInstanceMethod(class, swizzelSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzeldMethod),
                                        method_getTypeEncoding(swizzeldMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzelSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzeldMethod);
    }
}

/**
 捕获异常和异常类型

 @param exception 异常
 */
+ (void)shield_catchException:(NSException *)exception
{
    if (exception) {
        [self handleCatchedException:exception withAction:^(NSString *message) {
            NSLog(@"%@", message);
        }];
    } else {

    }
}

#pragma mark - Private Api

/**
 处理捕获的异常

 @param exception 异常
 @param action 处理方式，如上传，在控制台输出等
 */
+ (void)handleCatchedException:(NSException *)exception
                    withAction:(void(^)(NSString *))action
{
    //获取堆栈数据
    NSArray *callStackSymbolsArray = [NSThread callStackSymbols];
    NSString *mainCallStackSymbolMsg = [self getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArray];
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"崩溃信息定位失败,请您查看函数调用栈来排查错误原因";
    }

    NSString *exceptionName = [NSString stringWithFormat:@"App crashed due to uncaught exception: %@",exception.name];
    NSString *exceptionReason = [NSString stringWithFormat:@"reason: %@ ",exception.reason];
    exceptionReason = [exceptionReason stringByReplacingOccurrencesOfString:@"shield_" withString:@""];
    NSString *logExceptionMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\nFirst throw call stack: %@\n",ShieldTitleSeparator, exceptionName, exceptionReason, mainCallStackSymbolMsg];
    logExceptionMessage = [NSString stringWithFormat:@"%@\n%@\n ",logExceptionMessage,ShieldBottomSeparator];
    if (action) {
        action(logExceptionMessage);
    }
}

/**
 获取堆栈主要崩溃信息

 @param callStackSymbols 堆栈主要崩溃信息
 @return 堆栈主要崩溃信息，格式为 +[类名 方法名]  或者 -[类名 方法名]
 */
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols
{
    __block NSString *mainCallStackSymbolMsg = nil;
    //正则格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *pattern = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExpession = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //直接从下标为2的位置开始，因为下标为0和1的位置分别是shield_handleException和shield_forwardInvocation
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];

        [regularExpession enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                //获取类名
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                //过滤分类方法
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                }
                *stop = YES;
            }
        }];

        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    return mainCallStackSymbolMsg;
}

@end
