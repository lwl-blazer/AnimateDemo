//
//  OffsetHeaderView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "OffsetHeaderView.h"
#import "UIView+SetRect.h"
#import "UIView+GlowView.h"
#import "UIFont+Fonts.h"
#import "DailyListModel.h"

@interface OffsetHeaderView ()

@property(nonatomic, strong)UILabel *theTitleLabel;

@end

@implementation OffsetHeaderView

- (void)setupHeaderFooterView{
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)buildSubview{
    self.theTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, Width - 10, 25)];
    [self addSubview:self.theTitleLabel];
    
    self.theTitleLabel.font = [UIFont HeitiSCWithFontSize:14.0f];
    self.theTitleLabel.textColor = [UIColor blackColor];
    
    CGFloat gap = 5;
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, gap, 2, 25 - gap * 2)];
    redView.backgroundColor = [UIColor redColor];
    [self addSubview:redView];
}

- (void)loadContent{
    DailyListModel *model = self.data;
    self.theTitleLabel.text = model.dateString;
}

@end
