//
//  JKTopicDetailController.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/6.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicDetailController.h"
#import "JKCommentListCell.h"
#import "JKTopicDetailBottomView.h"
#import "JKTopicSpareCommentCell.h"
#import <CHWebView.h>
@interface JKTopicDetailController ()<UITableViewDelegate,UITableViewDataSource,refreshSuperTableViewDelegate,CHWebViewDelegate,ScrollTableViewDelegate>

@property (nonatomic , strong) CHWebView *webView;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) JKTopicDetailBottomView *bottomView;

@property (nonatomic , assign) CGFloat webHeight;

@end

@implementation JKTopicDetailController
- (instancetype)initWithTopicId:(NSString *)topicId
{
    self = [super init];
    if (self) {
        
        
        self.viewModel = [[JKTopicDetailVM alloc]initWithTopicId:topicId];
        
        self.viewModel.delegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"话题详情";
    
    self.view.backgroundColor = [JKStyleConfiguration screenSpareColor];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 45) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHeaderData)];
//    @weakify(self)
//    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
//        @strongify(self)
//        [self.viewModel requestMoreData];
//    }];
////    footer.stateLabel.font = [UIFont systemFontOfSize:12];
//    self.tableView.mj_footer = footer;
    
    self.bottomView = [[JKTopicDetailBottomView alloc]init];
    self.bottomView.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height, ScreenWidth, 45);
    [self.bottomView loadDataWithVM:self.viewModel.bottomVM];
    [self.view addSubview:self.bottomView];
    
    
    [self setupWebView];
    
    [self binding];
    // Do any additional setup after loading the view.
}
- (void)requestHeaderData{
    
    [self.viewModel requestData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.viewModel requestData];
    
}
- (void)setupWebView{
    
    self.webView = [[CHWebView alloc]init];
    self.webView.delegate = self;
    self.webView.frame = CGRectMake(0, 0, ScreenWidth, 20);
    
    
    self.webView.pro
    self.tableView.tableHeaderView = self.webView;
    
}
- (void)webViewDidFinshLoad:(CHWebView *)webView{
    
    self.webView.scrollView.scrollEnabled = NO;
    double delayInSeconds = 0.5;
//     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//
//
//        NSString *output = [(UIWebView *)webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
//
//        self.webHeight = [output floatValue];
//    });
    [webView invokeJavaScript:@"document.body.offsetHeight;" completionHandler:^(id height, NSError *error) {
        
        self.webHeight = [height floatValue];
    }];
}

-(void)scrollsToNext{
    
    
//    [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    NSString *subtypeString;
    subtypeString = kCATransitionFromRight;
    [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.view];
//    [self.tableView setContentOffset:CGPointZero animated:NO];
}

-(void)scrollsToLast{
    
    
    //    [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    NSString *subtypeString;
    subtypeString = kCATransitionFromLeft;
    [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.view];
    //    [self.tableView setContentOffset:CGPointZero animated:NO];
}

- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.7f;
    animation.type = type;
    if (subtype != nil) {
        animation.subtype = subtype;
    }
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}
- (void)binding{
    
    @weakify(self)
    [RACObserve(self, viewModel.cellVMs) subscribeNext:^(id x) {
        @strongify(self);
        
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
//        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
         [self.tableView.mj_footer endRefreshing];
        
        [self.tableView setContentOffset:CGPointZero animated:NO];
        
    }];
    
    [RACObserve(self, viewModel.topCellVMs) subscribeNext:^(id x) {
        @strongify(self);
        
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
//        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    [RACObserve(self, viewModel.bottemCellVMs) subscribeNext:^(id x) {
        @strongify(self);
        
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    [RACObserve(self, viewModel.detailHtmlStr) subscribeNext:^(NSString *x) {
        @strongify(self)
                NSURL *url = [NSURL URLWithString:x];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //        NSString *path = [[NSBundle mainBundle]bundlePath];
        //        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        [self.webView loadRequest:request];
        
//        [self.webView loadHTMLString:x baseURL:nil];
        
        
    }];
    
    [RACObserve(self, webHeight) subscribeNext:^(id x) {
        @strongify(self);
        
        self.webView.frame = CGRectMake(0, 0, ScreenWidth, self.webHeight + 20);
        
        self.tableView.tableHeaderView = self.webView;
        
        
    }];
    
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section == 0) {
        
        return self.viewModel.topCellVMs.count;
    }
    else if (section == 1) {
        
        return self.viewModel.bottemCellVMs.count;
    }
    else{
        
        if (self.viewModel.cellVMs.count > 0) {
             return self.viewModel.cellVMs.count;
        }
        else{
            return 1;
        }
 
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    static NSString *cellId = @"cellId";
    if (indexPath.section == 0) {
        
        JKCommentListCell *cell =  [[JKCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
    
        [cell loadDataWithVM: self.viewModel.topCellVMs[indexPath.row]];
        return cell;
    }
    else if (indexPath.section == 1) {
        
        JKCommentListCell *cell =  [[JKCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        [cell loadDataWithVM: self.viewModel.bottemCellVMs[indexPath.row]];
        return cell;
    }
    else{ 
        if (self.viewModel.cellVMs.count > 0) {
            JKCommentListCell *cell =  [[JKCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            
//            cellVM.delegate = self;
            [cell loadDataWithVM:self.viewModel.cellVMs[indexPath.row]];
            return cell;
        }
        else{
            JKTopicSpareCommentCell *cell =  [[JKTopicSpareCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            return cell;
        }
        
        
    }
    
    
}

- (void)refresh{
    
    [self.tableView scrollsToTop];
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        return self.viewModel.topCellVMs[indexPath.row].cellHeight;
    }
    else if (indexPath.section == 1) {
        
        return self.viewModel.bottemCellVMs[indexPath.row].cellHeight;
    }
    else{
        
        
        if (self.viewModel.cellVMs.count > 0) {
            
            return self.viewModel.cellVMs[indexPath.row].cellHeight;
        }
        else{
            return 80;
        }
    }
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.viewModel.topCellVMs.count == 0) {
        if (section== 0) {
            return 0.01;
        }
    }
    
    if (self.viewModel.bottemCellVMs.count == 0) {
        if (section== 1) {
            return 0.01;
        }
    }
    
    return 40;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [JKStyleConfiguration whiteColor];
    UIView *bgView = [[UIView alloc]init];
    [view addSubview:bgView];
    bgView.frame = CGRectMake(0, 0, ScreenWidth, 35);
    bgView.backgroundColor = [JKStyleConfiguration grayBackgroundColor];
    UILabel *label = [[UILabel alloc]init];
    label.font = [JKStyleConfiguration subcontentFont];
    label.textColor = [JKStyleConfiguration drakGrayTextColor];
    label.frame = CGRectMake(10, 8, 120, 20);
    
    if (section == 0) {
        
        if (self.viewModel.topCellVMs.count > 0) {
            label.text = @"最客观评论";
        }
        else{
            bgView.hidden = YES;
        }
 
    }
    else if (section == 1) {
        if (self.viewModel.bottemCellVMs.count > 0) {
            label.text = @"最不客观评论";
        }
        else{
            bgView.hidden = YES;
        }
        
    }
    else{
        
       label.text = @"全部回复";
        
    }
    
    [view addSubview:label];
    
    return view;
    
}

#pragma mark ScrollTableViewDelegate
- (void)scrollsToTop{
    
//    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    
//    
//    
//    [[self tableView] scrollToRowAtIndexPath:scrollIndexPath
//                            atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x,0) animated:YES];
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
