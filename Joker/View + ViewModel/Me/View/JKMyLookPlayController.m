//
//  JKMyLookPlayController.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyLookPlayController.h"
#import "JKTopicListHeaderView.h"
#import "JKMylookPlayTableViewCell.h"
@interface JKMyLookPlayController ()<UITableViewDelegate,UITableViewDataSource,ChooseTopicDelegate>
@property (nonatomic , strong) JKTopicListHeaderView *headerView;

@property (nonatomic, strong) UIView *sliderView;

@property (nonatomic , strong) UITableView *mainTableView;
@end

@implementation JKMyLookPlayController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[JKMyLookPlayVM alloc]init];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.title = @"我的看玩";
    self.headerView = [[JKTopicListHeaderView alloc]initWithFilterTitles:self.viewModel.titlesArray selectedColor:[JKStyleConfiguration blackColor] isLine:YES];
    self.headerView.delegate = self;
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 42);
//    self.headerView.bottomLine.hidden = YES;
    [self.view addSubview:self.headerView];
    
    self.sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.origin.y + self.headerView.frame.size.height, ScreenWidth, 42)];
    [self.view addSubview:self.sliderView];
    
    float btnwidth = ScreenWidth/self.viewModel.titleArrays.count;
    for (int i = 0 ; i < self.viewModel.titleArrays.count; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 1;
        [btn setTitle:self.viewModel.titleArrays[i] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(i*btnwidth, 0, btnwidth, 42);
        [btn setTitleColor:[JKStyleConfiguration bbbbbbColor] forState:UIControlStateNormal];
        
        if (i == 0) {
            [btn setTitleColor:[JKStyleConfiguration redColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(clickTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.sliderView addSubview:btn];
        
        btn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    }
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.sliderView.frame.origin.y + self.sliderView.frame.size.height, ScreenWidth, ScreenHeight - (self.sliderView.frame.origin.y + self.sliderView.frame.size.height)) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    [self.viewModel requestData];
    [self binding];
    
    // Do any additional setup after loading the view.
}

- (void)binding{
    @weakify(self);
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(id x) {
        @strongify(self);
        
        [self.mainTableView reloadData];
        
        [self.mainTableView.mj_header endRefreshing];
        
//        if (self.viewModel.isFinishRequestMoreData) {
//            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
//        }else{
//            [self.mainTableView.mj_footer endRefreshing];
//        }
        
        
    }];
    
}
- (void)clickTypeBtn:(UIButton*)sender{
    
    for (UIButton *view in self.sliderView.subviews) {
        
        if (sender.tag == view.tag) {
            
            [view setTitleColor:[JKStyleConfiguration redColor] forState:UIControlStateNormal];
        }
        else{
            [view setTitleColor:[JKStyleConfiguration bbbbbbColor] forState:UIControlStateNormal];
            
        }
        
    }
    
    if (sender.tag == 1) {
        
        self.viewModel.workType = JKMyLookPlayFilm;
    }
    else if (sender.tag == 2) {
        
        self.viewModel.workType = JKMyLookPlayTV;
    }
    else if (sender.tag == 3) {
        self.viewModel.workType = JKMyLookPlayAnimation;
        
    }
    else if (sender.tag == 4) {
        
        self.viewModel.workType = JKMyLookPlayGame;
    }
    else if (sender.tag == 5) {
        self.viewModel.workType = JKMyLookPlayVariety;
        
    }
    
     [self.viewModel requestData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellViewModels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    JKMylookPlayTableViewCell *cell =  [[JKMylookPlayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
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

- (void)chooseTopicWithIndex:(NSInteger)index{
    
    if (index == 0) {
//        if (self.viewModel.type ==JKFilmFuture) {
//            self.viewModel.type = JKFilmCurrent;
//        }
//        else{
//
//            return;
//        }
        self.viewModel.type = JKMyLookPlayFavorited;
    }
    else{
        
         self.viewModel.type = JKMyLookPlayCommented;
//        if (self.viewModel.type ==JKFilmCurrent) {
//            self.viewModel.type = JKFilmFuture;
//        }
//        else{
//
//            return;
//        }
    }
    
//    [self.viewModel requestData];
    
    
    //     [self.mainTableView setContentOffset:CGPointZero animated:YES];
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
