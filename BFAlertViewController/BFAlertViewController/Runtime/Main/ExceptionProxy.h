//
//  ExceptionProxy.h
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/29.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExceptionProxy : NSObject

+ (instancetype)shareExceptionProxy;

/**
 Setting hook excpetion status,default value is NO
 */
@property(nonatomic,readwrite,assign)BOOL isProtectException;

@end

NS_ASSUME_NONNULL_END
