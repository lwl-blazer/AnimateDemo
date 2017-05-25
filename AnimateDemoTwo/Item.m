//
//  Item.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "Item.h"
#import "UIFont+Fonts.h"
#import "StringAttributeHeader.h"

@interface Item ()

@property(nonatomic, strong) NSMutableAttributedString *nameString;

@end

@implementation Item

+ (instancetype)itemWithName:(NSString *)name object:(id)object{
    Item *item = [[[self class] alloc] init];
    item.name = name;
    item.object = object;
    return item;
}

//修改标题不同的颜色和字体样式
- (void)createAttributedString{
    NSString *fullString = [NSString stringWithFormat:@"%02ld.%@",(long)self.index, self.name];
    NSMutableAttributedString *richString = [[NSMutableAttributedString alloc] initWithString:fullString];
    //下面每一个大括号都执行  FontAttribute  是改变字体的  ForegoundColorAttribute 改变颜色
    {
        FontAttribute *fontAttribute = [FontAttribute new];
        fontAttribute.font = [UIFont HeitiSCWithFontSize:16.f];
        fontAttribute.effectRange = NSMakeRange(0, richString.length);
        [richString addStringAttribute:fontAttribute];
    }
    
    {
        FontAttribute *fontAttribute = [FontAttribute new];
        fontAttribute.font = [UIFont fontWithName:@"GillSans-Italic" size:16.f];
        fontAttribute.effectRange = NSMakeRange(0, 3);
        [richString addStringAttribute:fontAttribute];
    }
    
    {
        ForegroundColorAttribute *foregroundColorAttribute = [ForegroundColorAttribute new];
        foregroundColorAttribute.color = [[UIColor blackColor] colorWithAlphaComponent:0.65];
        foregroundColorAttribute.effectRange = NSMakeRange(0, richString.length);
        [richString addStringAttribute:foregroundColorAttribute];
    }
    
    {
        ForegroundColorAttribute *foregroundColorAttribute = [ForegroundColorAttribute new];
        foregroundColorAttribute.color = [[UIColor redColor] colorWithAlphaComponent:0.65f];
        foregroundColorAttribute.effectRange = NSMakeRange(0, 3);
        [richString addStringAttribute:foregroundColorAttribute];
    }
    self.nameString = richString;
}


@end
