//
//  PopAnimator.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "PopAnimator.h"
#import "AnimationsListViewController.h"
#import "UIView+SetRect.h"

@implementation PopAnimator

- (void)transitionAnimation{
     // http://stackoverflow.com/questions/25513300/using-custom-ios-7-transition-with-subclassed-uinavigationcontroller-occasionall
    [self.containerView insertSubview:self.toViewController.view belowSubview:self.fromViewController.view];
    
    AnimationsListViewController *controller = (AnimationsListViewController *)self.toViewController;
    
    [UIView animateWithDuration:self.transitionDuration - 0.1f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        controller.view.alpha = 1.f;
        self.fromViewController.view.x = Width;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}


@end
