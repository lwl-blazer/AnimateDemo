//
//  ConsumptionModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumptionModel : NSObject

@property(nonatomic, strong) NSNumber *shareCount;
@property(nonatomic, strong) NSNumber *collectionCount;
@property(nonatomic, strong) NSNumber *replyCount;
@property(nonatomic, strong) NSNumber *playCount;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
