//
//  NSString+Crash.h
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Crash)

/*
 拦截字符串所有崩溃
*/
+ (void)swizzleNSString;

@end

NS_ASSUME_NONNULL_END
