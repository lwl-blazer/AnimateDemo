//
//  CellDataAdapter.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "CellDataAdapter.h"

@implementation CellDataAdapter

+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data cellHeight:(CGFloat)cellHeight cellType:(NSInteger)cellType{
    CellDataAdapter *adapter = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data = data;
    adapter.cellHeight = cellHeight;
    adapter.cellType = cellType;
    return adapter;
}

+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data cellHeight:(CGFloat)cellHeight cellWidth:(CGFloat)cellWidth cellType:(NSInteger)cellType{
    CellDataAdapter *adapter = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data = data;
    adapter.cellHeight = cellHeight;
    adapter.cellWidth = cellWidth;
    adapter.cellType = cellType;
    return adapter;
}

+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers data:(id)data cellType:(NSInteger)cellType{
    CellDataAdapter *adapter = [[self class] new];
    adapter.cellReuseIdentifier = cellReuseIdentifiers;
    adapter.data = data;
    adapter.cellType = cellType;
    return adapter;
}



@end
