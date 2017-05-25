//
//  TableViewTapAnimationController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/11.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "TableViewTapAnimationController.h"
#import "UITableView+CellClass.h"
#import "TapAnimationModel.h"
#import "TableViewTapAnimationCell.h"

@interface TableViewTapAnimationController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray <CellDataAdapter *> *dataArray;

@end

@implementation TableViewTapAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup{
    [super setup];
    self.dataArray = [NSMutableArray array];
    NSArray *array = @[[TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO]];
    
    for (NSInteger i = 0; i < array.count; i ++) {
        [self.dataArray addObject:[TableViewTapAnimationCell dataAdapterWithCellReuseIdentifier:nil data:array[i] cellHeight:80 type:0]];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerCellsClass:@[cellClass(@"TableViewTapAnimationCell", nil)]];
    [self.contentView addSubview:self.tableView];
}

#pragma mark -UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueAndLoadContentReusableCellFromAdapter:_dataArray[indexPath.row] indexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _dataArray[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}

@end
