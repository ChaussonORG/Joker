//
//  JKMeViewController.m
//  Joker
//
//  Created by 朱彦君 on 2017/6/15.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKMeViewController.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "CHTabBarViewController.h"
#import "UIButton+SD.h"
#import "JKMEListCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
// 以iphone6s iphone7为基准 4.7寸屏 --
#define BaseSCREEN_WIDTH               375.0f

#define AUTOLAYOUT_WIDTH_SCALE         SCREEN_WIDTH / BaseSCREEN_WIDTH

#define AUTOLAYOUT_LENGTH(x)           ((x) * AUTOLAYOUT_WIDTH_SCALE)

// tableview分割线
#define kCuttingLineColor [UIColor colorWithRed:238/ 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1]

#define kInitHeaderViewHeight 186 + AUTOLAYOUT_LENGTH(74)  //tableheaderview高度
#define kInitUserImageViewHeight AUTOLAYOUT_LENGTH(74)     //
#define kInitHeaderViewOriginY 0

@interface JKMeViewController ()<UITableViewDelegate,UITableViewDataSource,MeControllerDelegate,CHLoginModalControllerDelegate>
{
    
    UIImageView* tableheadView;
    
    UIImageView* userImageButton;
    
    CGFloat tableviewHerderOriginY;
    
    CGFloat tableviewHeaderHeight;
    
    CGFloat userImageViewHeight;
    
    NSArray* dataSource;
}
//@property (nonatomic , strong) UIView *headerView;

@property (nonatomic , strong) UIView *blackView;

//@property (nonatomic , strong) UIImageView *iconView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UIButton *favorCountLabel;

@property (nonatomic , strong) UIButton *lookCountLabel;

@property (nonatomic , strong) UIButton *setBtn;


//@property (nonatomic , strong) UITableView *mainTableView;

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
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    [self setupSubviews];
     self.tableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    [self binding];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        CGRect rect = self.tableView.frame;
        
        rect.origin.y = rect.origin.y - 20;
        
        self.tableView.frame = rect;
    }
    //
    self.navigationController.navigationBarHidden = YES;
    
//    self.navigationController.navigationBar.translucent = YES;
    
    [self.viewModel initData];
    
    [self.viewModel requestMyMessage];
    
    self.setBtn.hidden = YES;
    
}




- (void)binding{
    
    @weakify(self);
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(id x) {
        @strongify(self);
        
        [self.tableView reloadData];
        
        
    }];
    
    [RACObserve(self, viewModel.icon) subscribeNext:^(NSString *x) {
        @strongify(self);
        
        [userImageButton sd_setImageWithURL:[NSURL URLWithString:x] placeholderImage:[UIImage imageNamed:@"touxiang"]];
        
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
    
    [RACObserve(self, viewModel.myMessageCount) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        
        if ([x integerValue] > 0) {
            self.viewModel.cellViewModels[0].isRed = YES;
            [self.tableView reloadData];
        }
     
        
    }];
}
- (void)refreshUI{
    
    [self.viewModel initData];
}
- (void)setupSubviews{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    tableheadView = [[UIImageView alloc]init];
    tableheadView.backgroundColor = [JKStyleConfiguration whiteColor];
//    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, 260);
   
    tableheadView.userInteractionEnabled = YES;
    tableheadView= [[UIImageView alloc ]init];
    tableheadView.backgroundColor = [JKStyleConfiguration whiteColor];
    tableheadView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.blackView = [[UIView alloc]init];
    self.blackView.backgroundColor = [JKStyleConfiguration twotwoColor];
    self.blackView.frame = CGRectMake(0, 0, ScreenWidth, 130);
    [tableheadView addSubview:self.blackView];
    
    userImageButton = [[UIImageView alloc]init];
    userImageButton.layer.masksToBounds=YES;
    userImageButton.contentMode = UIViewContentModeScaleAspectFit;
//    [userImageButton setBackgroundImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [tableheadView addSubview:userImageButton];
    userImageButton.layer.borderColor = [UIColor whiteColor].CGColor;
    userImageButton.layer.borderWidth = 1;
    tableheadView.userInteractionEnabled = YES;
    userImageButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserImageButton)];
    [userImageButton addGestureRecognizer:tap];
    
//    self.tableView.tableHeaderView   =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kInitHeaderViewHeight)];
    
    tableviewHerderOriginY = kInitHeaderViewOriginY;
    
    tableviewHeaderHeight = kInitHeaderViewHeight;
    
    userImageViewHeight = kInitUserImageViewHeight;
    self.tableView.userInteractionEnabled = YES;
    [self.tableView addSubview:tableheadView];
    self.tableView.backgroundColor = [JKStyleConfiguration whiteColor];
