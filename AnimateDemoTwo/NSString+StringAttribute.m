 //
//  NSString+StringAttribute.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "NSString+StringAttribute.h"

@implementation NSString (StringAttribute)

- (NSMutableAttributedString *)mutableAttributedStringWithStringAttributes:(NSArray *)attributes{
    NSMutableAttributedString *attributedString = nil;
    if (self) { //这个self是指，当前所指向的，这个  一般是string
        attributedString  = [[NSMutableAttributedString alloc] initWithString:self];
        for (id<StringAttributeProtocol>attribute in attributes) {
            [attributedString addAttribute:[attribute attributeName] value:[attribute attributeValue] range:[attribute effectiveStringRange]];
        }
    }
    return attributedString;
}

- (NSAttributedString *)attributeStringWithStirngAttributes:(NSArray *)attributes{
    NSAttributedString *attributeString = nil;
    if (self) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        for (id<StringAttributeProtocol>attribute in attributes) {
            [attributesDictionary setObject:[attribute attributeValue] forKey:[attribute attributeName]];
        }
        attributeString = [[NSAttributedString alloc] initWithString:self attributes:attributesDictionary];
    }
    return attributeString;
}


@end
