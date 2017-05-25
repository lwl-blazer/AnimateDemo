//
//  CustomNormalContentController.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomNormalContentController : CustomViewController

@property(nonatomic, strong) UIView *windowView;
@property(nonatomic, strong) UIView *loadingView;
@property(nonatomic, strong) UIView *titleView;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIView *bacgroundView;


- (void)buildTitleView;

- (void)buildContentView;

- (void)buildLoadingView;

- (void)buildWindowView;

- (void)buildBackgroundView;




@end
