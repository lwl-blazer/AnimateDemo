//
//  TapAnimationModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/11.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TapAnimationModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) BOOL selected;

+ (instancetype)modelWithName:(NSString *)name selected:(BOOL)selected;

@end
