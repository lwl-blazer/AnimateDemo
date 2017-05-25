//
//  UIView+UserInteraction.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UserInteraction)

// [Producer] Enable user interaction
- (void)enabledUserInteraction;


//[Consumer] Disable user interaction
- (void)disableUserInteraction;

@end
