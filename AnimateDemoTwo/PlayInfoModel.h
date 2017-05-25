//
//  PlayInfoModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayInfoModel : NSObject

@property(nonatomic, strong) NSNumber *width;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSNumber *height;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
