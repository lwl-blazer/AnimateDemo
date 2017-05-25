//
//  NSMutableAttributedString+StringAttribute.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringAttributeProtocol.h"

@interface NSMutableAttributedString (StringAttribute)

/*
 * 添加富文本对象
 * stringAttribute 实现了StringAttributeProtocol协议的对象
 */

- (void)addStringAttribute:(id <StringAttributeProtocol>)stringAttribute;

/*
 * 消除指定的富文本对象
 * stringAttribute 实现了StringAttributeProtocol协议的对象
 */
- (void)removeStringAttribute:(id<StringAttributeProtocol>)stringAttribute;

@end
