//
//  CustomHeaderFooterView.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/13.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "CustomHeaderFooterView.h"

@implementation CustomHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupHeaderFooterView];
        [self buildSubview];
    }
    return self;
}


- (void)setHeaderFooterViewBackgroundColor:(UIColor *)color{
    self.contentView.backgroundColor = color;
}

- (void)setupHeaderFooterView{
    
}

- (void)buildSubview{
    
}

- (void)loadContent{
    
}

@end
