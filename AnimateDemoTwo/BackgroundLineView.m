//
//  BackgroundLineView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "BackgroundLineView.h"

#pragma mark -- Private class

@interface LineBackground : UIView

@property(nonatomic, assign) CGFloat lineWidth;  //线宽

@property(nonatomic, assign) CGFloat lineGap;  //间隙

@property(nonatomic, assign) CGFloat rotate;   //角度

@property(nonatomic, strong) UIColor *lineColor;

+ (LineBackground *)lineBackgroundWithLength:(CGFloat)length;

@end

#pragma mark - Private class

@implementation LineBackground

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.lineWidth = 5.f;
        self.lineGap = 3.f;
        self.rotate = 0.f;
        self.lineColor = [UIColor grayColor];
    }
    return self;
}

+ (LineBackground *)lineBackgroundWithLength:(CGFloat)length{
    LineBackground *view = [[LineBackground alloc] initWithFrame:CGRectMake(0, 0, length, length)];
    return view;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (self.bounds.size.width <= 0 || self.bounds.size.height <= 0) {
        return;
    }
    NSLog(@"33333");
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat drawLength = sqrt(width * width + height * height);   //sqrt() 开平方根
    
    CGFloat outerX = (drawLength - width) / 2.0;
    CGFloat outerY = (drawLength - height) / 2.0;
    CGFloat tmpLineWidth = _lineWidth <= 0 ? 5 : _lineWidth;
    CGFloat tmpLineGap = _lineGap <= 0 ? 3 : _lineGap;
    
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    
    /*
     * CGContextTranslateCTM(CGContextRef c, CGFloat tx, CGFloat ty); 平移坐标系统
     * 该方法相当于把原来位于(0, 0)位置的坐标原点平移到(tx,ty)点。在平移后的坐标系统上绘制图形，所有坐标点x坐标都相当于增加了tx,所有点的y坐标相当于增加了ty
     * CGContextScaleCTM(CGContextRef c, CGFloat sx, CGFloat sy); 缩放坐标系统
     * 该方法控制坐标系统水平方向上缩放sx,垂直方向上缩放sy.在缩放后的坐标系统上绘制图形时，所有的x坐标都相当于乘以sx因子，所有点的y坐标都相当于乘以sy因子
     * CGContextRoateCTM(CGContextRef c, CGFloat angle); 旋转坐标系统
     * 该方法控制坐标系统旋转angle弧度，在缩放后的坐标系统上绘制图形时，所有坐标点的x，y坐标都相当于旋转了angle弧度之后的坐标
     
     * 为了让开发者在进行坐标变换时无须计算多次坐标变换后的累加结果，Quartz 2D还提供了如下两个方法来保存，恢复绘图状态
     * CGContextSaveGState(CGContextRef c) 保存当前的绘图状态  
       需要说明的是这个方法不仅包括当前坐标系统的状态，也包括当前设置的填充风格，线条风格，阴影风格等各种绘图状态，但CGContextSaveGState()函数不会保存当前绘制的图形
     * CGContextRestoreGState(CGContextRef c) 恢复之前保存的绘图状态
     */
    CGContextTranslateCTM(context, 0.5 * drawLength, 0.5 * drawLength);
    CGContextRotateCTM(context, _rotate);
    CGContextTranslateCTM(context, -0.5 * drawLength, -0.5 *drawLength);
    /*
     * - getRed:green:blue:alpha: 返回一个拥有RCG色彩空间的对象
     * - colorWithAlphaComponent: 返回一个与当前UIColor对象有相同的色彩空间，但有不同透明度的对象
     */
    [_lineColor getRed:&red green:&green blue:&blue alpha:&alpha];
    //填充颜色
    CGContextSetRGBFillColor(context, red, green, blue, alpha);
    
    CGFloat currentX = -outerX;
    
    while (currentX < drawLength) {
        CGContextAddRect(context, CGRectMake(currentX, -outerY, tmpLineWidth, drawLength));
        currentX += tmpLineWidth + tmpLineGap;
    }
    CGContextFillPath(context);
    /*
     * 画完图后必须
       先用CGContextStrokePath来描线 即形状
       后用CGContextFillPath来填充形状内的颜色
     */
}
@end


@interface BackgroundLineView ()

@property(nonatomic, strong) LineBackground *backgroundView;

@end

@implementation BackgroundLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.backgroundView = [LineBackground lineBackgroundWithLength:0];
        [self addSubview:self.backgroundView];
        
        _lineWidth = 5.f;
        _lineGap = 3.f;
        _rotate = 0.f;
    }
    return self;
}

+ (instancetype)backgroundViewWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineGap:(CGFloat)lineGap lineColor:(UIColor *)lineColor rotate:(CGFloat)rotate{
    BackgroundLineView *lineView = [[[self class] alloc] initWithFrame:frame];
    lineView.lineWidth = lineWidth;
    lineView.lineGap = lineGap;
    lineView.lineColor = lineColor;
    lineView.rotate = rotate;
    return lineView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setupBackgroundView];
}

- (void)setupBackgroundView{
    CGFloat drawLength = sqrt(self.bounds.size.width * self.bounds.size.width + self.bounds.size.width * self.bounds.size.height);
    _backgroundView.frame = CGRectMake(0, 0, drawLength, drawLength);
    _backgroundView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [_backgroundView setNeedsDisplay];
}

- (void)setLineGap:(CGFloat)lineGap{
    _lineGap = lineGap;
    _backgroundView.lineGap = lineGap;
    [_backgroundView setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    _backgroundView.lineWidth = lineWidth;
    [_backgroundView setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _backgroundView.lineColor = lineColor;
    [_backgroundView setNeedsDisplay];
}

- (void)setRotate:(CGFloat)rotate{
    _rotate = rotate;
    _backgroundView.rotate = rotate;
    [_backgroundView setNeedsDisplay];
}


@end







