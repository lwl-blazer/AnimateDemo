//
//  AbsNetworking.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestMethodType.h"
#import "RequestBodyType.h"
#import "ResponeDataType.h"
#import "AbsResponseDataSerializer.h"
#import "AbsRequestParameterSerializer.h"

@class AbsNetworking;

typedef void(^ConstructingBodyBlock)(id formData);
typedef void(^UploadProgressBlock)(NSProgress *uploadProgress);

@protocol AbsNetworkingDelegate <NSObject>

/*
 * 请求成功
 * data 数据
 */
- (void)requestSucess:(AbsNetworking *)networking data:(id)data;

/*
 * 请求失败  
 * error 错误信息
 */
- (void)requestFailed:(AbsNetworking *)networking error:(NSError *)error;

@end


@interface AbsNetworking : NSObject

#pragma mark - 设置参数

//网络请求地址(空网址直接崩溃)
@property(nonatomic, strong) NSString *urlString;

//请求方法类型(如GET POST等)
@property(nonatomic, strong) RequestMethodType *method;

//请求头部信息
@property(nonatomic, strong) NSDictionary *httpHeaderFiledsWithValues;

//请求方式类型(如HTTP请求的方式，JSON序列化请求方式，PropertyList请求方式等)
@property(nonatomic, strong) RequestBodyType *requestBodyType;

//回复数据的类型（如返回的数据为二进制data,序列化的json数据等）
@property(nonatomic, strong) ResponeDataType *dataType;


@property(nonatomic, weak) id<AbsNetworkingDelegate>delegate;

//请求用参数（字典或数组)
@property(nonatomic, strong) id requestParameter;

//请求标记
@property(nonatomic, assign) NSInteger tag;

//请求超时时间间隔（不设置的话默认为5s)
@property(nonatomic, strong) NSNumber *timeoutInterval;

//处理请求字典参数（不设置的话默认不处理）
@property(nonatomic, strong) AbsRequestParameterSerializer *requestParameterSerializer;

//处理返回的数据
@property(nonatomic, strong) AbsResponseDataSerializer *responseDataSerializer;

//构造上传数据的block
@property(nonatomic, copy) ConstructingBodyBlock constructingBodyBlock;

//检测下载进度的block
@property(nonatomic, copy) UploadProgressBlock uploadProgressBlock;

#pragma mark -运行时候的参数

//是否正在请求当中
@property(nonatomic, assign) BOOL isRuning;

//没有处理过的原始数据
@property(nonatomic, strong) id originalResponseData;

//处理过的原始数据
@property(nonatomic, strong) id serializerResponseData;

//请求的一些信息
@property(nonatomic, strong) NSMutableDictionary *networkingInformation;


//初始化设置
- (void)setup;

//开始请求
- (void)startRequest;

//取消请求
- (void)cancelRequest;

#pragma mark - 便利构造器
/*
 * GET请求
 * urlString 网址
 * requestParameter 请求参数(字典或数组)
 * responseDataType 回复数据类型
 * requestBodyType  请求包体类型
 */
+ (id)getMethodNetworkingWithUrlString:(NSString *)urlString
                      requestParameter:(id)requestParameter
                       requestBodyType:(RequestBodyType *)requestBodyType
                      responseDataType:(ResponeDataType *)responseDataType;

//post
+ (id)postMethodNetworkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)requestParameter
                        requestBodyType:(RequestBodyType *)requestBodyType
                       responseDataType:(ResponeDataType *)responseDataType;

//上传文件
+ (id)uploadMethodNetworkingWithUrlString:(NSString *)urlString
                         requestParameter:(id)parameters
                          requestBodyType:(RequestBodyType *)requestBodyType
                         responseDataType:(ResponeDataType *)responseDataType
                constructingBodyWithBlock:(ConstructingBodyBlock)constructingBodyBlock
                                 progress:(UploadProgressBlock)uploadProgressBlock;

@end
