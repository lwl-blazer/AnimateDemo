//
//  UIView+GlowView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "UIView+GlowView.h"
#import <objc/runtime.h>


@interface UIView ()

@property(nonatomic, strong) CALayer *glowLayer;

@property(nonatomic, strong) dispatch_source_t dispatchSource;    //定时器

@end

@implementation UIView (GlowView)

//创建一个阴影效果
- (void)createGlowLayer{
    /*
     * [UIScreen mainScreen].scale 是分辨率    假如iPhone4 值为1.0时(分辨率:320 *480)  值为2.0时(分辨率:640*960)
     * UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale) 
       size:表示所要创建的图片的尺寸
       opaque:用来指定所生成的图片的背景是否为不透明  YES or NO
       scale:指定生成图片的缩放因子，这个缩放因子与UIImage的scale属性所指的含义是一致的。传入0则表示让图片的缩放因子根据屏幕的分辨率而变化，
    */
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    //渲染自身
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    [[self accessGlowColor] setFill];
    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
    
    self.glowLayer = [CALayer layer];
    self.glowLayer.frame = self.bounds;
    //UIGraphicsGetImageFromCurrentImageContext 返回当前context bitmap-based的image
    self.glowLayer.contents = (__bridge id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    self.glowLayer.opacity = 0.f;
    self.glowLayer.shadowOffset = CGSizeMake(0, 0);
    self.glowLayer.shadowOpacity = 10.f;
    //关闭，不然会出现内存泄露
    UIGraphicsEndImageContext();
}

- (void)insertGlowLayer{
    if (self.glowLayer) {
        [self.layer addSublayer:self.glowLayer];
    }
}

- (void)removeGlowLayer{
    if (self.glowLayer) {
        [self.glowLayer removeFromSuperlayer];
    }
}

- (void)glowToshowAnimated:(BOOL)animated{
    self.glowLayer.shadowColor = [self accessGlowColor].CGColor;
    self.glowLayer.shadowRadius = [self accessGlowRadius].floatValue;
    
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = @(0.f);
        animation.toValue = [self accessGlowOpacity];
        
        self.glowLayer.opacity = [self accessGlowOpacity].floatValue;
        animation.duration = [self accessAnimationDuration].floatValue;
        
        [self.glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
    }else{
        [self.glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.glowLayer.opacity = [self accessGlowOpacity].floatValue;
    }
}

- (void)glowToHideAnimated:(BOOL)animated{
    self.glowLayer.shadowColor = [self accessGlowColor].CGColor;
    self.glowLayer.shadowRadius = [self accessGlowRadius].floatValue;
    
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = [self accessGlowOpacity];
        animation.toValue = @(0.f);
        
        self.glowLayer.opacity = 0.f;
        animation.duration = [self accessAnimationDuration].floatValue;
        
        [self.glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
    }else{
        [self.glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.glowLayer.opacity = 0.f;
    }
}

- (void)startGlowLoop{
    //GCD定时器
    if (self.dispatchSource == nil) {
        //一次的总时间
        CGFloat seconds = [self accessAnimationDuration].floatValue * 2 + [self accessGlowDuration].floatValue + [self accessHideDuration].floatValue;
        //延迟的时间
        CGFloat delaySeconds = [self accessAnimationDuration].floatValue + [self accessGlowDuration].floatValue;
        /*
         * 一共有以下几种类型(dispatch_source_type_t)
             DISPATCH_SOURCE_TYPE_PROC,     监控进程
             DISPATCH_SOURCE_TYPE_TIMER,    定时器
             DISPATCH_SOURCE_TYPE_READ,     从描述符中读取数据
             DISPATCH_SOURCE_TYPE_WRITE,    向描述符中写入字符
             DISPATCH_SOURCE_TYPE_VNODE     监控文件系统对象
         */
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        
        __weak UIView *weakSelf = self;
        //设置定时器信息
        dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), NSEC_PER_SEC * seconds, 0);
        //定义一个事件处理器来处理事件，可以是函数或者是block对象,用dispatch_source_set_event_handler或dispatch_source_set_event_handler_f安装事件处理器。事件到达时，dispatch source会提交你的事件处理器到指定的dispatch_queue,由queue执行事件处理器
        dispatch_source_set_event_handler(self.dispatchSource, ^{
            [weakSelf glowToshowAnimated:YES];
            
            /*
             * dispatch_after(dispatch_time_t when, int64_t delta);
             * 功能：延迟一段时间把一项任务提交到队列中执行，返回之后就不能取消  常用来在主队列上延迟执行一项任务
             * when 过多久执行的时间间隔
             * queue 提交到的队列
             * block  执行的任务
             */
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delaySeconds), dispatch_get_main_queue(), ^{
                [weakSelf glowToHideAnimated:YES];
            });
        });
        //启动dispatch source   因为dispatch source源创建后处理suspend状态，所以需要启动
        dispatch_resume(self.dispatchSource);
    }
}


