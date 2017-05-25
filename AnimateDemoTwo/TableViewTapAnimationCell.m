//
//  TableViewTapAnimationCell.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/11.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "TableViewTapAnimationCell.h"
#import "UIFont+Fonts.h"
#import "TapAnimationModel.h"
#import "UIView+SetRect.h"

typedef enum:  NSUInteger{
    kNormalState,
    kSelectedState,
}ETableViewTapAnimationCellState;


@interface TableViewTapAnimationCell ()

@property(nonatomic, strong) UILabel *name;
@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UIView *rectView;   //最右边的小方框

@end

@implementation TableViewTapAnimationCell

- (void)setupCell{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    //最右边的小方框
    _rectView = [[UIView alloc] initWithFrame:CGRectMake(width - 60, 23, 35, 35)];
    _rectView.layer.borderWidth = 1.f;
    _rectView.layer.borderColor = [UIColor grayColor].CGColor;
    [self addSubview:_rectView];
    
    //小飞机图片
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(width - 62, 20, 40, 40)];
    _iconView.image = [UIImage imageNamed:@"plane"];
    _iconView.alpha = 0.f;    //就是用alpha值来表示动画的
    [self addSubview:_iconView];
    
    //文字
    _name = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 300, 60)];
    _name.font = [UIFont AvenirWithFontSize:20.0f];
    _name.textColor = [UIColor grayColor];
    [self addSubview:_name];
    
    //下划线
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(30, 70, 0, 2)];
    _lineView.alpha = 0.f; //也是用alpha值和改变长度来表示动画的
    _lineView.backgroundColor = [UIColor redColor];
    [self addSubview:_lineView];
}

//加载内容就执行动画
- (void)loadContent{
    TapAnimationModel *model = self.dataAdapter.data;
    self.name.text = model.name;
    model.selected ? (model.selected = NO, [self changToState:kSelectedState animated:YES]) : (model.selected = YES, [self changToState:kNormalState animated:YES]);   //取反
}


- (void)selectedEvent{
    [self showSelectedAnimation];
    TapAnimationModel *model = self.dataAdapter.data;
    model.selected ? (model.selected = NO, [self changToState:kNormalState animated:YES]) : (model.selected = YES, [self changToState:kSelectedState animated:YES]);
}

#pragma mark - Animate
- (void)changToState:(ETableViewTapAnimationCellState)state animated:(BOOL)animate{
    if (state == kNormalState) {
        [UIView animateWithDuration:animate? 0.5 : 0
                              delay:0.f
             usingSpringWithDamping:7
              initialSpringVelocity:4
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //CGAffineTransformMake(a,b,c,d,tx,ty) ad缩放 bc旋转 txty是位移
                             animate ? [_iconView setTransform:CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0)]:0;
                             _iconView.alpha = 0.f;
                             _lineView.alpha = 0.f;
                             _lineView.frame = CGRectMake(30, 70, 0, 2);
                             _name.frame = CGRectMake(30, 10, 300, 60);
                             
                             _rectView.layer.borderColor = [UIColor grayColor].CGColor;
                             _rectView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                             _rectView.layer.cornerRadius = 0;
        } completion:nil];
    }else if (kSelectedState) {
        animate ?[_iconView setTransform:CGAffineTransformMake(2, 0, 0, 2, 0, 0)] : 0; //为了有一个从大到小的效果，先放大，然后再正常
        [UIView animateWithDuration:animate ? 0.5 : 0
                              delay:0
             usingSpringWithDamping:7
              initialSpringVelocity:4
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _iconView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
                             _iconView.alpha = 1.0f;
                             _lineView.alpha = 1.0f;
                             _lineView.frame = CGRectMake(30, 70, 200, 2);
                             _name.frame = CGRectMake(30 + 50, 10, 300, 60);
                             
                             _rectView.layer.borderColor = [UIColor redColor].CGColor;
                             _rectView.transform = CGAffineTransformMake(0.8, 0, 0, 0.8, 0, 0);
                             _rectView.layer.cornerRadius = 4.0f;
        } completion:nil];
    }
}

//显示背景颜色，而且背景色等执行完以后就消失
- (void)showSelectedAnimation{
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 80)];
    tmpView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.20f];
    tmpView.alpha = 0.f;
    [self addSubview:tmpView];
    
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        tmpView.alpha = 0.8f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.20 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            tmpView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [tmpView removeFromSuperview];
        }];
    }];
}


@end
