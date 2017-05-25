//
//  GCDGroup.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "GCDGroup.h"

@interface GCDGroup ()

@property(nonatomic, strong, readwrite) dispatch_group_t dispatchGroup;

@end

@implementation GCDGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dispatchGroup = dispatch_group_create();    //创建一个调度任务组
    }
    return self;
}
/*
 * dispatch_group
 */
- (void)enter{
    dispatch_group_enter(self.dispatchGroup);
    
}

- (void)leave{
    dispatch_group_leave(self.dispatchGroup);
    
}

- (void)wait{
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (BOOL)wait:(ino64_t)delta{
    return dispatch_group_wait(self.dispatchGroup, dispatch_time(DISPATCH_TIME_NOW, delta)) == 0;
}

@end
