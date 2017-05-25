//
//  ConsumptionModel.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "ConsumptionModel.h"

@implementation ConsumptionModel

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    [super setValue:value forKey:key];
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        if (self = [super init]) {
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    return self;
}

@end
