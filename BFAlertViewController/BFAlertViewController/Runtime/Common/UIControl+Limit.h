//
//  UIControl+Limit.h
//  ZBRuntime
//
//  Created by BloodSugar on 2019/5/10.
//  Copyright © 2019 OFweek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Limit)
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;
@property (nonatomic, assign) BOOL ignoreEvent;
@end

NS_ASSUME_NONNULL_END
