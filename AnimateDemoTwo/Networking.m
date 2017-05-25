//
//  Networking.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "Networking.h"

@interface Networking ()

/*
 * AFHTTPSessionManager(封装了常用的HTTP方法)  NSURLSession
      GET
      POST
      UIKit+AFNetworking分类
      NSProgress:利用KVO
   是AFN中最重要的对象之一
   封装了HTTP请求的常见处理
   GEP/POST请求
   解析服务器的响应数据
 
 * 重要的参数：
   requestSerializer  请求BODY的类型:   
        AFHTTPRequestSerializer(二进制格式)  
        AFJSONRequestSerializer(JSON)
        AFPropertyListRequestSerializer(PList是一种特殊的XML，解析起来相对容易)
    
    responseSerializer 返回格式
        AFHTTPResponseSerializer
        AFJSONResponseSerializer
        AFXMLParserResponseSerializer XML只能返回XMLParser还需要自己通过代理方法解析
    其中responseSerializer有一个acceptableContentTypes(content-type)的参数,如果报content-Type:text/plain;charset=utf-8的错误原因如下：
     AFNetworing默认支持了一些格式以JSON为例：application/json, text/json, text/javascript 如果有特殊的conte-type需要重新设置
     self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
     self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
 
   请求的头部信息
   [self.session.requestSerializer setValue:value forHTTPHeaderField:headField];
 
 */
@property(nonatomic, strong) AFHTTPSessionManager *session;
@property(nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation Networking

- (void)setup{
    [super setup];
    self.session = [AFHTTPSessionManager manager];
}

- (void)startRequest{
    NSParameterAssert(self.urlString);
    NSParameterAssert(self.requestParameterSerializer);
    NSParameterAssert(self.responseDataSerializer);
    
    [self resetData];
    [self accessRequestSerializer];
    [self accessResponseSerializer];
    [self accessHeaderField];
    [self accessTimeoutInterval];
    
    //请求的方式走不同的方法
    if ([self.method isKindOfClass:[GetMethod class]]) {
        [self accessGetRequest];
    }else if ([self.method isKindOfClass:[PostMethod class]]){
        [self accessPostRequest];
    }else if ([self.method isKindOfClass:[UploadMethod class]]){
        [self accessUploadRequest];
    }
    
    /*
     * NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/search?id=1"];
     [url scheme]  协议HTTP
     [url host] 域名 www.baidu.com
     [url absoluteString] 完整的url字符串 @"http://www.baidu.com/search?id=1"
     [url relativtPath] 相对路径 search
     [url port] 端口 8080
     [url path] 路径 search
     [url pathComponents] //search
     [url query] 参数 id=1
     */
    [self safetySetKey:@"absoluteString" object:self.dataTask.currentRequest.URL.absoluteString];
    [self safetySetKey:@"host" object:self.dataTask.currentRequest.URL.host];
    [self safetySetKey:@"query" object:self.dataTask.currentRequest.URL.query];
    [self safetySetKey:@"scheme" object:self.dataTask.currentRequest.URL.scheme];
    [self safetySetKey:@"timeoutInterval" object:@(self.dataTask.currentRequest.timeoutInterval)];
    [self safetySetKey:@"allHTTPHeaderFields" object:self.dataTask.currentRequest.allHTTPHeaderFields];
    [self safetySetKey:@"acceptableContentTypes" object:self.session.responseSerializer.acceptableContentTypes];
    [self safetySetKey:@"parameter" object:self.requestParameter];
}

- (void)safetySetKey:(NSString *)key object:(id)object{
    if (object) {
        [self.networkingInformation setObject:object forKey:key];  //请求的信息
    }
}

- (void)cancelRequest{
    /*
     * [dataTask resume];  启动task
     * [dataTask cancel];  其它方法，如取消任务，暂停任务
     * [dataTask suspend]; 暂停任务
     *
     *
     * invalidateAndCancel
     * session的作用域是在一个会话期间，多个用户访问服务器，就会有多个session,
     现在我们假设有三个用户A,B,C, 他们访问服务器，分别创建了三个Session,记为S1,S2,S3.
     session.invalidate() 是某一个用户调用的，比如说S1这个用户，调用这个方法，那么只有S1用户的session被删除，其他用户的session，跟S1没关系
     它实际上调用的是session对象中的destroy方法，也就是说你下次再要使用session，得再重新创建，简单的说就是没了，而不是值为null
     还有一个用户，访问同一个服务器，关闭浏览器，默认情况下清除所有的session,实际上清除的只是自己的
     另外，有一些情况下，登出并不一定是调用session.invalidate(),有时候，只是把绑定在session中某些数据给清空而已
     session.invalidate()是不能随便调用的，一旦调用，就是所有的数据都会丢失
     *
     */
    [self.dataTask cancel];
}

//重置数据
- (void)resetData{
    self.originalResponseData = nil;
    self.serializerResponseData = nil;
}

//处理请求body类型
- (void)accessRequestSerializer{
    if ([self.requestBodyType isKindOfClass:[HttpBodyType class]]) {
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if ([self.requestBodyType isKindOfClass:[JsonBodyType class]]){
        self.session.requestSerializer = [AFJSONRequestSerializer serializer];
    }else if ([self.requestBodyType isKindOfClass:[PlistBodyType class]]){
        self.session.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }else{
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
}

//处理回复data类型
- (void)accessResponseSerializer{
    if ([self.dataType isKindOfClass:[HttpDataType class]]) {
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else if ([self.dataType isKindOfClass:[JsonDataType class]]){
        self.session.responseSerializer = [AFJSONResponseSerializer serializer];
    }else{
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    self.session.responseSerializer.acceptableContentTypes = [self.session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
}

//处理请注头部信息
- (void)accessHeaderField{
    if (self.httpHeaderFiledsWithValues) {
        NSArray *allKeys = self.httpHeaderFiledsWithValues.allKeys;
        for (NSString *headField in allKeys) {
            NSString *value = [self.httpHeaderFiledsWithValues valueForKey:headField];
            [self.session.requestSerializer setValue:value forHTTPHeaderField:headField];
        }
    }
}

//设置超时时间
- (void)accessTimeoutInterval{
    if (self.timeoutInterval && self.timeoutInterval.floatValue) {
        [self.session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.session.requestSerializer.timeoutInterval = self.timeoutInterval.floatValue;
        [self.session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
}

- (void)accessGetRequest{
    self.isRuning = YES;
    __weak Networking *weakSelf = self;
    
    self.dataTask = [self.session GET:self.urlString
                           parameters:[self.requestParameterSerializer serializeRequestParameter:self.requestParameter]
                             progress:nil
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  weakSelf.isRuning = NO;
                                  weakSelf.originalResponseData = responseObject;
                                  //调用这个方法的时候就是把数据通过WanDouJiaDataSerializer传到Model里面去了
                                  weakSelf.serializerResponseData = [weakSelf.responseDataSerializer serializeResponseData:responseObject];
                                  if (weakSelf.delegate &&[weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                      [weakSelf.delegate requestSucess:weakSelf data:weakSelf.serializerResponseData];
                                  }
                              }
                              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  weakSelf.isRuning = NO;
                                  if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                      [weakSelf.delegate requestFailed:weakSelf error:error];
        }
    }];
}

- (void)accessPostRequest{
    self.isRuning = YES;
    __weak Networking *weakSelf = self;
    self.dataTask = [self.session POST:self.urlString
                            parameters:[self.requestParameterSerializer serializeRequestParameter:self.requestParameter]
                              progress:nil
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   weakSelf.isRuning = NO;
                                   weakSelf.originalResponseData = responseObject;
                                   weakSelf.serializerResponseData = [weakSelf.requestParameterSerializer serializeRequestParameter:responseObject];
                                   if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                       [weakSelf.delegate requestSucess:weakSelf data:weakSelf.serializerResponseData];
                                   }
    }
                               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   weakSelf.isRuning = NO;
                                   if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                       [weakSelf.delegate requestFailed:weakSelf error:error];
                                   }
    }];
}

- (void)accessUploadRequest{
    self.isRuning = YES;
    __weak Networking *weakSelf = self;
    
    self.dataTask = [self.session POST:self.urlString
                            parameters:[self.requestParameterSerializer serializeRequestParameter:self.requestParameter]
             constructingBodyWithBlock:weakSelf.constructingBodyBlock
                              progress:weakSelf.uploadProgressBlock
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   weakSelf.isRuning = NO;
                                   weakSelf.originalResponseData = responseObject;
                                   weakSelf.serializerResponseData = [weakSelf.serializerResponseData serializeResponseData:responseObject];
                                   
                                   if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSucess:data:)]) {
                                       [weakSelf.delegate requestSucess:weakSelf data:weakSelf.serializerResponseData];
                                   }
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   weakSelf.isRuning = NO;
                                   if (weakSelf.delegate &&[weakSelf.delegate respondsToSelector:@selector(requestFailed:error:)]) {
                                       [weakSelf.delegate requestFailed:weakSelf error:error];
                                   }
                               }];
}


