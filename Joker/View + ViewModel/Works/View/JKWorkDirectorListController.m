//
//  JKWorkDirectorListController.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/8.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkDirectorListController.h"
#import "JKWorkDirectorListCell.h"
@interface JKWorkDirectorListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *mainTableView;

@end

@implementation JKWorkDirectorListController
- (instancetype)initWithTitle:(NSString*)title data:(NSArray *)data
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKWorkDirectorListVM alloc]initWithTitle:title data:data];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.naviTitle;
    
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 ) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    });

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    JKWorkDirectorListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[JKWorkDirectorListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    
    
    return cell;
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
    
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
