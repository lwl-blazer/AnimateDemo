//
//  HeaderViewTapAnimateController.m
//  AnimateDemoTwo
//
//  Created by blazer on 16/10/25.
//  Copyright © 2016年 blazer. All rights reserved.
//

#import "HeaderViewTapAnimateController.h"
#import "ClassModel.h"
#import "StudentInfoCell.h"
#import "ClassHeaderView.h"
#import "GCD.h"

static NSString *infoCellFlag = @"BaseTableViewCell";
static NSString *infoHeadFlag = @"ClassHeaderView";


@interface HeaderViewTapAnimateController ()<UITableViewDelegate, UITableViewDataSource, CustomHeaderFooterViewDelegate>

@property(nonatomic, strong) NSMutableArray *classModels;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, assign) BOOL sectionFirstLoad;
@property(nonatomic, weak) ClassHeaderView *tmpHeadView;

@end

@implementation HeaderViewTapAnimateController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup{
    [super setup];
    
    [self createDatas];
    [self createTableView];
    [self firstLoadDataAnimation];
}

#pragma mark - 数据源相关
- (void)createDatas{
    NSArray *datas = @[@{@"className" : @"Aitna",
                         @"students"  : @[@{@"name" : @"Y.X.M.",   @"age" : @(27)},
                                          @{@"name" : @"Leif",     @"age" : @(12)},
                                          @{@"name" : @"Lennon",   @"age" : @(23)},
                                          @{@"name" : @"Lambert",  @"age" : @(19)},
                                          @{@"name" : @"Jerome",   @"age" : @(19)},
                                          @{@"name" : @"Isidore",  @"age" : @(19)}]},
                       @{@"className" : @"Melete",
                         @"students"  : @[@{@"name" : @"Merle",    @"age" : @(34)},
                                          @{@"name" : @"Paddy",    @"age" : @(31)},
                                          @{@"name" : @"Perry",    @"age" : @(10)},
                                          @{@"name" : @"Philip",   @"age" : @(39)}]},
                       @{@"className" : @"Aoede",
                         @"students"  : @[@{@"name" : @"Verne",    @"age" : @(34)},
                                          @{@"name" : @"Vincent",  @"age" : @(78)},
                                          @{@"name" : @"Walter",   @"age" : @(43)},
                                          @{@"name" : @"Zachary",  @"age" : @(21)}]},
                       @{@"className" : @"Dione",
                         @"students"  : @[@{@"name" : @"Timothy",  @"age" : @(98)},
                                          @{@"name" : @"Roderick", @"age" : @(21)},
                                          @{@"name" : @"Quentin",  @"age" : @(7)},
                                          @{@"name" : @"Paddy",    @"age" : @(67)}]},
                       @{@"className" : @"Adanos",
                         @"students"  : @[@{@"name" : @"Mortimer", @"age" : @(23)},
                                          @{@"name" : @"Michael",  @"age" : @(45)},
                                          @{@"name" : @"Kevin",    @"age" : @(89)},
                                          @{@"name" : @"Jeremy",   @"age" : @(23)}]},];
    
    self.classModels = [NSMutableArray array];
    
    for (int count = 0; count < datas.count; count ++) {
        ClassModel *classModel = [[ClassModel alloc] initWithDictionary:datas[count]];
        classModel.expend = NO;
        
        [self.classModels addObject:classModel];
    }
}


#pragma mark -TableView相关

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self.tableView registerClass:[StudentInfoCell class] forCellReuseIdentifier:infoCellFlag];
    [self.tableView registerClass:[ClassHeaderView class] forHeaderFooterViewReuseIdentifier:infoHeadFlag];
    [self.contentView addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ClassModel *model = _classModels[section];
    if (model.expend == YES) {
        return [model.students count];
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.sectionFirstLoad == NO) {
        return 0;
    }else{
        return [_classModels count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellFlag];
    
    ClassModel *classModel = _classModels[indexPath.section];
    StudentModel *studentModel = classModel.students[indexPath.row];
    
    cell.data = studentModel;
    cell.indexPath = indexPath;
    [cell loadContent];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ClassHeaderView *titleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:infoHeadFlag];
    titleView.delegate = self;
    titleView.data = _classModels[section];
    titleView.section = section;
    [titleView loadContent];
    if (section == 0) {
        self.tmpHeadView = titleView;
    }
    
    ClassModel *model = _classModels[section];
    if (model.expend == YES) {
        [titleView extendStateAnimated:NO];
    }else{
        [titleView normalStateAnimated:NO];
    }
    
    return titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell showSelectedAnimation];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//点击的时候走这个代理方法
- (void)customHeaderFooterView:(CustomHeaderFooterView *)customHeaderFooterView event:(id)event{
    NSInteger section = customHeaderFooterView.section;
    ClassModel *model = _classModels[section];
    
    ClassHeaderView *classHeaderView = (ClassHeaderView *)customHeaderFooterView;
    
    if (model.expend == YES) {
        
        //缩回去
        model.expend = NO;
        [classHeaderView normalStateAnimated:YES];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.students.count; i ++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }else{
        //显示出来
        model.expend = YES;
        [classHeaderView extendStateAnimated:YES];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.students.count; i ++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)firstLoadDataAnimation{
    [GCDQueue executeInMainQueue:^{
        self.sectionFirstLoad = YES;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.classModels.count)];
        [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        
        [GCDQueue executeInMainQueue:^{
            [self customHeaderFooterView:self.tmpHeadView event:nil];
        }afterDelaySecs:0.4f];
    }afterDelaySecs:0.3];
}

@end
