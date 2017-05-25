//
//  UIView+AnimationsListViewController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "UIView+AnimationsListViewController.h"
#import "UIFont+Fonts.h"

@implementation UIView (AnimationsListViewController)

+ (UILabel *)animationsListViewControllerNormalHeadLabel{
    //title label
    UILabel *headLineLabel = [UILabel new];
    headLineLabel.font = [UIFont AvenirWithFontSize:28.f];
    headLineLabel.textAlignment = NSTextAlignmentCenter;
    headLineLabel.textColor = [UIColor colorWithRed:0.329 green:0.329 blue:00.329 alpha:1];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Animations"];
    headLineLabel.attributedText = attributedString;
    [headLineLabel sizeToFit];
    return headLineLabel;
}
//这个label其实只显示了一个字“n“,把其它字都改成了clearColor
+ (UILabel *)animationsListViewControllerHeadLabel{
    UILabel *headLineLabel = [UILabel new];
    headLineLabel.font = [UIFont AvenirWithFontSize:28.f];
    headLineLabel.textAlignment = NSTextAlignmentCenter;
    NSString *showString = @"Animations";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:showString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, showString.length)];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.203 green:0.598 blue:0.859 alpha:1.0] range:NSMakeRange(1, 1)];
    headLineLabel.attributedText = attributedString;
    [headLineLabel sizeToFit];
    return headLineLabel;
}


@end
