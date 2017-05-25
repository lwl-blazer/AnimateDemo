//
//  VideoListModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConsumptionModel.h"
#import "ProviderModel.h"
#import "PlayInfoModel.h"


@interface VideoListModel : NSObject

@property(nonatomic, strong) NSNumber *releaseTime;
@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSNumber *duration;
@property(nonatomic, strong) NSNumber *idx;

@property(nonatomic, strong) NSString *rawWebUrl;
@property(nonatomic, strong) NSString *webUrlForWeibo;
@property(nonatomic, strong) NSString *coverForFeed;
@property(nonatomic, strong) NSString *category;

@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSString *coverForDetail;
@property(nonatomic, strong) NSNumber *date;
@property(nonatomic, strong) NSString *playUrl;

@property(nonatomic, strong) NSString *coverBlurred;

@property(nonatomic, strong) ConsumptionModel *consumption;
@property(nonatomic, strong) ProviderModel *provider;
@property(nonatomic, strong) NSMutableArray <PlayInfoModel *>*playInfo;




- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
