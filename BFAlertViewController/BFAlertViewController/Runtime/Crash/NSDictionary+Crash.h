//
//  NSDictionary+CrashHandle.h
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/13.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Crash)

+ (void)swizzleNSDictionary;

@end

NS_ASSUME_NONNULL_END
