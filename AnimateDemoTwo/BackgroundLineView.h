//
//  BackgroundLineView.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
// 上面的导航栏

#import <UIKit/UIKit.h>

@interface BackgroundLineView : UIView

@property(nonatomic, strong) UIColor *lineColor;

@property(nonatomic, assign) CGFloat lineWidth;

@property(nonatomic, assign) CGFloat lineGap;

@property(nonatomic, assign) CGFloat rotate;


+ (instancetype)backgroundViewWithFrame:(CGRect)frame
                              lineWidth:(CGFloat)lineWidth
                                lineGap:(CGFloat)lineGap
                              lineColor:(UIColor *)lineColor
                                 rotate:(CGFloat)rotate;

@end
