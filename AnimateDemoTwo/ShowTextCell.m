//
//  ShowTextCell.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/24.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "ShowTextCell.h"
#import "UIView+SetRect.h"
#import "UIFont+Fonts.h"
#import "ShowTextModel.h"
#import "NSString+LabelWidthAndHeight.h"

@interface ShowTextCell ()

@property(nonatomic, strong) UILabel *normalLabel;
@property(nonatomic, strong) UILabel *expendLabel;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) UIView *stateView;

@end


@implementation ShowTextCell

- (void)setupCell{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubView{
    //cell的分隔线
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5f)];
    self.line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25];
    [self.contentView addSubview:self.line];
    
    //内容的左边小view
    self.stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 13, 2, 15)];
    self.stateView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.stateView];
    
    //两个label显示文字
    self.normalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Width - 20, 0)];
    self.normalLabel.numberOfLines = 3.0f;
    self.normalLabel.textColor = [UIColor grayColor];
    self.normalLabel.font = [UIFont HeitiSCWithFontSize:14.f];
    [self.contentView addSubview:self.normalLabel];
    
    self.expendLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Width - 20, 0)];
    self.expendLabel.numberOfLines = 0;
    self.expendLabel.textColor = [UIColor blackColor];
    self.expendLabel.font = [UIFont HeitiSCWithFontSize:14.f];
    [self.contentView addSubview:self.expendLabel];
}

//就是通过 beginUpdates 和endUpdates来进行刷新
- (void)changeState{
    ShowTextModel *model = self.dataAdapter.data;
    CellDataAdapter *adapter = self.dataAdapter;
    
    if (adapter.cellType == kShowTextCellNormalType) {
        adapter.cellType = kShowTextCellExpendType;
        [self updateWithNewCellHeight:model.expendStringHeight animated:YES];
        [self expendState];
    }else{
        adapter.cellType = kShowTextCellNormalType;
        [self updateWithNewCellHeight:model.normalStringHeight animated:YES];
        [self normalState];
    }
}

- (void)normalState{
    [UIView animateWithDuration:0.25f animations:^{
        self.normalLabel.alpha = 1;
        self.expendLabel.alpha = 0;
        self.stateView.backgroundColor = [UIColor grayColor];
    }];
}


- (void)expendState{
    [UIView animateWithDuration:0.25f animations:^{
        self.normalLabel.alpha = 0;
        self.expendLabel.alpha = 1;
        self.stateView.backgroundColor = [UIColor redColor];
    }];
}


- (void)loadContent{
    ShowTextModel *model = self.dataAdapter.data;
    CellDataAdapter *adapter = self.dataAdapter;
    
    if (adapter.cellType == kShowTextCellNormalType) {
        self.normalLabel.text = model.inputString;
        self.normalLabel.frame = CGRectMake(10, 10, Width - 20, 0);
        self.normalLabel.alpha = 1;
        [self.normalLabel sizeToFit];
        
        self.expendLabel.text = model.inputString;
        self.expendLabel.frame = CGRectMake(10, 10, Width - 20, 0);
        self.expendLabel.alpha = 0;
        [self.expendLabel sizeToFit];
        
        self.stateView.backgroundColor = [UIColor grayColor];
    }else{
        self.normalLabel.text = model.inputString;
        self.normalLabel.frame = CGRectMake(10, 10, Width - 20, 0);
        self.normalLabel.alpha = 0;
        [self.normalLabel sizeToFit];
        
        self.expendLabel.text = model.inputString;
        self.expendLabel.frame = CGRectMake(10, 10, Width - 20, 0);
        self.expendLabel.alpha = 1;
        [self.expendLabel sizeToFit];
        
        self.stateView.backgroundColor = [UIColor redColor];
    }
    
    if (self.indexPath.row == 0) {
        self.line.hidden = YES;
    }else{
        self.line.hidden = NO;
    }
}

- (void)selectedEvent{
    [self changeState];
}

+ (CGFloat)cellHeightWithData:(id)data{
    ShowTextModel *model = data;
    
    if (model) {
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont HeitiSCWithFontSize:14.f]};
        
        CGFloat width = Width - 20.f;
        //String总的需要的高度
        CGFloat totalStringHeight = [model.inputString heightWithStringAttribute:attribute fixedWidth:width];
        
        // 最低一行的高度
        CGFloat oneLineHeight = [NSString oneLineOfTextHeightWithStringAttribute:attribute];
        //最多显示3行
        CGFloat normalTextHeight = (totalStringHeight >= (3 * oneLineHeight)) ? 3 * oneLineHeight : totalStringHeight;
        
        //赋值
        model.expendStringHeight = 10 + totalStringHeight + 10;
        model.normalStringHeight = 10 + normalTextHeight + 10;
    }
    return 0.0f;
}






@end
