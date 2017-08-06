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
@interface JKTopicDetailController ()<UITableViewDelegate,UITableViewDataSource,refreshSuperTableViewDelegate,UIWebViewDelegate,ScrollTableViewDelegate>

@property (nonatomic , strong) UIWebView *webView;

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

    [self.viewModel requestData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 45) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    
    self.bottomView = [[JKTopicDetailBottomView alloc]init];
    self.bottomView.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height, ScreenWidth, 45);
    [self.bottomView loadDataWithVM:self.viewModel.bottomVM];
    [self.view addSubview:self.bottomView];
    
    
    [self setupWebView];
    
    [self binding];
    // Do any additional setup after loading the view.
}

- (void)setupWebView{
    
    self.webView = [[UIWebView alloc]init];
    self.webView.delegate = self;
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    NSString *output = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('foo').offsetHeight;"];
    
    
    //    self.webViewHeight = [output floatValue];
    
    //    self.webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
    
    
    CGRect frame = webView.frame;
    frame.origin.x = 15;
    frame.origin.y = 0;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 30;
    frame.size.height = 1;
    
    webView.frame = frame;
    
    frame.size.height = webView.scrollView.contentSize.height;
    
    webView.frame = frame;
    
    webView.scrollView.scrollEnabled = NO;
    
    NSLog(@"height: %f", frame.size.height);
    //    self.webViewHeight = webView.scrollView.contentSize.height;
    
    
    if (self.webHeight != frame.size.height) {
        self.webHeight = frame.size.height;
    }
    
    
    //    self.viewModel.contentCellVM.cellHeight = webView.scrollView.contentSize.height + 10;
    
    //    [self.mainTableView reloadData];
    
}


- (void)binding{
    
    
    @weakify(self)
    [RACObserve(self, viewModel.cellVMs) subscribeNext:^(id x) {
        @strongify(self);
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView reloadData];
        
        
    }];
    
    [RACObserve(self, viewModel.topCellVMs) subscribeNext:^(id x) {
        @strongify(self);
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }];
    
    
    [RACObserve(self, viewModel.bottemCellVMs) subscribeNext:^(id x) {
        @strongify(self);
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
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
        
        self.webView.frame = CGRectMake(0, 0, ScreenWidth, self.webHeight);
        
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
        
        return self.viewModel.cellVMs.count;
        
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    static NSString *cellId = @"cellId";
    if (indexPath.section == 0) {
        
        JKCommentListCell *cell =  [[JKCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        JKCommentListCellVM *cellVM = self.viewModel.topCellVMs[indexPath.row];
        cellVM.delegate = self;
        [cell loadDataWithVM: cellVM];
        return cell;
    }
    else if (indexPath.section == 1) {
        
        JKCommentListCell *cell =  [[JKCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        JKCommentListCellVM *cellVM = self.viewModel.bottemCellVMs[indexPath.row];
        cellVM.delegate = self;
        [cell loadDataWithVM: cellVM];
        return cell;
    }
    else{
        JKCommentListCell *cell =  [[JKCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        JKCommentListCellVM *cellVM = self.viewModel.cellVMs[indexPath.row];
        cellVM.delegate = self;
        [cell loadDataWithVM: cellVM];
        return cell;
        
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
        
        return self.viewModel.cellVMs[indexPath.row].cellHeight;
        
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
        
        if (self.viewModel.cellVMs.count > 0) {
             label.text = @"全部回复";
        }
        else{
            
             label.text = @"暂无回复";
        }
       
        
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
