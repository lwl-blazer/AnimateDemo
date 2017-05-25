//
//  UIView+RotateAnimationProtocol.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/25.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RotateAnimationProtocol)

//在初始化的时候保存transform的值
@property(nonatomic, assign) CGAffineTransform defaultTransform;

//旋转的动画时间
@property(nonatomic, assign) CGFloat rotateDuration;


@end
