//
//  NSString+StringAttribute.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringAttributeProtocol.h"

@interface NSString (StringAttribute)

/*
 * 创建可变富文本（可以设置富文本局部的值，协议对象的range值有效）
 * attributes 所有实现了StringAttributeProtocol协议的对象（协议中的对象需要设置range值)
 */
- (NSMutableAttributedString *)mutableAttributedStringWithStringAttributes:(NSArray *)attributes;

/*
 * 创建不可变富文本(所有的设置都是全局设置，协议对象的range值无效)
 * attributes 所有实现了StringAttributeProtocol协议的对象，（协议中的对象不需要设置range值)
 */
- (NSAttributedString *)attributeStringWithStirngAttributes:(NSArray *)attributes;

@end
