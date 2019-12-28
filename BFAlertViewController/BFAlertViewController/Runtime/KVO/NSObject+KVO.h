//
//  NSObject+KVO.h
//  BFAlertViewController
//
//  Created by  on 2019/12/28.
//  Copyright © 2019 . All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVO)

/*
 拦截由于KVO引起的崩溃
*/
+ (void)swizzleKVO;

@end

NS_ASSUME_NONNULL_END
