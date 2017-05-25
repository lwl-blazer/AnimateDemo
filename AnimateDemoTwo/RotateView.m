//
//  RotateView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/25.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "RotateView.h"

@implementation RotateView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.defaultTransform = self.transform;
    }
    return self;
}


#pragma mark --动画执行

- (void)changeToUpAnimated:(BOOL)animated{
    if (animated) {
        
        [UIView animateWithDuration:(self.rotateDuration > 0 ? self.rotateDuration : 0.5f) animations:^{
            self.transform = self.defaultTransform;
        }];
    }else{
        self.transform = self.defaultTransform;
    }
}


- (void)changeToLeftAnimated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:(self.rotateDuration > 0 ? self.rotateDuration : 0.5f) animations:^{
            self.transform = CGAffineTransformRotate(self.defaultTransform,  - M_PI_2);
        }];
    }else{
        self.transform = CGAffineTransformRotate(self.defaultTransform, - M_PI_2);
    }
}

- (void)changeToRightAnimated:(BOOL)animated{
    if (animated) {
        
        [UIView animateWithDuration:(self.rotateDuration > 0 ? self.rotateDuration : 0.5f) animations:^{
            self.transform = CGAffineTransformRotate(self.defaultTransform, M_PI_2);
        }];
    }else{
        self.transform = CGAffineTransformRotate(self.defaultTransform, M_PI_2);
    }
}


- (void)changeToDownAnimated:(BOOL)animated{
    if (animated) {
        
        [UIView animateWithDuration:(self.rotateDuration > 0 ? self.rotateDuration : 0.5f) animations:^{
            self.transform = CGAffineTransformRotate(self.defaultTransform, M_PI);
        }];
    }else{
        
        self.transform = CGAffineTransformRotate(self.defaultTransform, M_PI);
    }
}



@end
