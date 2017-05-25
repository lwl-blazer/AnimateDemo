//
//  NSString+LabelWidthAndHeight.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/24.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "NSString+LabelWidthAndHeight.h"

@implementation NSString (LabelWidthAndHeight)

- (CGFloat)heightWithStringAttribute:(NSDictionary<NSString *,id> *)attribute fixedWidth:(CGFloat)width{
    NSParameterAssert(attribute);
    
    CGFloat height = 0;
    
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        height = rect.size.height;
    }
    return height;
}

- (CGFloat)widthWithStringAttribute:(NSDictionary<NSString *,id> *)attribute{
    NSParameterAssert(attribute);
    
    CGFloat width = 0;
    
    if (self.length) {
        
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        width = rect.size.width;
    }
    return width;
}

+ (CGFloat)oneLineOfTextHeightWithStringAttribute:(NSDictionary<NSString *,id> *)attribute{
    CGFloat height = 0;
    CGRect rect = [@"One" boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    height = rect.size.height;
    return height;
}



@end
