//
//  StringAttribute.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StringAttributeProtocol.h"

@interface StringAttribute : NSObject<StringAttributeProtocol>

//富文本设置生效的范围
@property(nonatomic, assign) NSRange effectRange;

@end
