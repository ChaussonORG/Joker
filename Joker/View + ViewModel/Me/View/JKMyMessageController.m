//
//  JKMyMessageController.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyMessageController.h"
#import "JKMyMessageCell.h"
@interface JKMyMessageController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic , strong) UITableView *mainTableView;


@end

@implementation JKMyMessageController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[JKMyMessageVM alloc]init];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.viewModel requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.title = @"我的消息";
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHeaderData)];
    @weakify(self)
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel requestMoreData];
    }];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    self.mainTableView.mj_footer = footer;
  
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.mainTableView.estimatedRowHeight = 0;
        self.mainTableView.estimatedSectionFooterHeight = 0;
        self.mainTableView.estimatedSectionHeaderHeight = 0;
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.mainTableView];
    
    
    [self binding];
    // Do any additional setup after loading the view.
}

- (void)requestHeaderData{
    
    [self.viewModel requestData];
}
- (void)binding{
    @weakify(self);
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(id x) {
        @strongify(self);
        
        [self.mainTableView reloadData];
        
        [self.mainTableView.mj_header endRefreshing];
        
        if (self.viewModel.isFinishRequestMoreData) {
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.mainTableView.mj_footer endRefreshing];
        }
        
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellViewModels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    JKMyMessageCell *cell =  [[JKMyMessageCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //    if (cell == nil) {
    //        cell = [[JKFilmTimelineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    //    }
    
    
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.viewModel.cellViewModels[indexPath.row].cellHeight;
    
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
