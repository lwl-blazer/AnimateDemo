//
//  LineBackgroundView.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineBackgroundView : UIView

@property(nonatomic, assign) CGFloat lineWitdth;
@property(nonatomic, assign) CGFloat lineGap;
@property(nonatomic, strong) UIColor *lineColor;

- (void)buildView;

+ (instancetype)createViewWithFrame:(CGRect)frame lineWidth:(CGFloat)width lineGap:(CGFloat)lineGap lineColor:(UIColor *)color;

@end
