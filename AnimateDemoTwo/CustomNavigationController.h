//
//  CustomNavigationController.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"

@interface CustomNavigationController : UINavigationController


- (instancetype)initWithRootViewController:(CustomViewController *)rootViewController setNavigationBarHidden:(BOOL)hidden;


@end
