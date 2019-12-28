//
//  KVODelegate.m
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import "KVODelegate.h"

@implementation KVOInfo

@end

@implementation KVODelegate

#pragma mark - Lazy
- (NSMutableDictionary *)infoMaps
{
    if (_infoMaps == nil) {
        _infoMaps = [NSMutableDictionary dictionary];
    }
    return _infoMaps;
}

@end
