//
//  GCDTimer.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/11/4.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDQueue;

@interface GCDTimer : NSObject

@property(nonatomic, readonly, strong) dispatch_source_t dispatchSource;

#pragma 初始化

- (instancetype)init;
- (instancetype)initInQueue:(GCDQueue *)queue;


#pragma mark -用法

- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval;
- (void)event:(dispatch_block_t)block timeInterval:(uint64_t)interval delay:(uint64_t)delay;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs;
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;
- (void)start;
- (void)destroy;

@end