#pragma mark --处理数据越界的问题

- (NSNumber *)accessGlowOpacity{
    if (self.glowOpacity) {
        if (self.glowOpacity.floatValue <= 0 || self.glowOpacity.floatValue > 1) {
            return @(0.8);
        }else{
            return self.glowOpacity;
        }
    }else{
        return @(0.8);
    }
}

- (NSNumber *)accessAnimationDuration{
    if (self.glowAnimationDuration) {
        if (self.glowAnimationDuration.floatValue <= 0) {
            return @(1.f);
        }else{
            return self.glowAnimationDuration;
        }
    }else{
        return @(1.f);
    }
}

- (NSNumber *)accessGlowRadius{
    if (self.glowRadius) {
        if (self.glowRadius.floatValue <= 0) {
            return @(2.f);
        }else{
            return self.glowRadius;
        }
    }else{
        return @(2.f);
    }
}


- (UIColor *)accessGlowColor{
    if (self.glowColor) {
        return self.glowColor;
    }else{
        return [UIColor redColor];
    }
}

- (NSNumber *)accessGlowDuration{
    if (self.glowDuration) {
        if (self.glowDuration.floatValue <= 0) {
            return @(0.5f);
        }else{
            return self.glowDuration;
        }
    }else{
        return @(0.5f);
    }
}

- (NSNumber *)accessHideDuration{
    if (self.hideDuration) {
        if (self.hideDuration.floatValue < 0) {
            return @(0.5);
        }else{
            return self.hideDuration;
        }
    }else{
        return @(0.5);
    }
}

#pragma mark --runtime属性

- (void)setDispatchSource:(dispatch_source_t)dispatchSource{
    objc_setAssociatedObject(self, @selector(dispatchSource), dispatchSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)dispatchSource{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setGlowColor:(UIColor *)glowColor{
    objc_setAssociatedObject(self, @selector(glowColor), glowColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)glowColor{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowOpacity:(NSNumber *)glowOpacity{
    objc_setAssociatedObject(self, @selector(glowOpacity), glowOpacity, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)glowOpacity{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowRadius:(NSNumber *)glowRadius{
    objc_setAssociatedObject(self, @selector(glowRadius), glowRadius, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)glowRadius{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowAnimationDuration:(NSNumber *)glowAnimationDuration{
    objc_setAssociatedObject(self, @selector(glowAnimationDuration), glowAnimationDuration, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)glowAnimationDuration{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGlowDuration:(NSNumber *)glowDuration{
    objc_setAssociatedObject(self, @selector(glowDuration), glowDuration, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)glowDuration{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHideDuration:(NSNumber *)hideDuration{
    objc_setAssociatedObject(self, @selector(hideDuration), hideDuration, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)hideDuration{
    return objc_getAssociatedObject(self, _cmd);
}


NSString *const _recognizerGlowLayer = @"_recognizerGlowLayer";
- (void)setGlowLayer:(CALayer *)glowLayer{
    objc_setAssociatedObject(self, @selector(glowLayer), glowLayer, OBJC_ASSOCIATION_RETAIN);
}

- (CALayer *)glowLayer{
    return objc_getAssociatedObject(self, _cmd);
}

@end
