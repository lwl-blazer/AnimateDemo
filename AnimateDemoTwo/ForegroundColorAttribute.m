//
//  ForegroundColorAttribute.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "ForegroundColorAttribute.h"

@implementation ForegroundColorAttribute

- (NSString *)attributeName{
    return NSForegroundColorAttributeName;
}

- (id)attributeValue{
    if (self.color) {
        return self.color;
    }
    return [UIColor blackColor];
}


@end
