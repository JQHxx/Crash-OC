//
//  ExceptionMain.m
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/29.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "ExceptionMain.h"
#import "ExceptionProxy.h"

@implementation ExceptionMain

+ (void)startGuardException{
    [ExceptionProxy shareExceptionProxy].isProtectException = YES;
}

+ (void)stopGuardException{
    [ExceptionProxy shareExceptionProxy].isProtectException = NO;
}

@end
