//
//  JKTVTimeLineController.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTVTimeLineController.h"
#import "JKTopicListHeaderView.h"
#import "JKTVTimelineCell.h"
@interface JKTVTimeLineController ()<UITableViewDelegate,UITableViewDataSource,ChooseTopicDelegate>
@property (nonatomic , strong) JKTopicListHeaderView *headerView;

@property (nonatomic , strong) UITableView *mainTableView;

@end

@implementation JKTVTimeLineController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKTVTimeLineVM alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHeaderData)];
    //    @weakify(self)
    //    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
    //        @strongify(self)
    ////        [self.viewModel requestMoreData];
    //    }];
    //    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    //    self.mainTableView.mj_footer = footer;
    
    [self binding];
    
}
- (void)binding{
    
    
    @weakify(self);
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.type),
                                RACObserve(self, viewModel.cellViewModels)]] subscribeNext:^(id x) {
        @strongify(self);
        [self.mainTableView reloadData];
        
        [self.mainTableView.mj_header endRefreshing];
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     [self.mainTableView setContentOffset:CGPointZero animated:YES];
    
    [self.viewModel requestData];
    
   
}
- (void)requestHeaderData{
    
    [self.viewModel requestData];
    
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.viewModel.type == JKTVCurrent) {
        
        return self.viewModel.cellViewModels.count;
    }
    else{
        
        return self.viewModel.cellViewModels.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    JKTVTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[JKTVTimelineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewModel.type == JKTVCurrent) {
        
        return self.viewModel.cellViewModels[indexPath.row].cellHeight;
    }
    else{
        
        return self.viewModel.cellViewModels[indexPath.row].cellHeight;
    }
    
}

- (void)chooseTopicWithIndex:(NSInteger)index{
    
    if (index == 0) {
        
        self.viewModel.type = JKTVCurrent;
    }
    else{
        
        self.viewModel.type = JKTVFuture;
    }
    
    [self.viewModel requestData];
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
