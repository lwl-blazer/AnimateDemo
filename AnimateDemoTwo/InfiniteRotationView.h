//
//  InfiniteRotationView.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfiniteRotationView : UIView

@property(nonatomic, assign) NSTimeInterval speed;

@property(nonatomic, assign) BOOL clockWise;

@property(nonatomic, assign) CGFloat startAngle;

- (void)startRotateAnimation;

- (void)reset;

@end