#pragma mark -便利构造器

+(id)getMethodNetworkingWithUrlString:(NSString *)urlString
                     requestParameter:(id)requestParameter
                      requestBodyType:(RequestBodyType *)requestBodyType
                     responseDataType:(ResponeDataType *)responseDataType{
    Networking *networking = [[Networking alloc] init];
    networking.urlString = urlString;
    networking.requestParameter = requestParameter;
    requestBodyType ? networking.requestBodyType = requestBodyType : 0;
    responseDataType ? networking.dataType = responseDataType : 0;
    return networking;
}

+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString requestParameter:(id)requestParameter requestBodyType:(RequestBodyType *)requestBodyType responseDataType:(ResponeDataType *)responseDataType{
    Networking *networking = [[Networking alloc] init];
    networking.urlString = urlString;
    networking.requestParameter = requestParameter;
    networking.method = [PostMethod type];
    requestBodyType ? networking.requestBodyType = requestBodyType : 0;
    responseDataType ? networking.dataType = responseDataType : 0;
    return networking;
}

+ (id)uploadMethodNetworkingWithUrlString:(NSString *)urlString requestParameter:(id)parameters requestBodyType:(RequestBodyType *)requestBodyType responseDataType:(ResponeDataType *)responseDataType constructingBodyWithBlock:(ConstructingBodyBlock)constructingBodyBlock progress:(UploadProgressBlock)uploadProgressBlock{
    Networking *networking = [[Networking alloc] init];
    networking.urlString = urlString;
    networking.requestParameter = parameters;
    networking.method = [UploadMethod type];
    networking.constructingBodyBlock = constructingBodyBlock;
    networking.uploadProgressBlock = uploadProgressBlock;
    requestBodyType ? networking.requestBodyType = requestBodyType : 0;
    responseDataType ? networking.dataType = responseDataType : 0;
    return networking;
}

@end
