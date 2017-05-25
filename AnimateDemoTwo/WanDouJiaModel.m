//
//  WanDouJiaModel.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "WanDouJiaModel.h"

@implementation WanDouJiaModel

/*
 * 使用KVC设置值对象时：
 * 如果当前类没有找到对象的Key值，系统会自动调用setValue:forUnderfinedKey:，该方法的默认实现是抛出一个异常，如果不想抛出异常，就重写这个方法
 * 
 * 使用KVC取值的时候
 * 如果当前类没有找到对应的Key值，系统会自动调用valueForUndefinedKey:方法，该方法默认实现抛出一个异常，
 * 
 * KVC的实现机制：
 * KVC按顺序使用如下技术：
 * 检查是否存在getter方法-<key> 或者setter方法-set<key>
 * 如果仍未找到，则调用valueForUnderfinedKey:和setValue:forUndefinedKey:方法，这些方法默认都是抛出异常，可以根据实际情况重写它们
 */
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    NSLog(@"22");
    //ignore null value
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    
    if ([key isEqualToString:@"dailyList"] && [value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        NSMutableArray *dataArr = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            DailyListModel *model = [[DailyListModel alloc] initWithDictionary:dict];
            [dataArr addObject:model];
        }
        value = dataArr;
    }
    [super setValue:value forKey:key];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{

    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        if (self = [super init]) {
            //快速赋值
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    return self;
}


@end
