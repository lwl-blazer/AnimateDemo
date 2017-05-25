//
//  RotateAnimationView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/28.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "RotateAnimationView.h"
#import "NormalRotateAnimationType.h"

@implementation RotateAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configDefaultValue];
    }
    return self;
}

- (void)configDefaultValue{
    self.duration = 1.f;
    self.fromCircleRadian = 0.f;
    self.toCircleRadian = M_PI;
    self.animationType = [NormalRotateAnimationType new];
}

- (void)startRotateAnimated:(BOOL)animated{
    if (animated) {
        self.animationType.clientView = self;
        [self.animationType startAnimation];
    }else{
        self.layer.transform = CATransform3DMakeRotation(_toCircleRadian, 0, 0, 1);
    }
}

@end
