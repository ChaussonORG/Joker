//
//  JKFilmTimeLineController.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKFilmTimeLineController.h"
#import "JKTopicListHeaderView.h"
#import "JKFilmTimelineCell.h"
@interface JKFilmTimeLineController ()<UITableViewDelegate,UITableViewDataSource,ChooseTopicDelegate>
@property (nonatomic , strong) JKTopicListHeaderView *headerView;

@property (nonatomic , strong) UITableView *mainTableView;

@end

@implementation JKFilmTimeLineController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKFilmTimeLineVM alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
 
    
    [self.viewModel requestData];
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.headerView = [[JKTopicListHeaderView alloc]initWithFilterTitles:self.viewModel.titlesArray selectedColor:[JKStyleConfiguration redColor] isLine:YES];
    self.headerView.delegate = self;
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 42);
    self.headerView.bottomLine.hidden = YES;
    [self.view addSubview:self.headerView];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.origin.y + self.headerView.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49 -(self.headerView.frame.origin.y + self.headerView.frame.size.height) -64) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.mainTableView.estimatedRowHeight = 0;
        self.mainTableView.estimatedSectionFooterHeight = 0;
        self.mainTableView.estimatedSectionHeaderHeight = 0;
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.mainTableView.pagingEnabled = false;
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestHeaderData];
    }];//:self refreshingAction:@selector(requestHeaderData)];
    [self.mainTableView.mj_header beginRefreshing];
    @weakify(self)
    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel requestMoreData];
    }];
//    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    self.mainTableView.mj_footer = footer;
    
    [self binding];
    
    
}
- (void)requestFooterData{
    
    [self.viewModel requestMoreData];

    
}
- (void)binding{
    
    
    @weakify(self);
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(id x) {
        
        @strongify(self);
        [self.mainTableView reloadData];
        
        if (self.viewModel.queryPage == 1) {
            [self.mainTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }
        [self.mainTableView.mj_header endRefreshing];
        
        if (self.mainTableView.contentOffset.y <= 0) {
             [self.mainTableView setContentOffset:CGPointZero animated:YES];
        }
       
        if (self.viewModel.isFinishRequestMoreData) {
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.mainTableView.mj_footer endRefreshing];
        }
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.mainTableView setContentOffset:CGPointZero animated:YES];
    
    
    
//    [self.viewModel requestData];
    
    
}
- (void)requestHeaderData{
    
    [self.viewModel requestData];
    
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.viewModel.type == JKFilmCurrent) {
        
        return self.viewModel.cellViewModels.count;
    }
    else{
        
        return self.viewModel.cellViewModels.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
     
    JKFilmTimelineCell *cell =  [[JKFilmTimelineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    if (cell == nil) {
//        cell = [[JKFilmTimelineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//    }
    
    
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewModel.type == JKFilmCurrent) {
        
        return self.viewModel.cellViewModels[indexPath.row].cellHeight;
    }
    else{
        
        return self.viewModel.cellViewModels[indexPath.row].cellHeight;
    }
    
}

- (void)chooseTopicWithIndex:(NSInteger)index{
    
    if (index == 0) {
        if (self.viewModel.type ==JKFilmFuture) {
            self.viewModel.type = JKFilmCurrent;
        }
        else{
            
            return;
        }
        
    }
    else{
        if (self.viewModel.type ==JKFilmCurrent) {
            self.viewModel.type = JKFilmFuture;
        }
        else{
            
            return;
        }
    }
    
    [self.viewModel requestData];
    
    
//     [self.mainTableView setContentOffset:CGPointZero animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
