//
//  NSMutableAttributedString+StringAttribute.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "NSMutableAttributedString+StringAttribute.h"

@implementation NSMutableAttributedString (StringAttribute)

//通过协议得到值
- (void)addStringAttribute:(id<StringAttributeProtocol>)stringAttribute{
    [self addAttribute:[stringAttribute attributeName]
                 value:[stringAttribute attributeValue]
                 range:[stringAttribute effectiveStringRange]];
}

- (void)removeStringAttribute:(id<StringAttributeProtocol>)stringAttribute{
    [self removeAttribute:[stringAttribute attributeName]
                    range:[stringAttribute effectiveStringRange]];
}

@end
