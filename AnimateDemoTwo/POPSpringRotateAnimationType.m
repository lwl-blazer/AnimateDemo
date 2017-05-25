//
//  POPSpringRotateAnimationType.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/28.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "POPSpringRotateAnimationType.h"
#import "RotateAnimationView.h"
#import <pop/POP.h>

@interface POPSpringRotateAnimationType ()

@property(nonatomic, weak) RotateAnimationView *animationView;

@end

@implementation POPSpringRotateAnimationType

- (void)setClientView:(UIView *)clientView{
    self.animationView = (RotateAnimationView *)clientView;
}

- (UIView *)clientView{
    return self.animationView;
}

- (void)startAnimation{
    if (self.animationView) {
        
        //设置动画
        POPSpringAnimation *circle = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
        circle.fromValue = [NSNumber numberWithFloat:self.animationView.fromCircleRadian];
        circle.toValue = [NSNumber numberWithFloat:self.animationView.toCircleRadian];
        circle.springSpeed = 0.2f;
        circle.springBounciness = 2.f;
        
        //添加动画效果
        [self.animationView.layer pop_addAnimation:circle forKey:nil];
        
    }
}

- (void)additionalParameter:(NSDictionary *)param{
    
}

@end
