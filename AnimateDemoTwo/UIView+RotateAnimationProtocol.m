//
//  UIView+RotateAnimationProtocol.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/25.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "UIView+RotateAnimationProtocol.h"
#import <objc/runtime.h>


@implementation UIView (RotateAnimationProtocol)

NSString *const _recognizerRotateDuration = @"_recognizerRotateDuration";
- (void)setRotateDuration:(CGFloat)rotateDuration{
    NSNumber *value = @(rotateDuration);
    objc_setAssociatedObject(self, (__bridge const void*)(_recognizerRotateDuration), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)rotateDuration{
    NSNumber *valuye = objc_getAssociatedObject(self, (__bridge const void*)(_recognizerRotateDuration));
    return [valuye floatValue];
}


NSString *const _recognizerDefaultTransform = @"_recognizerDefaultTransform";
- (void)setDefaultTransform:(CGAffineTransform)defaultTransform{
    NSValue *value = [NSValue valueWithCGAffineTransform:defaultTransform];
    objc_setAssociatedObject(self, (__bridge void *)(_recognizerDefaultTransform), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGAffineTransform)defaultTransform{
    NSValue *value = objc_getAssociatedObject(self, (__bridge void *)(_recognizerDefaultTransform));
    return [value CGAffineTransformValue];
}




@end
