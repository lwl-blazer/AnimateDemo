//
//  DailyListModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoListModel.h"

@interface DailyListModel : NSObject

@property(nonatomic, strong) NSNumber *date;
@property(nonatomic, strong) NSNumber *total;
@property(nonatomic, strong) NSMutableArray <VideoListModel *>*videoList;

@property(nonatomic, strong) NSString *dateString;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
