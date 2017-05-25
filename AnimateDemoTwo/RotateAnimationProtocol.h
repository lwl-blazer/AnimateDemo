//
//  RotateAnimationProtocol.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/25.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+RotateAnimationProtocol.h"


//使用UIView+RotateAnimationProtocol.h类方法，可以使这个协议也有属性

@protocol RotateAnimationProtocol <NSObject>

- (void)changeToUpAnimated:(BOOL)animated;

- (void)changeToLeftAnimated:(BOOL)animated;

- (void)changeToRightAnimated:(BOOL)animated;

- (void)changeToDownAnimated:(BOOL)animated;


@end
