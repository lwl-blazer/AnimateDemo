//
//  CustomCell.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
        [self buildSubView];
    }
    return self;
}

- (void)setupCell{
    
}

- (void)buildSubView{
    
}

- (void)loadContent{
    
}

- (void)selectedEvent{
    
}

+ (CGFloat)cellHeightWithData:(id)data{
    return 0.f;
}

- (void)setWeakReferenceWithCellDataAdapter:(CellDataAdapter *)dataAdqpter data:(id)data indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
    _dataAdapter = dataAdqpter;
    _data = data;
    _indexPath = indexPath;
    _tableView = tableView;
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height type:(NSInteger)type{
    NSString *tmpReuseIdentifier = reuseIdentifier.length <=0 ? NSStringFromClass([self class]):reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier data:(id)data cellHeight:(CGFloat)height cellWidth:(CGFloat)cellWidth type:(NSInteger)type{
    NSString *tmpReuseIdentifier = reuseIdentifier.length <= 0 ? NSStringFromClass([self class]) :reuseIdentifier;
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:tmpReuseIdentifier data:data cellHeight:height  cellWidth:cellWidth cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data cellHeight:(CGFloat)height type:(NSInteger)type{
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:height cellType:type];
}

+ (CellDataAdapter *)dataAdapterWithData:(id)data{
    return [CellDataAdapter cellDataAdapterWithCellReuseIdentifier:nil data:data cellHeight:0 cellType:0];
}


- (void)updateWithNewCellHeight:(CGFloat)height animated:(BOOL)animated{
    if (_tableView && _dataAdapter) {
        _dataAdapter.cellHeight = height;
        [_tableView beginUpdates];
        [_tableView endUpdates];
    }else{
        _dataAdapter.cellHeight = height;
        [_tableView reloadData];
    }
}

+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier{
    [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
}

+ (void)registerToTableView:(UITableView *)tableView{
    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}



@end
