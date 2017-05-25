//
//  OffsetImageCell.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "OffsetImageCell.h"
#import "UIView+SetRect.h"
#import "WanDouJiaModel.h"
#import "UIImageView+WebCache.h"
#import "LineBackgroundView.h"
#import "UIFont+Fonts.h"

@interface OffsetImageCell ()

@property(nonatomic, strong) UIImageView *pictureView;
@property(nonatomic, strong) UILabel *infoLabel;

@end

@implementation OffsetImageCell

- (void)setupCell{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor blackColor];
}

- (void)buildSubView{
    self.clipsToBounds = YES;
    //把这个图片设置的足够高，y值往上
    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(Height / 1.7 - 250)/2, Width, Height/1.7)];
    self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.pictureView];
    
    //一条黑色的View 用来放内容简介   250是cell的高度
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 250 - 30, Width, 30)];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [self addSubview:blackView];
    
    //在blackView的上面有一条一条的小斜线 lineBackgroundView和blackView是一样的frame 根据先后顺序
    LineBackgroundView *lineBackgroundView = [LineBackgroundView createViewWithFrame:blackView.frame lineWidth:4 lineGap:4 lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.1f]];
    [self addSubview:lineBackgroundView];
    
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
        lineView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:1.0f];
        
        //加在blackView的上面
        lineView.bottom = lineBackgroundView.top;
        [self addSubview:lineView];
    }
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0f];
        //加在blackView的下面
        lineView.bottom = lineBackgroundView.bottom;
        [self addSubview:lineView];
    }
    
    self.infoLabel = [[UILabel alloc] initWithFrame:lineBackgroundView.frame];
    self.infoLabel.width -= 10;
    self.infoLabel.textColor = [UIColor whiteColor];
    self.infoLabel.textAlignment = NSTextAlignmentRight;
    self.infoLabel.font = [UIFont HeitiSCWithFontSize:13.f];
    [self addSubview:self.infoLabel];
}

- (void)loadContent{
    VideoListModel *model = self.data;
    __weak OffsetImageCell *weakSelf = self;

    self.infoLabel.text = model.title;
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //SDImageCacheType当下载请求结束时，通过这个枚举来告知图片的来源
        switch (cacheType) {
            case SDImageCacheTypeNone:  //网络
                //NSLog(@"网络");
                break;
            case SDImageCacheTypeDisk: //设备硬盘
                //NSLog(@"设备硬盘");
                break;
            case SDImageCacheTypeMemory: //内存
                //NSLog(@"内存");
                break;
            default:
                break;
        }
        weakSelf.pictureView.alpha = 0;
        weakSelf.pictureView.image = image;
        
        [UIView animateWithDuration:0.35 animations:^{
            weakSelf.pictureView.alpha = 1.0;
        }];
    }];
}

- (void)cancelAnimation{
    [self.pictureView.layer removeAllAnimations];
}

//移动PictureView
- (CGFloat)cellOffset{
    //得到是self 在self.window的位置 ，只是算出了x和y值    self.window就是当前的window
    //就是说pictureView在window中的位置
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
   
    //self.superview就是承载cell的tableView
    //tableview的center
    CGPoint windowCenter = self.superview.center;
    
    
    //windowCenter.y值是永远不会变的 在滑动cell的时候centerToWindow会不停的变化
    CGFloat cellOffsetY = centerY - windowCenter.y;
    
    
    //这里不懂是什么意思
    CGFloat offsetDig = cellOffsetY / self.superview.frame.size.height * 2;
    CGFloat offset = -offsetDig * (Height / 1.7 - 250) /2;
 
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0, offset);
    self.pictureView.transform = transY;
    return offset;
}


@end
