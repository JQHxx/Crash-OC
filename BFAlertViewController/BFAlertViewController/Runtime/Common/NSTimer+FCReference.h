//
//  NSTimer+FCReference.h
//  BFAlertViewController
//
//  Created by  on 2019/12/28.
//  Copyright © 2019 . All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (FCReference)

+ (NSTimer *)resolve_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                            repeats:(BOOL)repeats
                                              block:(void (^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
