//
//  JKTopicsListViewController.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicsListViewController.h"
#import "JKTopicFilterView.h"
#import "JKTopicListCell.h"
#import "JKTopicListHeaderView.h"
#import <MJRefresh/MJRefresh.h>
#import "UIView+YLView.h"
#import "YLDragZoomCycleView.h"
#import "GKFadeNavigationController.h"
#import "KylinScrollView.h"
#import "Masonry.h"
#import "UIView+Kylin.h"
#import "CHLoginModalController.h"
#import "JKUserManager.h"
#import <CHProgressHUD/CHProgressHUD.h>
#import "JKCommentCreatController.h"

@interface JKTopicsListViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,ChooseTopicDelegate,FilterTopicDelegate,GKFadeNavigationControllerDelegate,YLDroagViewDelegate,TopicCommentDelegate,CHLoginModalControllerDelegate>



@property (nonatomic , strong) UIScrollView *mainScrollView;

@property (nonatomic , strong) JKTopicListHeaderView *headerView;

//@property (nonatomic , strong) JKTopicFilterView *sortView;

@property (nonatomic , strong) UITableView *topicsListTableView;

/**标题view*/
@property(nonatomic,weak)UIScrollView *titleView;

/**内容的view*/
@property(nonatomic,weak)KylinScrollView *contentView;

/**选中的按钮*/
@property(nonatomic,strong)UIButton *currentSelectedBtn;
/**下划线*/
@property(nonatomic,weak)UIView *selectedUnderLine;

@property(nonatomic, strong) YLDragZoomCycleView *dragView;

@property (nonatomic , strong) UIButton *createTopicBtn;

@property (nonatomic , strong) UIView *stateBgView;

/**标题数组*/
@property(nonatomic,strong)NSArray *titleArray;

@property (nonatomic) GKFadeNavigationControllerNavigationBarVisibility navigationBarVisibility;

@end

@implementation JKTopicsListViewController


- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"科技",@"热点",@"娱乐",@"体育"];
    }
    return _titleArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.viewModel = [[JKTopicsListVM alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel requestData];
    
    [self setupSubview];
    
    self.stateBgView = [[UIView alloc]init];
    self.stateBgView.backgroundColor = [UIColor whiteColor];
    self.stateBgView.frame = CGRectMake(0, 0, ScreenWidth, 20);
    [self.view addSubview:self.stateBgView];
    self.stateBgView.hidden = YES;
    
   
    
    UIView *mengban = [[UIView alloc]init];
    mengban.frame = CGRectMake(0, 0, ScreenWidth, 40);
//    mengban.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:mengban];
    UIColor *color1 = [UIColor colorWithRed:(0)  green:(0)  blue:(0)   alpha:0.4];
//    UIColor *color2 = [UIColor colorWithRed:(0)  green:(0)  blue:(0)  alpha:0.4];
//    UIColor *color3 = [UIColor colorWithRed:(0)  green:(0)  blue:(0)  alpha:0.2];
//    NSArray *colors = [NSArray arrayWithObjects:(id)color1.CGColor, color2.CGColor,color3.CGColor,nil];
//    NSArray *locations = [NSArray arrayWithObjects:@(0.0), @(0.7),@(1.0), nil, nil];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = colors;
//    gradientLayer.locations = locations;
//    gradientLayer.frame = mengban.bounds;
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint   = CGPointMake(0, 1.0);
//    mengban.layer.mask = gradientLayer;
    
    
    //初始化
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = mengban.bounds;
    
    //边宽
//    gradientLayer.borderWidth = 1.f;
    [mengban.layer addSublayer: gradientLayer];
    
    //设置颜色
    gradientLayer.colors = @[(__bridge id)color1.CGColor,
                                  (__bridge id)[UIColor clearColor].CGColor];
    
    //设置颜色渐变方向 (0,0)->(1,1)则45度方向 (0,0)->(1,0)上->下
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色分割点
    gradientLayer.locations = @[@(0.25),@(1)];
    
    
    [self binding];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.viewModel checkLogin];
    
    [self.viewModel requestData];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
   
    
//    self.navigationController.navigationBarHidden = NO;
    
}


- (void)setupSubview{
    
     
    self.topicsListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49 ) style:UITableViewStylePlain];
    self.topicsListTableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    self.topicsListTableView.delegate = self;
    self.topicsListTableView.dataSource = self;
    self.topicsListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.topicsListTableView];
    self.topicsListTableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    self.topicsListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHeaderData)];
     [self.topicsListTableView.mj_header beginRefreshing];
    @weakify(self)
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel requestMoreData];
    }];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    self.topicsListTableView.mj_footer = footer;
    
    
    self.dragView = [[YLDragZoomCycleView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderHeight) andDataSource:self.viewModel.imageArr autoScroll:YES scrollInterval:2];
    self.dragView.delegate = self;
    [self.view addSubview:self.dragView];
    
    
    self.createTopicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.createTopicBtn.frame = CGRectMake((self.view.frame.size.width - 100)/2, ScreenHeight - 104, 100, 40);
