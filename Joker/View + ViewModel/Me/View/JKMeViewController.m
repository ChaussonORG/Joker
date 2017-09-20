//
//  JKMeViewController.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMeViewController.h"

#import "CHTabBarViewController.h"

#import "JKMEListCell.h"
@interface JKMeViewController ()<UITableViewDelegate,UITableViewDataSource,MeControllerDelegate>


@property (nonatomic , strong) UIView *headerView;

@property (nonatomic , strong) UIView *blackView;

@property (nonatomic , strong) UIImageView *iconView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UIButton *favorCountLabel;

@property (nonatomic , strong) UIButton *lookCountLabel;

@property (nonatomic , strong) UIButton *setBtn;

@property (nonatomic , strong) UITableView *mainTableView;

@end

@implementation JKMeViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKMEVM alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupSubviews];
    
    [self binding];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.viewModel initData];
    
}
- (void)binding{
    
    @weakify(self);
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(id x) {
        @strongify(self);
        
        [self.mainTableView reloadData];
        
        
    }];
    
    [RACObserve(self, viewModel.icon) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
    }];

    
    RAC(self,nameLabel.text) = RACObserve(self, viewModel.name);
    
    [RACObserve(self, viewModel.lookCount) subscribeNext:^(NSNumber *x) {
        @strongify(self);

        
        if (x) {
            [self.lookCountLabel setTitle:[NSString stringWithFormat:@" %ld 看过",[x integerValue]] forState:UIControlStateNormal];
        }
        
        
    }];
    
    [RACObserve(self, viewModel.favorCount) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        
        if (x) {
            [self.favorCountLabel setTitle:[NSString stringWithFormat:@" %ld 关注",[x integerValue]] forState:UIControlStateNormal];
        }
        
        
    }];
}
- (void)refreshUI{
    
    [self.viewModel initData];
}
- (void)setupSubviews{
    
    self.headerView = [[UIView alloc]init];
    self.headerView.backgroundColor = [JKStyleConfiguration whiteColor];
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 260);
   
    self.blackView = [[UIView alloc]init];
    self.blackView.backgroundColor = [JKStyleConfiguration twotwoColor];
    self.blackView.frame = CGRectMake(0, 0, ScreenWidth, 130);
    [self.headerView addSubview:self.blackView];
    
    self.iconView = [[UIImageView alloc]init];
    self.iconView.frame = CGRectMake((ScreenWidth - 74)/2, 93, 74, 74);
    [self.headerView addSubview:self.iconView];
    self.iconView.layer.cornerRadius = 74/2;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.frame = CGRectMake(0, self.iconView.frame.size.height + self.iconView.frame.origin.y , ScreenWidth, 30);
    self.nameLabel.font = [JKStyleConfiguration hugeFont];
    self.nameLabel.textColor = [JKStyleConfiguration blackColor];
    [self.headerView addSubview:self.nameLabel];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.favorCountLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.favorCountLabel setImage:[UIImage imageNamed:@"guanzhuan"] forState:UIControlStateNormal];
    self.favorCountLabel.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.favorCountLabel setTitleColor:[JKStyleConfiguration drakGrayTextColor] forState:UIControlStateNormal];
    [self.headerView addSubview:self.favorCountLabel];
    self.favorCountLabel.frame = CGRectMake(ScreenWidth/2 -100, self.nameLabel.frame.size.height + self.nameLabel.frame.origin.y + 5, 100, 25);
    
    
    self.lookCountLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lookCountLabel setImage:[UIImage imageNamed:@"dipinglun"] forState:UIControlStateNormal];
    self.lookCountLabel.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.lookCountLabel setTitleColor:[JKStyleConfiguration drakGrayTextColor] forState:UIControlStateNormal];
    [self.headerView addSubview:self.lookCountLabel];
    self.lookCountLabel.frame = CGRectMake(ScreenWidth/2, self.nameLabel.frame.size.height + self.nameLabel.frame.origin.y + 5, 100, 25);
    
    
    self.setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.setBtn setImage:[UIImage imageNamed:@"baishezhi"] forState:UIControlStateNormal];
    [self.headerView addSubview:self.setBtn];
    self.setBtn.frame = CGRectMake(ScreenWidth - 25 - 15, 30, 25, 25);

    
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, - 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20 ) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.headerView;
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return self.viewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    JKMEListCell *cell=  [[JKMEListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
 
    cell.viewModel.delegate = self;
    
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
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
