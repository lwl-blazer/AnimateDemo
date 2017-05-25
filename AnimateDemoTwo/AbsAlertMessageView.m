//
//  AbsAlertMessageView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "AbsAlertMessageView.h"


@interface AbsAlertMessageView ()

@property(nonatomic, strong) NSMapTable *mapTable;

@end

@implementation AbsAlertMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delayAutoHidenDuration = 2.0f;
        self.autoHide = NO;
        self.mapTable = [NSMapTable strongToWeakObjectsMapTable];
    }
    return self;
}

- (void)show {
    
    [NSException raise:@"AlertViewProtocol"
                format:@"Cannot use show method from subclass."];
}

- (void)hide {
    
    [NSException raise:@"AlertViewProtocol"
                format:@"Cannot use hide method from subclass."];
}

- (void)setView:(UIView *)view withKey:(NSString *)key{
    [self.mapTable setObject:view forKey:key];
}


- (UIView *)viewWithKey:(NSString *)key{
    return [self.mapTable objectForKey:key];
}

@end
