//
//  LineBackgroundView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "LineBackgroundView.h"

#define RADIAN(degrees) ((M_PI *(degrees)) / 180.0f)

@interface LineBackgroundView ()

@property(nonatomic, strong) UIView *containerView;

@end

@implementation LineBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
    }
    return self;
}


- (void)buildView{
    if (self.lineGap <= 0 && self.lineWitdth <= 0) {
        return;
    }
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat containerViewWidth = (width + height) * 0.75;
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerViewWidth, containerViewWidth)];
    self.containerView.layer.borderWidth = 1.0f;
    self.containerView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);

    //创建多少条线
    NSInteger lineViewCount = containerViewWidth / (self.lineGap + self.lineWitdth);
    
    for (NSInteger count = 0; count < lineViewCount + 1; count ++) {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(count * (self.lineGap + self.lineWitdth), 0, self.lineWitdth, containerViewWidth)];
        if (self.lineColor) {
            tempView.backgroundColor = self.lineColor;
        }else{
            tempView.backgroundColor = [UIColor blackColor];
        }
        [self.containerView addSubview:tempView];
    }
    
    //进行倾斜
    self.containerView.transform = CGAffineTransformRotate(self.containerView.transform, RADIAN(45));
    [self addSubview:self.containerView];
}

+ (instancetype)createViewWithFrame:(CGRect)frame lineWidth:(CGFloat)width lineGap:(CGFloat)lineGap lineColor:(UIColor *)color{
    LineBackgroundView *bgView = [[LineBackgroundView alloc] initWithFrame:frame];
    bgView.lineWitdth = width;
    bgView.lineGap = lineGap;
    bgView.lineColor = color;
    [bgView buildView];
    return bgView;
}


@end