//    self.iconView = [[UIImageView alloc]init];
//    self.iconView.frame = CGRectMake((ScreenWidth - 74)/2, 93, 74, 74);
//    [tableheadView addSubview:self.iconView];
//    self.iconView.layer.cornerRadius = 74/2;
//    self.iconView.layer.masksToBounds = YES;
//    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
//    self.iconView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.iconView.layer.borderWidth = 1;

    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.frame = CGRectMake(0, userImageButton.frame.size.height + userImageButton.frame.origin.y , ScreenWidth, 30);
    self.nameLabel.font = [JKStyleConfiguration hugeFont];
    self.nameLabel.textColor = [JKStyleConfiguration blackColor];
    [tableheadView addSubview:self.nameLabel];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;

    self.favorCountLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.favorCountLabel setImage:[UIImage imageNamed:@"guanzhuan"] forState:UIControlStateNormal];
    self.favorCountLabel.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.favorCountLabel setTitleColor:[JKStyleConfiguration drakGrayTextColor] forState:UIControlStateNormal];
    [tableheadView addSubview:self.favorCountLabel];
    self.favorCountLabel.frame = CGRectMake(ScreenWidth/2 -100, self.nameLabel.frame.size.height + self.nameLabel.frame.origin.y + 5, 100, 25);


    self.lookCountLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lookCountLabel setImage:[UIImage imageNamed:@"dipinglun"] forState:UIControlStateNormal];
    self.lookCountLabel.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.lookCountLabel setTitleColor:[JKStyleConfiguration drakGrayTextColor] forState:UIControlStateNormal];
    [tableheadView addSubview:self.lookCountLabel];
    self.lookCountLabel.frame = CGRectMake(ScreenWidth/2, self.nameLabel.frame.size.height + self.nameLabel.frame.origin.y + 5, 100, 25);


    self.setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.setBtn setImage:[UIImage imageNamed:@"baishezhi"] forState:UIControlStateNormal];
    [tableheadView addSubview:self.setBtn];
    self.setBtn.frame = CGRectMake(ScreenWidth - 25 - 15, 30, 25, 25);
    [self.setBtn addTarget:self action:@selector(clickSetBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, - 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20 ) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:self.tableView];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.tableHeaderView   =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 160 + ((80) * ScreenWidth/375.0f))];
    
    
    
//    self.mainTableView.tableHeaderView = self.headerView;
    
  
    
    [self.tableView addSubview:tableheadView];
}
- (void)clickUserImageButton{
    
    
    
}
- (void)clickSetBtn{
    
    [self.viewModel gotoSetting];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    tableheadView.frame = CGRectMake(0, tableviewHerderOriginY, [UIScreen mainScreen].bounds.size.width, tableviewHeaderHeight);
    
    self.blackView.frame = CGRectMake(0, 0, ScreenWidth, tableheadView.frame.size.height/2);
    
    userImageButton.frame =CGRectMake(0, 0, userImageViewHeight, userImageViewHeight);
    
    userImageButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, (kInitHeaderViewHeight - kInitUserImageViewHeight) / 2 + userImageViewHeight / 2);
    
    
    userImageButton.layer.cornerRadius = userImageViewHeight / 2;
    
    self.nameLabel.frame = CGRectMake(0, userImageButton.frame.size.height + userImageButton.frame.origin.y , ScreenWidth, 30);
    
    
    self.favorCountLabel.frame = CGRectMake(ScreenWidth/2 -100, self.nameLabel.frame.size.height + self.nameLabel.frame.origin.y + 5, 100, 25);
    
    
    self.lookCountLabel.frame = CGRectMake(ScreenWidth/2, self.nameLabel.frame.size.height + self.nameLabel.frame.origin.y + 5, 100, 25);
    
    
    self.setBtn.frame = CGRectMake(ScreenWidth - 25 - 15, 30, 25, 25);
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if(scrollView.contentOffset.y < 0) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        tableviewHerderOriginY = kInitHeaderViewOriginY + -1 *offsetY;
        tableviewHeaderHeight = kInitHeaderViewHeight + offsetY;
        
        userImageViewHeight = kInitUserImageViewHeight + offsetY;
        
    }
    else {
        
        [scrollView setContentOffset: CGPointMake(0, 0)];
        
    }
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
