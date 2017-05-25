//
//  ResponeDataType.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponeDataType : NSObject

+ (instancetype)type;

@end


@interface JsonDataType : ResponeDataType

@end

@interface HttpDataType : ResponeDataType

@end