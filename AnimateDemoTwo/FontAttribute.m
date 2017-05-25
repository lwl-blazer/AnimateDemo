//
//  FontAttribute.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "FontAttribute.h"

@implementation FontAttribute

//属性名
- (NSString *)attributeName{
    return NSFontAttributeName;
}

//属性值
- (id)attributeValue{
    if (self.font) {
        return self.font;
    }else{
        return [UIFont systemFontOfSize:12.0f];
    }
}


@end

