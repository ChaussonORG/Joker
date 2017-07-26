//
//  JKFilmTimeLineController.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/25.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKFilmTimeLineController.h"
#import "JKTopicListHeaderView.h"
@interface JKFilmTimeLineController ()<UITableViewDelegate,UITableViewDataSource,ChooseTopicDelegate>
@property (nonatomic , strong) JKTopicListHeaderView *headerView;

@property (nonatomic , strong) UITableView *mainTableView;

@end

@implementation JKFilmTimeLineController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKFilmTimeLineVM alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.headerView = [[JKTopicListHeaderView alloc]initWithFilterTitles:self.viewModel.titlesArray selectedColor:[JKStyleConfiguration redColor]];
    self.headerView.delegate = self;
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 42);
    self.headerView.bottomLine.hidden = YES;
    [self.view addSubview:self.headerView];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.origin.y + self.headerView.frame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49 -(self.headerView.frame.origin.y + self.headerView.frame.size.height)) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
  
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestHeaderData)];
    @weakify(self)
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
//        [self.viewModel requestMoreData];
    }];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    self.mainTableView.mj_footer = footer;
    // Do any additional setup after loading the view.
}
- (void)requestHeaderData{
    
//    [self.viewModel requestData];
    
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.viewModel.type == JKFilmCurrent) {
        
//        return self.viewModel.cellViewModels.count;
        return 0;
    }
    else{
        
//        return self.viewModel.attendCellViewModels.count + 1;
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    return nil;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewModel.type == JKFilmCurrent) {
        
//        return self.viewModel.cellViewModels[indexPath.row].cellHeight;
        
        return 0;
    }
    else{
        
//        if (indexPath.row == 0) {
//            
//            return 120;
//        }
//        else{
//            
//            return self.viewModel.attendCellViewModels[indexPath.row - 1].cellHeight;
//        }

        return 0;
    }
    
}

- (void)chooseTopicWithIndex:(NSInteger)index{
    
    
    
    
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
