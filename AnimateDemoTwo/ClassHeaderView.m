//
//  ClassHeaderView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/25.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "ClassHeaderView.h"
#import "ClassModel.h"
#import "UIView+SetRect.h"

@interface ClassHeaderView ()

@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) RotateView *rotateView;

@property(nonatomic, strong) UILabel *normarClassNameLabel;
@property(nonatomic, strong) UILabel *highClassNameLabel;

@end


@implementation ClassHeaderView

- (void)buildSubview{
    
    //白色背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    //灰色背景
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, Width, 26)];
    contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.05f];
    [self addSubview:contentView];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5)];
    line1.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [contentView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 25.5, Width, 0.5)];
    line2.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [contentView addSubview:line2];
    
    //按钮
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    [self.button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    
    //旋转的view
    self.rotateView = [[RotateView alloc] initWithFrame:CGRectMake(Width - 25, 5, 20, 20)];
    self.rotateView.rotateDuration = 0.25f;
    [self addSubview:self.rotateView];
    
    //箭头图片
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20 / 3.f, 36/3.f)];
    arrowImageView.image = [UIImage imageNamed:@"arrows_next.png"];
    arrowImageView.center = self.rotateView.middlePoint;
    [self.rotateView addSubview:arrowImageView];
    
    
    self.normarClassNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 26)];
    self.normarClassNameLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:12.f];
    [contentView addSubview:self.normarClassNameLabel];
    
    self.highClassNameLabel = [[UILabel alloc] initWithFrame:self.normarClassNameLabel.frame];
    self.highClassNameLabel.font = self.normarClassNameLabel.font;
    self.highClassNameLabel.textColor = [UIColor redColor];
    [contentView addSubview:self.highClassNameLabel];
}


- (void)buttonEvent:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customHeaderFooterView:event:)]) {
        [self.delegate customHeaderFooterView:self event:nil];
    }
}

- (void)loadContent{
    ClassModel *model = self.data;
    
    _normarClassNameLabel.text = model.className;
    _highClassNameLabel.text = model.className;
}

//正常情况下 label的位置和颜色
- (void)normalStateAnimated:(BOOL)animated{
    [self.rotateView changeToUpAnimated:animated];  //旋转箭头
    
    if (animated == YES) {
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _normarClassNameLabel.alpha = 1.0f;
            _normarClassNameLabel.frame = CGRectMake(10, 0, 100, 26);
            
            _highClassNameLabel.alpha = 0.f;
            _highClassNameLabel.frame = CGRectMake(10, 0, 100, 26);
        } completion:nil];
    }else{
        _normarClassNameLabel.alpha = 1.0f;
        _normarClassNameLabel.frame = CGRectMake(10, 0, 100, 26);
        
        _highClassNameLabel.alpha = 0.f;
        _highClassNameLabel.frame = CGRectMake(10, 0, 100, 26);
    }
}


//展开的时候 label的位置和颜色
- (void)extendStateAnimated:(BOOL)animated{
    [self.rotateView changeToRightAnimated:animated]; //旋转箭头
    
    if (animated == YES) {
        [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _normarClassNameLabel.alpha = 0.f;
            _normarClassNameLabel.frame = CGRectMake(10 + 10, 0, 100, 26);
            
            _highClassNameLabel.alpha = 1.f;
            _highClassNameLabel.frame = CGRectMake(10 + 10, 0, 100, 26);
        } completion:nil];
    }else{
        _normarClassNameLabel.alpha = 0.f;
        _normarClassNameLabel.frame = CGRectMake(10 + 10, 0, 100, 26);
        
        _highClassNameLabel.alpha = 1.f;
        _highClassNameLabel.frame = CGRectMake(10 + 10, 0, 100, 26);
    }
}


@end
