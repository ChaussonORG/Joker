//
//  JKTopicsFilteredListController.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicsFilteredListController.h"
#import "JKTopicListCell.h"
#import "CHLoginModalController.h"
@interface JKTopicsFilteredListController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic , strong) UITableView *mainTableView;

@property (nonatomic , strong) UIImageView *spareView;

@property (nonatomic , strong) UIButton *createTopicBtn;
@end

@implementation JKTopicsFilteredListController

- (instancetype)initWithTopicSort:(JKTopicSort)sort;
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKTopicsFilteredListVM alloc]initWithTopicSort:sort];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel requestData];
    
    [self setupSubview];
    
    [self binding];
    // Do any additional setup after loading the view.
}


- (void)setupSubview{
    
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.scrollsToTop = YES;
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewHeaderData)];
    [self.view addSubview:self.mainTableView];
    @weakify(self)
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel requestMoreData];
    }];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    self.mainTableView.mj_footer = footer;
    
    
    self.createTopicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.createTopicBtn.frame = CGRectMake((self.view.frame.size.width - 100)/2, ScreenHeight - 15 - 40 - 64, 100, 40);
    //    [self.createTopicBtn setImage:[[UIImage imageNamed:@"dipinglun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:(UIControlStateNormal)];
    
    [self.createTopicBtn setImage:[UIImage imageNamed:@"xiehuati"] forState:UIControlStateNormal];
    [self.createTopicBtn addTarget:self action:@selector(clickCreateTopicBtn) forControlEvents:(UIControlEventTouchUpInside)];
    self.createTopicBtn.layer.masksToBounds = YES;
    self.createTopicBtn.layer.cornerRadius = 20;
    [self.view addSubview:self.createTopicBtn];

    
}

- (void)requestNewHeaderData{
    
    [self.viewModel requestData];
}

- (void)binding{
    
    
    @weakify(self)
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(id x) {
        @strongify(self)
        
        [self.mainTableView reloadData];
        
        if (self.viewModel.cellViewModels.count > 0) {
            
            self.spareView.hidden = YES;
        }
        else{
            
            self.spareView.hidden = NO;
        }
        [self.mainTableView.mj_header endRefreshing];
        
        if (self.viewModel.isFinishRequestMoreData) {
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.mainTableView.mj_footer endRefreshing];
        }
        
        
    }];
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
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.viewModel.cellViewModels[indexPath.row].cellHeight;
     
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clickCreateTopicBtn{
    
    [self.viewModel checkLogin];
    
    if (self.viewModel.isLogined) {
        [self.viewModel createTopic];
    }
    else{
        [self login];
    }
    
}
- (void)login
{
    CHLoginModalController *vc = [[CHLoginModalController alloc] init];
    vc.delegate = self;
    [[ASNavigator shareModalCenter].fetchCurrentViewController presentViewController:vc animated:YES completion:nil];
}
- (void)ch_willCompletionWithSuccess:(NSDictionary *)info
{
    [[JKUserManager sharedData] saveUserWithInfo:info];
    
 
    
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
