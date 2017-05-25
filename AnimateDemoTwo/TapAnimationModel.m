//
//  TapAnimationModel.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/11.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "TapAnimationModel.h"

@implementation TapAnimationModel

+ (instancetype)modelWithName:(NSString *)name selected:(BOOL)selected{
    TapAnimationModel *model = [[[self class] alloc] init];
    model.name = name;
    model.selected = selected;
    return model;
}


@end
