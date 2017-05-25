//
//  RequestMethodType.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestMethodType : NSObject

+ (instancetype)type;

@end


@interface GetMethod : RequestMethodType

@end

@interface PostMethod : RequestMethodType

@end

@interface UploadMethod : RequestMethodType

@end