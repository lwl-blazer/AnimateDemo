//
//  Networking.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "AbsNetworking.h"
#import <AFNetworking/AFNetworking.h>

typedef void(^AFNetworkingConstructingBodyBlock)(id<AFMultipartFormData>formData);

@interface Networking : AbsNetworking

+ (id)uploadMethodNetworkingWithUrlString:(NSString *)urlString requestParameter:(id)parameters requestBodyType:(RequestBodyType *)requestBodyType responseDataType:(ResponeDataType *)responseDataType constructingBodyWithBlock:(ConstructingBodyBlock)constructingBodyBlock progress:(UploadProgressBlock)uploadProgressBlock;

@end
