//
//  WeakProxy.h
//  OFweekPhone
//
//  Created by   on 2019/12/20.
//  Copyright © 2019 wayne. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakProxy : NSProxy

+ (instancetype)weakProxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
