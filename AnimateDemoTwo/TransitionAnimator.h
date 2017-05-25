//
//  TransitionAnimator.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TransitionAnimator;

@protocol TransitionAnimationDelegate <NSObject>

@optional

- (void)transitionAnimationEnded:(TransitionAnimator *)animator;

@end

@interface TransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, weak) id<TransitionAnimationDelegate> delegate;

@property(nonatomic, assign) NSTimeInterval transitionDuration;

@property(nonatomic, readonly, weak) UIViewController *fromViewController;

@property(nonatomic, readonly, weak) UIViewController *toViewController;

@property(nonatomic, readonly, weak) UIView *containerView;


- (void)completeTransition;

- (void)transitionAnimation;


@end
