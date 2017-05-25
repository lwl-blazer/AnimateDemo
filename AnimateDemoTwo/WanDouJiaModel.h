//
//  WanDouJiaModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DailyListModel.h"

@interface WanDouJiaModel : NSObject

@property(nonatomic, strong) NSString *nextPageUrl;
@property(nonatomic, strong) NSNumber *nextPublishTime;
@property(nonatomic, strong) NSMutableArray <DailyListModel *> *dailyList;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
