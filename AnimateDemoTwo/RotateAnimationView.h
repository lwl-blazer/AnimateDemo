//
//  RotateAnimationView.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/28.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotateAnimationViewTypeProtocol.h"

@interface RotateAnimationView : UIView

@property(nonatomic, assign) NSTimeInterval duration;

@property(nonatomic, assign) CGFloat fromCircleRadian;

@property(nonatomic, assign) CGFloat toCircleRadian;

@property(nonatomic, strong) id<RotateAnimationViewTypeProtocol>animationType;

- (void)startRotateAnimated:(BOOL)animated;

@end
