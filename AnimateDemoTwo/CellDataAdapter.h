//
//  CellDataAdapter.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//


//这个类是用来保存Cell的相关信息的，包括cell所需要的，，reuseIdentify data height width cellType
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellDataAdapter : NSObject

@property(nonatomic, strong) NSString *cellReuseIdentifier;

@property(nonatomic, strong) id data;

@property(nonatomic, assign) CGFloat cellHeight;

@property(nonatomic, assign) CGFloat cellWidth;

@property(nonatomic, assign) NSInteger cellType;

//动态改变Cell的高度  根据cellType类型
+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                       data:(id)data
                                                 cellHeight:(CGFloat)cellHeight
                                                   cellType:(NSInteger)cellType;


+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                       data:(id)data
                                                 cellHeight:(CGFloat)cellHeight
                                                  cellWidth:(CGFloat)cellWidth
                                                   cellType:(NSInteger)cellType;

+ (CellDataAdapter *)cellDataAdapterWithCellReuseIdentifier:(NSString *)cellReuseIdentifiers
                                                       data:(id)data
                                                   cellType:(NSInteger)cellType;


#pragma mark - Optional properties

@property(nonatomic, weak) UITableView *tableView;

@property(nonatomic, weak) UICollectionView *collectionView;

@property(nonatomic, weak) NSIndexPath *indexPath;


@end
