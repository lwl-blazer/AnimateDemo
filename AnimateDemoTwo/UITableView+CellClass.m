//
//  UITableView+CellClass.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "UITableView+CellClass.h"
#import "CellDataAdapter.h"
#import "CustomCell.h"


@implementation UITableView (CellClass)

- (void)registerCellsClass:(NSArray<CellClassType *> *)cellClasses{
    for (int i = 0; i < cellClasses.count; i ++) {
        CellClassType *cellClass = cellClasses[i];
        [self registerClass:NSClassFromString(cellClass.classString) forCellReuseIdentifier:cellClass.reuseIdentifier];
    }
}

- (CustomCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    [cell setWeakReferenceWithCellDataAdapter:adapter data:adapter.data indexPath:indexPath tableView:self];
    [cell loadContent];
    return cell;
}

//注册Cell并给cell赋值   因为在tableView registerCellClass:的时候是注册的ListItemCell CustomeCell是父类 ListItemCell是子类
- (CustomCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller{
    //注册Cell
    CustomCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.controller = controller;
    //给cell赋值
    [cell setWeakReferenceWithCellDataAdapter:adapter data:adapter.data indexPath:indexPath tableView:self];
    //加载内容
    [cell loadContent];
    return cell;
}

@end


@implementation CellClassType

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString reuseIdentifier:(NSString *)reuseIdentifier{
    NSParameterAssert(NSClassFromString(classString));
    CellClassType *type = [[[self class] alloc] init];
    type.classString = classString;
    type.reuseIdentifier = reuseIdentifier;
    return type;
}

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString{
    NSParameterAssert(NSClassFromString(classString));
    CellClassType *type = [[[self class] alloc] init];
    type.classString = classString;
    type.reuseIdentifier = classString;
    return type;
}



@end