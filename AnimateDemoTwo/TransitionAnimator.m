//
//  TransitionAnimator.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "TransitionAnimator.h"

@interface TransitionAnimator ()

@property(nonatomic, weak) id<UIViewControllerContextTransitioning>transitionContext;

@property(nonatomic, weak) UIViewController *fromViewController;
@property(nonatomic, weak) UIViewController *toViewController;
@property(nonatomic, weak) UIView *containerView;

@end

@implementation TransitionAnimator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionDuration = 0.5f;
    }
    return self;
}

- (void)transitionAnimation{
    [NSException raise:@"TransitionAnimator Error."
                format:@"You should overwrite this method in subclass."];
}

- (void)completeTransition{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}


#pragma mark - Protocol UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView = [transitionContext containerView];
    self.transitionContext = transitionContext;
    [self transitionAnimation];
}

- (void)animationEnded:(BOOL)transitionCompleted{
    if (self.delegate && [self.delegate respondsToSelector:@selector(transitionAnimationEnded:)]) {
        [self.delegate transitionAnimationEnded:self];
    }
}


@end
