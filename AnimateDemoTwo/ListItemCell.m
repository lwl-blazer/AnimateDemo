//
//  ListItemCell.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "ListItemCell.h"
#import <pop/POP.h>
#import "Item.h"
#import "UIFont+Fonts.h"


@interface ListItemCell ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *subTitleLabel;

@end


@implementation ListItemCell

//因为在CustomCell的initWithStyle:reuseIdentifier:方法中执行了setupCell和buildSubView
- (void)setupCell{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//cell的rowHeight是45   在cell.contentView上加上两个label
- (void)buildSubView{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 290, 25)];
    [self.contentView addSubview:self.titleLabel];
    
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 290, 10)];
    self.subTitleLabel.font = [UIFont AvenirWithFontSize:10.f];
    self.subTitleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.subTitleLabel];
}

//加载内容
- (void)loadContent{
    //label的内容
    if (self.dataAdapter.data) {
        Item *item = self.dataAdapter.data;
        self.titleLabel.attributedText = item.nameString;
        self.subTitleLabel.text = [NSString stringWithFormat:@"%@", [item.object class]];
    }
    //背景颜色
    if (self.indexPath.row % 2) {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05f];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

//选中
- (void)selectedEvent{
    Item *item = self.data;
    UIViewController *controller = [item.object new];
    controller.title = item.name;
    [self.controller.navigationController pushViewController:controller animated:YES];
}

//Cell的动画   每次加载cell的时候都会走这个方法，
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.1f;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.titleLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }else{
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness = 20.f;
        [self.titleLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}


@end
