//
//  AbsRequestParameterSerializer.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbsRequestParameterSerializer : NSObject

//requestParameter 请求参数    return 处理后的参数
- (id)serializeRequestParameter:(id)requestParameter;


@end
