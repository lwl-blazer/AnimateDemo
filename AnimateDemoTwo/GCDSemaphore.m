
//
//  GCDSemaphore.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/11/4.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "GCDSemaphore.h"

@interface GCDSemaphore ()

@property(nonatomic,strong, readwrite) dispatch_semaphore_t dispatchSemphore;

@end


@implementation GCDSemaphore

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dispatchSemphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (instancetype)initWithValue:(long)value{
    self = [super init];
    if (self) {
        self.dispatchSemphore = dispatch_semaphore_create(value);
    }
    return self;
}

- (BOOL)signal{
    return dispatch_semaphore_signal(self.dispatchSemphore) != 0;
}


- (void)wait{
    dispatch_semaphore_wait(self.dispatchSemphore, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(int64_t)delta{
    return dispatch_semaphore_wait(self.dispatchSemphore, dispatch_time(DISPATCH_TIME_FOREVER, delta)) != 0;
}

@end
