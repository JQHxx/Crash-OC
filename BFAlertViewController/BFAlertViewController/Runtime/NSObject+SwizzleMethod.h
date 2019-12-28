//
//  NSObject+SwizzleMethod.h
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/13.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SwizzleMethod)
- (void)swizzleMethodWithOriginalSelector:(SEL)originalSelector
                          swizzleSelector:(SEL)swizzelSelector;
@end

NS_ASSUME_NONNULL_END
