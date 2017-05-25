//
//  AbsNetworking.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "AbsNetworking.h"

@implementation AbsNetworking

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

//默认属性
- (void)setup{
    self.method = [GetMethod type];
    self.requestBodyType = [HttpBodyType type];
    self.dataType = [HttpDataType type];
    self.requestParameterSerializer = [AbsRequestParameterSerializer new];
    self.responseDataSerializer = [AbsResponseDataSerializer new];
    self.httpHeaderFiledsWithValues = [NSMutableDictionary dictionary];
    self.networkingInformation = [NSMutableDictionary dictionary];
    self.timeoutInterval = @(5);
}

#pragma mark -出现错误打印日志

- (void)startRequest{
    [NSException raise:@"Networking startRequest"
                format:@"You must override this method"];
}

- (void)cancelRequest{
    [NSException raise:@"Networking cancelRequest"
                format:@"You must override this method"];
}

+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString requestParameter:(id)requestParameter requestBodyType:(RequestBodyType *)requestBodyType responseDataType:(ResponeDataType *)responseDataType{
    [NSException raise:@"Networking getMethodNetworkingWithUrlString:requestDictionary:requestBodyType:responseDataType:"
                format:@"You must override this method."];
    
    return nil;
}

+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)requestParameter
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponeDataType *)responseDataType {
    
    [NSException raise:@"Networking postMethodNetworkingWithUrlString:requestDictionary:requestBodyType:responseDataType:"
                format:@"You must override this method."];
    
    return nil;
}

+ (id)uploadMethodNetworkingWithUrlString:(NSString *)urlString
                         requestParameter:(id)parameters
                          requestBodyType:(RequestBodyType *)requestBodyType
                         responseDataType:(ResponeDataType *)responseDataType
                constructingBodyWithBlock:(ConstructingBodyBlock)constructingBodyBlock
                                 progress:(UploadProgressBlock)uploadProgressBlock {
    
    [NSException raise:@"Networking uploadMethodNetworkingWithUrlString:requestParameter:requestBodyType:responseDataType:constructingBodyWithBlock:progress:"
                format:@"You must override this method."];
    
    return nil;
}



@end
