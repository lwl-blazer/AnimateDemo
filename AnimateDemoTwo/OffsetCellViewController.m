
//
//  OffsetCellViewController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/12.
//  Copyright © 2016年 blazer. All rights reserved.
//  总体的思路就是通过不断的滚动，来动态的改变所有cell上面的图片的center.y的值
/*
 * 数据结构分析   
 * 第一层:dailyList  里包含第二层
 * 第二层:videoList  里包含第第三层
 * 第三层：有provider  playInfo  consumption
 
 * 建模：这样建模的好处就是实现了能用KVC快速赋值
 * 总的Model  WanDouJiaModel  保存 dailyList
             DailyListModel  保存videoList
             videoListModel  保存provider playInfo consumption
            ProviderModel PlayInfoModel ConsumptionModel 各自保存自己相对应的
 */

#import "OffsetCellViewController.h"
#import "Networking.h"
#import "DateFormatter.h"
#import "WanDouJiaModel.h"
#import "WanDouJiaDataSerializer.h"
#import "OffsetImageCell.h"
#import "MessageAlertView.h"
#import "OffsetHeaderView.h"
#import "LoadingView.h"
#import "GCD.h"

@interface OffsetCellViewController ()<AbsNetworkingDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) Networking *networking;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) WanDouJiaModel *rootModel;
@property(nonatomic, strong) LoadingView *showLoadingView;

@end

@implementation OffsetCellViewController

- (void)setup{
    [super setup];
    
    NSDictionary *params = @{@"num" : @"5",
                             @"date" : [DateFormatter dateStringFromDate:[NSDate date] outputDateStringFormatter:@"yyyyMMdd"],
                             @"vc" : @"67",
                             @"u" : @"011f2924aa2cf27aa5dc8066c041fe08116a9a0c",
                             @"v" : @"1.8.0",
                             @"f" : @"iphone"};
    
    self.networking = [Networking getMethodNetworkingWithUrlString:@"http://baobab.wandoujia.com/api/v1/feed"
                                                  requestParameter:params
                                                   requestBodyType:[HttpBodyType type]
                                                  responseDataType:[JsonDataType type]];
    
    self.networking.delegate = self;
    self.networking.responseDataSerializer = [WanDouJiaDataSerializer new];
    [self.networking startRequest];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 250.f;
    self.tableView.sectionHeaderHeight = 25.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.alpha = 0.f;
    
    [self.tableView registerClass:[OffsetImageCell class] forCellReuseIdentifier:@"OffsetImageCell"];
    [self.tableView registerClass:[OffsetHeaderView class] forHeaderFooterViewReuseIdentifier:@"OffsetHeaderView"];
    [self.contentView addSubview:self.tableView];
    
    self.showLoadingView = [[LoadingView alloc] init];
    self.showLoadingView.contentView = self.loadingView;
    [self.showLoadingView show];
}

#pragma mark - UITableViewDelegate

//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DailyListModel *dailyModel = self.rootModel.dailyList[section];
    return dailyModel.videoList.count;
}

//分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.rootModel.dailyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OffsetImageCell"];
    return cell;
}

//加载cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(OffsetImageCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell cellOffset];
    
    DailyListModel *dailyModel = self.rootModel.dailyList[indexPath.section];
    VideoListModel *model = dailyModel.videoList[indexPath.row];
    
    cell.data = model;
    cell.indexPath = indexPath;
    [cell loadContent];
}

//加载完cell
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(OffsetImageCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell cancelAnimation];
}

//headView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DailyListModel *dailyModel = self.rootModel.dailyList[section];
    CustomHeaderFooterView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OffsetHeaderView"];
    titleView.data = dailyModel;
    titleView.section = section;
    [titleView loadContent];
    return titleView;
}


#pragma mark - UIScrollView's Delegate
//滚动Cell
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray <OffsetImageCell *> *array = [self.tableView visibleCells];
    [array enumerateObjectsUsingBlock:^(OffsetImageCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cellOffset];
    }];
}

#pragma mark - Networking delegate

- (void)requestSucess:(AbsNetworking *)networking data:(id)data{
    [GCDQueue executeInMainQueue:^{
        [self.showLoadingView hide];
    }afterDelaySecs:0.5f];
    self.rootModel = data;   //得到一个Model
    [self.tableView reloadData];  
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.alpha = 1.0f;
    }];
}

- (void)requestFailed:(AbsNetworking *)networking error:(NSError *)error{
    [self.showLoadingView hide];
    AbsAlertMessageView *alertView = [[MessageAlertView alloc] init];
    alertView.message = @"Network error";
    alertView.contentView = self.loadingView;
    alertView.autoHide = YES;
    alertView.delayAutoHidenDuration = 2.f;
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
