//
//  AbsResponseDataSerializer.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//  传导没有处理过的数据

#import <Foundation/Foundation.h>

@interface AbsResponseDataSerializer : NSObject

// data 处理前的参数   return 处理后的参数
- (id)serializeResponseData:(id)data;

@end
