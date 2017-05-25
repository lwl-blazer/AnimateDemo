//
//  AbsAlertMessageView.h
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class AbsAlertMessageView;

@protocol AlertMessageViewDelegate <NSObject>

@optional
- (void)alertView:(AbsAlertMessageView *)alertView
     clickAtIndex:(NSUInteger)index
             date:(id)data;

- (void)alertViewWillShow:(AbsAlertMessageView *)show;

- (void)alertViewDidShow:(AbsAlertMessageView *)alertView;

- (void)alertViewWillHide:(AbsAlertMessageView *)alertView;

- (void)alertViewDidHide:(AbsAlertMessageView *)alertView;

@end


@interface AbsAlertMessageView : UIView

@property(nonatomic, weak) id<AlertMessageViewDelegate>delegate;

@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *subTitle;

@property(nonatomic, strong) NSString *message;

@property(nonatomic, strong) id customeMessage;

@property(nonatomic, strong) NSArray <NSString *> *buttonsTitle;

@property(nonatomic, strong) NSArray *buttonsConfig;

@property(nonatomic, weak) UIView *contentView;

@property(nonatomic, assign) BOOL autoHide;

@property(nonatomic, assign) NSTimeInterval delayAutoHidenDuration;


- (void)show;

- (void)hide;

- (void)setView:(UIView *)view withKey:(NSString *)key;

- (UIView *)viewWithKey:(NSString *)key;


@end
