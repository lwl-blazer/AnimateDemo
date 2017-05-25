//
//  RequestBodyType.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestBodyType : NSObject

+ (instancetype)type;

@end


@interface HttpBodyType : RequestBodyType


@end


@interface JsonBodyType : RequestBodyType

@end

@interface PlistBodyType : RequestBodyType

@end