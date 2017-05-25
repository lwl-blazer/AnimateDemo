//
//  GCDGroup.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDGroup : NSObject

@property(nonatomic, strong, readonly) dispatch_group_t dispatchGroup;

- (instancetype)init;

- (void)enter;
- (void)leave;
- (void)wait;
- (BOOL)wait:(ino64_t)delta;

@end
