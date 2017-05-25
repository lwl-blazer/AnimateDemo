//
//  ProviderModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProviderModel : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *alias;
@property(nonatomic, strong) NSString *icon;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
