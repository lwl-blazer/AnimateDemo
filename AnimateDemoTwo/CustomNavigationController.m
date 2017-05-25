//
//  CustomNavigationController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 * CustomViewController 是最基本的类 下面的viewcontroller 都是继承自这个
 */
- (instancetype)initWithRootViewController:(CustomViewController *)rootViewController setNavigationBarHidden:(BOOL)hidden{
    CustomNavigationController *ncController = [[[self class] alloc] initWithRootViewController:rootViewController];
    //把有的NavigationBar都隐藏
    [ncController setNavigationBarHidden:hidden animated:NO];
    //
    [rootViewController useInteractivePopGestureRecognizer];
    return ncController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
