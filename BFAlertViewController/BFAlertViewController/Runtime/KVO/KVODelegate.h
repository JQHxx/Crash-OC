//
//  KVODelegate.h
//  BFAlertViewController
//
//  Created by HJQ on 2019/12/28.
//  Copyright © 2019 OFweek01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOInfo : NSObject
// 观察者对象
@property(nonatomic, weak) NSObject * _Nullable observer;
// keyPath
//@property(nonatomic, strong) NSString * _Nonnull keyPath;
//// options
//@property(nonatomic, assign) NSKeyValueObservingOptions options;
//// context
//@property(nonatomic, assign) void * _Nonnull context;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KVODelegate : NSObject

// 内存数据
@property (nonatomic , strong) NSMutableDictionary *infoMaps;

@end

NS_ASSUME_NONNULL_END
