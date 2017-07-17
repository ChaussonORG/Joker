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
@interface JKTopicDetailController ()<UITableViewDelegate,UITableViewDataSource,refreshSuperTableViewDelegate>

@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) JKTopicDetailBottomView *bottomView;


@end

@implementation JKTopicDetailController
- (instancetype)initWithTopicId:(NSString *)topicId
{
    self = [super init];
    if (self) {
        
        
        self.viewModel = [[JKTopicDetailVM alloc]initWithTopicId:topicId];
        
        
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
    [self binding];
    // Do any additional setup after loading the view.
}

- (void)binding{
    
    
    @weakify(self)
    [RACObserve(self, viewModel.cellVMs) subscribeNext:^(id x) {
        @strongify(self);
        
        
        [self.tableView reloadData];
        
        
    }];
    
}

#pragma mark UITableViewDelegate

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 3;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.viewModel.cellVMs.count;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    static NSString *cellId = @"cellId";
    
    JKCommentListCell *cell =  [[JKCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    JKCommentListCellVM *cellVM = self.viewModel.cellVMs[indexPath.row];
    cellVM.delegate = self;
    [cell loadDataWithVM: cellVM];
    return cell;
    
}

- (void)refresh{
    
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return self.viewModel.cellVMs[indexPath.row].cellHeight;
    
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
