//
//  SystemTimeInformation.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/28.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemTimeInformation : NSObject

@property(nonatomic, strong) NSDateFormatter *dateFormatter;

+ (SystemTimeInformation *)sharedInstance;

- (void)setDateFormatterString:(NSString *)dateFormatterString;

- (NSDictionary *)currentTimeInformation;

@end
