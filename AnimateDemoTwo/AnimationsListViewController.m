//
//  AnimationsListViewController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/8.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "AnimationsListViewController.h"
#import "CellDataAdapter.h"
#import "PushAnimator.h"
#import "PopAnimator.h"
#import "BackgroundLineView.h"
#import "UIView+SetRect.h"
#import "UIView+AnimationsListViewController.h"
#import "UIView+GlowView.h"
#import "GCD.h"
#import "Item.h"
#import "ListItemCell.h"
#import "UITableView+CellClass.h"

#import "ButtonPressViewController.h"
#import "PopStrokenController.h"
#import "CAShapeLayerPathController.h"
#import "TransformFadeViewController.h"
#import "TableViewTapAnimationController.h"
#import "OffsetCellViewController.h"
#import "TapCellAnimationController.h"
#import "HeaderViewTapAnimateController.h"
#import "GroupImageViewController.h"
#import "ClockViewController.h"


@interface AnimationsListViewController ()<UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate>

@property(nonatomic, strong) UITableView *tablView;
@property(nonatomic, assign) BOOL tableViewLoadData;
@property(nonatomic, strong) NSMutableArray <CellDataAdapter *>*datas;

@end

@implementation AnimationsListViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup{
    [super setup];
    
    [self rootViewControllerSetUp];
    [self configureDataSource];
    [self configureTableView];
    [self configureTitleView];
}

#pragma mark --RootViewController setup.
- (void)rootViewControllerSetUp{
    self.navigationController.delegate = self;
    [self useInteractivePopGestureRecognizer];
}

#pragma mark -- Push or Pop event

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return [PushAnimator new];
    }else if (operation == UINavigationControllerOperationPop){
        return [PopAnimator new];
    }else{
        return nil;
    }
}

#pragma mark - Config TitleView
//导航栏
- (void)configureTitleView{
    //背景图片的view
    BackgroundLineView *lineView = [BackgroundLineView backgroundViewWithFrame:CGRectMake(0, 0, self.view.width, 64) lineWidth:4 lineGap:4 lineColor:[[UIColor blackColor] colorWithAlphaComponent:0.015] rotate:M_PI_4];
    
    [self.titleView addSubview:lineView];
    
    //titleLabel
    UILabel *headLinelabel = [UIView animationsListViewControllerNormalHeadLabel];
    UILabel *animationHeadLineLabel = [UIView animationsListViewControllerHeadLabel];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
    headLinelabel.center = titleView.middlePoint;
    animationHeadLineLabel.center = titleView.middlePoint;
    [titleView addSubview:headLinelabel];
    [titleView addSubview:animationHeadLineLabel];
    
    [self.titleView addSubview:titleView];
   
    //导航栏下面的那一条线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, self.width, 0.5f)];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
    [titleView addSubview:line];
    
    
    //给animationHeadLineLabel上面的字加了阴影 而且是动画形式的，一会隐藏一会显示
    animationHeadLineLabel.glowRadius = @(2.f);
    animationHeadLineLabel.glowOpacity = @(1.0);
    animationHeadLineLabel.glowColor = [[UIColor colorWithRed:0.203 green:0.598 blue:0.859 alpha:1] colorWithAlphaComponent:0.95f];
    
    animationHeadLineLabel.glowDuration = @(1.f);
    animationHeadLineLabel.hideDuration = @(1.f);
    animationHeadLineLabel.glowAnimationDuration = @(2.f);
    
    [animationHeadLineLabel createGlowLayer];
    [animationHeadLineLabel insertGlowLayer];
    
    [GCDQueue executeInMainQueue:^{
        [animationHeadLineLabel startGlowLoop];
    }afterDelaySecs:2.f];
}

//dataSource
- (void)configureDataSource{
    NSArray *array = @[[Item itemWithName:@"POP-按纽动画" object:[ButtonPressViewController class]],
                       [Item itemWithName:@"POP-Stroke动画" object:[PopStrokenController class]],
                       [Item itemWithName:@"CAShapeLayer的path动画" object:[CAShapeLayerPathController class]],
                       [Item itemWithName:@"图片碎片化mask动画" object:[TransformFadeViewController class]],
                       [Item itemWithName:@"UITableView状态切换效果" object:[TableViewTapAnimationController class]],
                       [Item itemWithName:@"Cell图片视差动画" object:[OffsetCellViewController class]],
                       [Item itemWithName:@"点击Cell动画" object:[TapCellAnimationController class]],
                       [Item itemWithName:@"点击Header的动画" object:[HeaderViewTapAnimateController class]],
                       [Item itemWithName:@"图片合并" object:[GroupImageViewController class]],
                       [Item itemWithName:@"时钟" object:[ClockViewController class]]
                       ];

    self.datas = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        Item *item = [array objectAtIndex:i];
        item.index = i + 1;
        [item createAttributedString];
        //相当于self.datas里面是加的CellDataAdapter
        [self.datas addObject:[ListItemCell dataAdapterWithCellReuseIdentifier:nil data:item cellHeight:0 type:0]];
    }
}

- (void)configureTableView{
    self.tablView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tablView.delegate = self;
    self.tablView.dataSource = self;
    self.tablView.rowHeight = 50.f;
    self.tablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tablView registerCellsClass:@[cellClass(@"ListItemCell", nil)]];
    
    [self.contentView addSubview:self.tablView];
    
    //出现TableViewCell的时候出现的延迟
    [GCDQueue executeInMainQueue:^{
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < self.datas.count; i ++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        self.tableViewLoadData = YES;
        //UITableView播入的一个动画    就是动态的添加cell
        [self.tablView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    } afterDelaySecs:0.25f];
}

#pragma mark -- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewLoadData ? self.datas.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueAndLoadContentReusableCellFromAdapter:self.datas[indexPath.row] indexPath:indexPath controller:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];  //得到cell
}

#pragma mark -- Overwrite system methods

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.enableInteractivePopGestureRecognizer = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
}


@end
