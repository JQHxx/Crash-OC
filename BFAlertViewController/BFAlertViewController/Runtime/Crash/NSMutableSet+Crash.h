//
//  NSMutableSet+Crash.h
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/29.
//  Copyright © 2019 OFweek01. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableSet (Crash)

+ (void)swizzleNSMutableSet;

@end

NS_ASSUME_NONNULL_END
