//
//  CustomHeaderFooterView.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomHeaderFooterView;

@protocol CustomHeaderFooterViewDelegate <NSObject>

@optional

- (void)customHeaderFooterView:(CustomHeaderFooterView *)customHeaderFooterView event:(id)event;

@end


@interface CustomHeaderFooterView : UITableViewHeaderFooterView

@property(nonatomic, weak) id<CustomHeaderFooterViewDelegate>delegate;

@property(nonatomic, weak) id data;

@property(nonatomic, assign) NSInteger section;

@property(nonatomic, weak) UITableView *tableView;

@property(nonatomic, weak) UIViewController *viewController;


- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color;

- (void)setupHeaderFooterView;

- (void)buildSubview;

- (void)loadContent;


@end
