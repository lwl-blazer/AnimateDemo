//
//  DailyListModel.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "DailyListModel.h"

@implementation DailyListModel

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    
    //videoList
    if ([key isEqualToString:@"videoList"] && [value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            VideoListModel *model = [[VideoListModel alloc] initWithDictionary:dic];
            [arr addObject:model];
        }
        value = arr;
    }
    [super setValue:value forKey:key];
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        if (self = [super init]) {
            [self setValuesForKeysWithDictionary:dictionary];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy.MM.dd";
            
            NSString *tmpDateString = [[_date stringValue] substringToIndex:10];
            NSDate *tmpDate = [NSDate dateWithTimeIntervalSince1970:tmpDateString.integerValue];
            self.dateString = [dateFormatter stringFromDate:tmpDate];
        }
    }
    return self;
}

@end
