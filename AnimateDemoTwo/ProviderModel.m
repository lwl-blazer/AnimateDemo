//
//  ProviderModel.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "ProviderModel.h"

@implementation ProviderModel

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key{
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
