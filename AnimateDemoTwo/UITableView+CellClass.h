//
//  UITableView+CellClass.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCell;
@class CellDataAdapter;

@interface CellClassType : NSObject

@property(nonatomic, strong) NSString *classString;
@property(nonatomic, strong) NSString *reuseIdentifier;

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString reuseIdentifier:(NSString *)reuseIdentifier;

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString;

@end

//NS_INLINE 内联函数
NS_INLINE CellClassType *cellClass(NSString *classString, NSString *reuseIdentifier){
    return [CellClassType cellClassTypeWithClassString:classString reuseIdentifier:reuseIdentifier.length <= 0 ? classString : reuseIdentifier];
}


@interface UITableView (CellClass)

- (void)registerCellsClass:(NSArray <CellClassType *>*)cellClasses;

- (CustomCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter
                                                   indexPath:(NSIndexPath *)indexPath;

- (CustomCell *)dequeueAndLoadContentReusableCellFromAdapter:(CellDataAdapter *)adapter
                                                   indexPath:(NSIndexPath *)indexPath
                                                  controller:(UIViewController *)controller;



@end
