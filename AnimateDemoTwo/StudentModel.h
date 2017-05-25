//
//  StudentModel.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/25.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModel : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSNumber *age;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
