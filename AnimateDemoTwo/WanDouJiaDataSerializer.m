//
//  WanDouJiaDataSerializer.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "WanDouJiaDataSerializer.h"
#import "WanDouJiaModel.h"

@implementation WanDouJiaDataSerializer

- (id)serializeResponseData:(id)data{
    return [[WanDouJiaModel alloc] initWithDictionary:data];
}

@end
