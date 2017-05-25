//
//  CustomCell.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

//这个是所有cell的基类，用于创建cell 构建cell.contentView上面的内容
#import <UIKit/UIKit.h>
#import "CellDataAdapter.h"

@class CustomCell;

@protocol CustomCellDelegate <NSObject>

@optional
- (void)customCell:(CustomCell *)cell event:(id)event;

@end

@interface CustomCell : UITableViewCell

@property(nonatomic, weak) id<CustomCellDelegate>delegate;

@property(nonatomic, weak) CellDataAdapter *dataAdapter;

@property(nonatomic, weak) id data;

@property(nonatomic, weak) NSIndexPath *indexPath;

@property(nonatomic, weak) UITableView *tableView;

@property(nonatomic, weak) UIViewController *controller;

@property(nonatomic, assign) BOOL display;


#pragma mark - Method you should overwrite

- (void)setupCell;

- (void)buildSubView;

- (void)loadContent;

+ (CGFloat)cellHeightWithData:(id)data;


#pragma mark - Useful method

- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated;

- (void)selectedEvent;


#pragma mark - Constructor method

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                                   type:(NSInteger)type;

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                              cellWidth:(CGFloat)cellWidth
                                                   type:(NSInteger)type;

+ (CellDataAdapter *)dataAdapterWithData:(id)data
                              cellHeight:(CGFloat)height
                                    type:(NSInteger)type;


+ (CellDataAdapter *)dataAdapterWithData:(id)data;

- (void)setWeakReferenceWithCellDataAdapter:(CellDataAdapter *)dataAdqpter
                                       data:(id)data
                                  indexPath:(NSIndexPath *)indexPath
                                  tableView:(UITableView *)tableView;

+ (void)registerToTableView:(UITableView *)tableView
            reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerToTableView:(UITableView *)tableView;


@end
