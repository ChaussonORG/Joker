//
//  JKPersonInfoController.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonInfoController.h"
#import "JKPersonInfoCell.h"
@interface JKPersonInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *mainTableView;

@end

@implementation JKPersonInfoController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[JKPersonInfoVM alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = [JKStyleConfiguration screenBackgroundColor];

    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
    
    [self.viewModel requestData];
    
    [self binding];
}
- (void)binding{
    
    @weakify(self)
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(id x) {
      @strongify(self)
        
        [self.mainTableView reloadData];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellViewModels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    JKPersonInfoCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[JKPersonInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    return cell;
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
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
