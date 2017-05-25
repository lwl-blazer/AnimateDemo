//
//  CustomNormalContentController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "CustomNormalContentController.h"

@interface CustomNormalContentController ()

@end

@implementation CustomNormalContentController

- (void)setup{
    [super setup];
    [self buildBackgroundView];
    [self buildContentView];
    [self buildTitleView];
    [self buildLoadingView];
    [self buildWindowView];
    
    self.loadingView.userInteractionEnabled = NO;
    self.windowView.userInteractionEnabled = NO;

}

- (void)buildBackgroundView{
    self.bacgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.view addSubview:self.bacgroundView];
}

- (void)buildTitleView{
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
    [self.view addSubview:self.titleView];
}

- (void)buildContentView{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height - 64)];
    [self.view addSubview:self.contentView];
}

- (void)buildLoadingView{
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height - 64)];
    [self.view addSubview:self.loadingView];
}

- (void)buildWindowView{
    self.windowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.view addSubview:self.windowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
