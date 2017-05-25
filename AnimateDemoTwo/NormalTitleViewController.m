//
//  NormalTitleViewController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "NormalTitleViewController.h"
#import "UIFont+Fonts.h"
#import "UIView+SetRect.h"

@implementation NormalTitleViewController

- (void)buildTitleView{
    [super buildTitleView];
    UILabel *headLineLabel = [UILabel new];
    headLineLabel.font = [UIFont HeitiSCWithFontSize:20.f];
    headLineLabel.textAlignment = NSTextAlignmentCenter;
    headLineLabel.textColor = [UIColor colorWithRed:0.329 green:0.329 blue:0.329 alpha:1];
    headLineLabel.text = self.title;
    [headLineLabel sizeToFit];

    headLineLabel.center = self.titleView.middlePoint;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.view.width, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self.titleView addSubview:line];
    [self.titleView addSubview:headLineLabel];
    
    UIImage *image = [UIImage imageNamed:@"backIcon"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    backButton.center = CGPointMake(20, self.titleView.middleY);
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    [backButton.imageView setContentMode:UIViewContentModeCenter];
    [self.titleView addSubview:backButton];
}

- (void)popSelf{
    [self popViewControllerAnimated:YES];
}

@end
