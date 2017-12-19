//
//  JKMyTopicController.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyTopicController.h"
#import "JKTopicListHeaderView.h"
#import "JKTopicListCell.h"
#import "JKCommentCreatController.h"
@interface JKMyTopicController ()<UITableViewDelegate,UITableViewDataSource,ChooseTopicDelegate,TopicCommentDelegate>
@property (nonatomic , strong) JKTopicListHeaderView *headerView;
@property (nonatomic , strong) UITableView *topicsListTableView;

@end

@implementation JKMyTopicController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[JKMyTopicVM alloc]init];
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    [self.viewModel requestData];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.title = @"我的话题";
    self.headerView = [[JKTopicListHeaderView alloc]initWithFilterTitles:self.viewModel.titlesArray selectedColor:[JKStyleConfiguration blackColor] isLine:YES];
    self.headerView.delegate = self;
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 42);
    //    self.headerView.bottomLine.hidden = YES;
    [self.view addSubview:self.headerView];
    
    
    self.topicsListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.size.height + self.headerView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49 ) style:UITableViewStylePlain];
    self.topicsListTableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    self.topicsListTableView.delegate = self;
    self.topicsListTableView.dataSource = self;
    self.topicsListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.topicsListTableView];
    self.topicsListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHeaderData)];
    @weakify(self)
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel requestMoreData];
    }];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    self.topicsListTableView.mj_footer = footer;
    
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
        
        [self.topicsListTableView reloadData];
        [self.topicsListTableView.mj_header endRefreshing];
        
        if (self.viewModel.isFinishRequestMoreData) {
            [self.topicsListTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.topicsListTableView.mj_footer endRefreshing];
        }
    }];
    
}
- (void)chooseTopicWithIndex:(NSInteger)index{
    
    if (index == 0) {
      
        self.viewModel.type = JKMyTopicCreated;
    }
    else if (index == 1) {
        
        self.viewModel.type = JKMyTopicCommented;
    }
    else{
        
        self.viewModel.type = JKMyTopicdraft;
        
    }
    
    [self.viewModel requestData];
    
    
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return self.viewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    JKTopicListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[JKTopicListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    cell.viewModel.delegate =self;
    
    
    return cell;
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     return self.viewModel.cellViewModels[indexPath.row].cellHeight;
    
}

- (void)commentTopicWithId:(NSString *)topicId title:(NSString *)title{
    
    JKCommentCreatController *vc = [[JKCommentCreatController alloc]init];
    vc.viewModel.titleStr = [NSString stringWithFormat:@"回复：%@",title];
    vc.viewModel.topicId = topicId;
    [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
    
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
