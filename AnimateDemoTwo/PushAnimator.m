//
//  PushAnimator.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "PushAnimator.h"
#import "AnimationsListViewController.h"
#import "UIView+SetRect.h"

@implementation PushAnimator

- (void)transitionAnimation{
    //http://stackoverflow.com/questions/25588617/ios-8-screen-blank-after-dismissing-view-controller-with-custom-presentation
    [self.containerView addSubview:self.toViewController.view];
    
    AnimationsListViewController *controller = (AnimationsListViewController *)self.fromViewController;
    self.toViewController.view.x = Width;
    
    [UIView animateWithDuration:self.transitionDuration - 0.1f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        controller.view.alpha = 0.f;
        self.toViewController.view.x = 0;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}

@end
