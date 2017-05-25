//
//  Item.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/9.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) id object;

@property(nonatomic, assign) NSInteger index;
@property(nonatomic, strong, readonly) NSMutableAttributedString *nameString;

+ (instancetype)itemWithName:(NSString *)name object:(id)object;
- (void)createAttributedString;

@end
