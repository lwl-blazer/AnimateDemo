//
//  ClassModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/25.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentModel.h"

@interface ClassModel : NSObject

@property(nonatomic, strong) NSString *className;
@property(nonatomic, strong) NSArray <StudentModel *> *students;

//额外数据
@property(nonatomic, assign) BOOL expend;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
