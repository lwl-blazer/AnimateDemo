//
//  CustomViewController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.width = [UIScreen mainScreen].bounds.size.width;
    self.height = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor = [UIColor whiteColor];
}

//PopGesture的手势作用的问题
- (void)useInteractivePopGestureRecognizer{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)popViewControllerAnimated:(BOOL)animated{
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated{
    [self.navigationController popToRootViewControllerAnimated:animated];
}


#pragma mark setter & getter
//设置PopGesture的手势有没有作用
@synthesize enableInteractivePopGestureRecognizer = _enableInteractivePopGestureRecognizer;

- (void)setEnableInteractivePopGestureRecognizer:(BOOL)enableInteractivePopGestureRecognizer{
    _enableInteractivePopGestureRecognizer = enableInteractivePopGestureRecognizer;
    self.navigationController.interactivePopGestureRecognizer.enabled = enableInteractivePopGestureRecognizer;
}

- (BOOL)enableInteractivePopGestureRecognizer{
    return _enableInteractivePopGestureRecognizer;
}



@end
