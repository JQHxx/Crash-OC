//
//  NSObject+Zombie.h
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Zombie)

/*
 拦截由于野指针引起的崩溃
*/
+ (void)SwizzleZombie;

@end

NS_ASSUME_NONNULL_END
