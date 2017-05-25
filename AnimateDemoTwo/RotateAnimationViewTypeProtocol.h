//
//  RotateAnimationViewTypeProtocol.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/28.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RotateAnimationViewTypeProtocol <NSObject>

- (void)setClientView:(UIView *)clientView;

- (UIView *)clientView;

- (void)startAnimation;

- (void)additionalParameter:(NSDictionary *)param;

@end
