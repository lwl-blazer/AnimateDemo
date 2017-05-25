//
//  SystemTimeInformation.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/28.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "SystemTimeInformation.h"

static SystemTimeInformation *_sharedSingleton = nil;

@interface SystemTimeInformation ()

@property(nonatomic, strong) NSString *dateFormatString;

@end

@implementation SystemTimeInformation

- (instancetype)init{
    [NSException raise:@"SystemTimeInformation"
                format:@"Cannot instantiate singleton using init method, sharedInstance must be used."];
    return nil;
}

- (id)copyWithZone:(NSZone *)zone{
    [NSException raise:@"SystemTimeInfomation"
                format:@"Cannot instantiate singleton using init method, sharedInstance must be used."];
    return nil;
}

+ (SystemTimeInformation *)sharedInstance{
    if (self != [ SystemTimeInformation class]) {
        [NSException raise:@"SystemTimeInformation"
                    format:@"Cannot use sharedInstance method from subclass"];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[SystemTimeInformation alloc] initInstance];
    });
    return _sharedSingleton;
}


- (id)initInstance{
    return [super init];
}

- (NSDictionary *)currentTimeInformation{
    if (_dateFormatter == nil) {
        if (self.dateFormatString == nil) {
            self.dateFormatString = @"HH:mm:ss";
        }
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        _dateFormatter.dateFormat = self.dateFormatString;
    } else{
        if (self.dateFormatString == nil) {
            self.dateFormatString = @"HH:mm:ss";
        }
        _dateFormatter.dateFormat = self.dateFormatString;
    }
    
    NSString *timerNow = [_dateFormatter stringFromDate:[NSDate date]];
    NSArray *timeArray = [timerNow componentsSeparatedByString:@":"];
    NSArray *formatArray = [_dateFormatter.dateFormat componentsSeparatedByString:@":"];
    
    NSMutableDictionary *timeDictionary = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < timeArray.count; i ++) {
        [timeDictionary setObject:timeArray[i] forKey:formatArray[i]];
    }
    return timeDictionary;
}

- (void)setDateFormatterString:(NSString *)dateFormatterString{
    self.dateFormatString = dateFormatterString;
}



@end
