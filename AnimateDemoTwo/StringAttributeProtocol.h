//
//  StringAttributeProtocol.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StringAttributeProtocol <NSObject>

@required
//属性名字
- (NSString *)attributeName;
//属性对应的值
- (id)attributeValue;

#pragma mark -可选实现
//生效的范围
- (NSRange)effectiveStringRange;

@end
