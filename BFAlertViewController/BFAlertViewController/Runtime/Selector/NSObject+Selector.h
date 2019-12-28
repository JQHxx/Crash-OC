//
//  NSObject+Selector.h
//  BFAlertViewController
//
//  Created by OFweek01 on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Selector)

/*
 拦截由于未找到方法引起的崩溃
 */
+ (void)swizzleUnrecognizedSelector;

@end

NS_ASSUME_NONNULL_END
