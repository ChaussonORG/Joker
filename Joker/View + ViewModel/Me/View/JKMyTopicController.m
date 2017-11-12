//
//  JKMyTopicController.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMyTopicController.h"
#import "JKTopicListHeaderView.h"
@interface JKMyTopicController ()<ChooseTopicDelegate>
@property (nonatomic , strong) JKTopicListHeaderView *headerView;

@property (nonatomic , strong) UITableView *mainTableView;
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
    // Do any additional setup after loading the view.
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
    
    //    [self.viewModel requestData];
    
    
    //     [self.mainTableView setContentOffset:CGPointZero animated:YES];
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
