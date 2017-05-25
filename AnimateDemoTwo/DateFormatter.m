//
//  DateFormatter.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

+ (NSString *)dateFormatterWithInputDateString:(NSString *)dateString
                    inputDateStringFormatter:(NSString *)inputDateStringFormatter
                   outputDateStringFormatter:(NSString *)outputDateStringFormatter{
    NSParameterAssert(dateString);
    NSParameterAssert(inputDateStringFormatter);
    NSParameterAssert(outputDateStringFormatter);
    
    NSString *outputString = nil;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.dateFormat = inputDateStringFormatter;
    NSDate *date = [inputFormatter dateFromString:dateString];
    if (date) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        outputFormatter.dateFormat = outputDateStringFormatter;
        outputString = [outputFormatter stringFromDate:date];
    }
    return outputString;
}

+ (NSString *)dateFormatterWithInputDateString:(NSString *)dateString
                      inputDateStringFormatter:(NSString *)inputDateStringFormatter
                     outputDateStringFormatter:(NSString *)outputDateStringFormatter
                         configOutputFormatter:(void (^)(NSDateFormatter *))configOutputFormatterBlock{
    NSParameterAssert(dateString);
    NSParameterAssert(inputDateStringFormatter);
    NSParameterAssert(outputDateStringFormatter);
    
    NSString *outputString = nil;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.dateFormat = inputDateStringFormatter;
    
    NSDate *date = [inputFormatter dateFromString:inputDateStringFormatter];
    if (date) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        outputFormatter.dateFormat = outputDateStringFormatter;
        
        if (configOutputFormatterBlock) {
            configOutputFormatterBlock(outputFormatter);
        }
        outputString = [outputFormatter stringFromDate:date];
    }
    return outputString;
}


+ (NSDate *)dateFormatterWithInputDateString:(NSString *)dateString
                    inputDateStringFormatter:(NSString *)inputDateStringFormatter{
    NSParameterAssert(dateString);
    NSParameterAssert(inputDateStringFormatter);
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.dateFormat = inputDateStringFormatter;
    NSDate *date = [inputFormatter dateFromString:inputDateStringFormatter];
    return date;
}

+ (NSString *)dateStringFromDate:(NSDate *)date
       outputDateStringFormatter:(NSString *)outputDateStringFormatter{
    NSParameterAssert(date);
    NSParameterAssert(outputDateStringFormatter);
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    outputFormatter.dateFormat = outputDateStringFormatter;
    return [outputFormatter stringFromDate:date];
}

+ (NSString *)dateStringFromDate:(NSDate *)date
       outputDateStringFormatter:(NSString *)outputDateStringFormatter
           configOutputFormatter:(void (^)(NSDateFormatter *))configOutputFormatter{
    NSParameterAssert(date);
    NSParameterAssert(outputDateStringFormatter);
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    outputFormatter.dateFormat = outputDateStringFormatter;
    
    if (configOutputFormatter) {
        configOutputFormatter(outputFormatter);
    }
    return [outputFormatter stringFromDate:date];
}


@end