//    [self.createTopicBtn setImage:[[UIImage imageNamed:@"dipinglun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:(UIControlStateNormal)];
    
    [self.createTopicBtn setImage:[UIImage imageNamed:@"xiehuati"] forState:UIControlStateNormal];
    [self.createTopicBtn addTarget:self action:@selector(clickCreateTopicBtn) forControlEvents:(UIControlEventTouchUpInside)];
    self.createTopicBtn.layer.masksToBounds = YES;
    self.createTopicBtn.layer.cornerRadius = 20;
    [self.view addSubview:self.createTopicBtn];

    
    
    self.headerView = [[JKTopicListHeaderView alloc]initWithFilterTitles:self.viewModel.titlesArray selectedColor:[JKStyleConfiguration blackColor] isLine:YES];
    self.headerView.delegate = self;
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scrollOffsetY = kHeaderHeight-scrollView.contentOffset.y;
    // Show or hide the navigaiton bar
    if (scrollOffsetY-kHeaderHeight < kGKHeaderVisibleThreshold) {//或者<64
        self.navigationBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityVisible;
    } else {
        self.navigationBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityHidden;
    }
    
    if (scrollView.contentOffset.y > 0) {
        self.stateBgView.hidden = NO;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    }
    else{
        
        self.stateBgView.hidden = YES;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    //告诉dragView表格滑动了
    CGFloat offset = scrollView.contentOffset.y + kHeaderHeight;
    [self.dragView dragViewWithOffset:offset];
    
}
//正在拖拽的时候停止自动滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.dragView stopScroll];
}
//停止滑动开启自动滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.dragView startScroll];
}


#pragma mark - Accessors

//- (void)setNavigationBarVisibility:(GKFadeNavigationControllerNavigationBarVisibility)navigationBarVisibility {
//    
//    if (_navigationBarVisibility != navigationBarVisibility) {
//        // Set the value
//        _navigationBarVisibility = navigationBarVisibility;
//        
//        // Play the change
//        GKFadeNavigationController *navigationController = (GKFadeNavigationController *)self.navigationController;
//        if (navigationController.topViewController) {
//            [navigationController setNeedsNavigationBarVisibilityUpdateAnimated:YES];
//        }
//    }
//}

#pragma mark <GKFadeNavigationControllerDelegate>

- (GKFadeNavigationControllerNavigationBarVisibility)preferredNavigationBarVisibility {
    return self.navigationBarVisibility;
}


- (void)didSelectedItem:(NSInteger)item {
    
    //NSLog(@"选择了第%ld张图片",item+1);
}


- (void)chooseTopicWithIndex:(NSInteger)index{
    
    [self.viewModel changeTypeWithIndex:index];
    
    
}
- (void)requestHeaderData{

    [self.viewModel requestData];
    
}
- (void)binding{
    
    
    @weakify(self)
    [RACObserve(self, viewModel.isLogined) subscribeNext:^(NSNumber *x) {
        @strongify(self)
        
        if ([x boolValue]) {
            
            
            self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 42);
            
            self.topicsListTableView.tableHeaderView = self.headerView;
            
            
        }
        else{
            
             self.topicsListTableView.tableHeaderView = nil;
            
            
        }
         
    }];
    
    
    [RACObserve(self, viewModel.imageArr) subscribeNext:^(id x) {
        @strongify(self);
        //创建轮播图
        
        if (self.viewModel.imageArr.count > 0) {
            
            
            self.dragView.dataSource = self.viewModel.imageArr;
            
            [self.dragView.collectionView reloadData];
        }
        
    }];
    
    
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.topicFilterType),
                                RACObserve(self, viewModel.cellViewModels),
                                RACObserve(self, viewModel.attendCellViewModels)]] subscribeNext:^(id x) {
        @strongify(self);
        [self.topicsListTableView reloadData];
        
        [self.topicsListTableView.mj_header endRefreshing];
        
        [self.topicsListTableView.mj_header endRefreshing];
        
        if (self.viewModel.isFinishRequestMoreData) {
            [self.topicsListTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.topicsListTableView.mj_footer endRefreshing];
        }
    }];

    
}


#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.viewModel.topicFilterType == JKTopicLast) {
        
         return self.viewModel.cellViewModels.count;
    }
    else{
        
        return self.viewModel.attendCellViewModels.count + 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    if (self.viewModel.topicFilterType == JKTopicLast) {
        JKTopicListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[JKTopicListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        
        [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
        
        
        cell.viewModel.delegate =self;
        
         return cell;
    }
    else{
        
        if (indexPath.row == 0) {
            
            JKTopicFilterView *cell = [[JKTopicFilterView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.mainTitleLabel.text = @"查看关注话题分类";
            cell.imageSource = self.viewModel.attentFilterImages;
            [cell fetchData:self.viewModel.attentFilterTitles];
            
            
            cell.delegate = self;
            return cell;
            
        }
        else{
            
            JKTopicListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[JKTopicListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            
            
            [cell loadDataWithVM:self.viewModel.attendCellViewModels[indexPath.row - 1]];
            
            cell.viewModel.delegate =self;
            
            
             return cell;
        }
    
    }
    
   
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewModel.topicFilterType == JKTopicLast) {
        
        return self.viewModel.cellViewModels[indexPath.row].cellHeight;
    }
    else{
        
        if (indexPath.row == 0) {
            
            return 120;
        }
        else{
            
            return self.viewModel.attendCellViewModels[indexPath.row - 1].cellHeight;
        }
        
    }
    
}



#pragma mark FilterTopicDelegate
- (void)filterTopicWithIndex:(NSInteger)index{
    
    
    [self.viewModel gotoTopicfilteredListWithIndex:index];
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
    
    [self.viewModel checkLogin];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)commentTopicWithId:(NSString *)topicId title:(NSString *)title{
    
    [self.viewModel checkLogin];
    
    if (self.viewModel.isLogined) {
    
        JKCommentCreatController *vc = [[JKCommentCreatController alloc]init];
        vc.viewModel.titleStr = [NSString stringWithFormat:@"回复：%@",title];
        vc.viewModel.topicId = topicId;
        [[ASNavigator shareModalCenter] pushViewController:vc parameters:nil isAnimation:YES];
        
    }
    else{
        
        [self login];
    }
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
