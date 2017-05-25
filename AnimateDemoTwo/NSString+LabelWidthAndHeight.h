//
//  NSString+LabelWidthAndHeight.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/24.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (LabelWidthAndHeight)


- (CGFloat)heightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute
                          fixedWidth:(CGFloat)width;

- (CGFloat)widthWithStringAttribute:(NSDictionary <NSString *, id> *)attribute;

+ (CGFloat)oneLineOfTextHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute;


@end
