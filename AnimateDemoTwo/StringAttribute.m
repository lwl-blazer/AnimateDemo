//
//  StringAttribute.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "StringAttribute.h"

@implementation StringAttribute

//父类没有执行，返回的nil 让子类去执行
- (NSString *)attributeName{
    return nil;
}

- (id)attributeValue{
    return nil;
}

- (NSRange)effectiveStringRange{
    return self.effectRange;
}

@end
