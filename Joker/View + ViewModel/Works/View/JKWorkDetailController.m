//
//  JKWorkDetailController.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/30.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKWorkDetailController.h"
#import "JKTopicListHeaderView.h"
#import "JKTopicListCell.h"
#import "JKWorkCommentListCell.h"
#import "JKTopicSpareCommentCell.h"
#import "CHLoginModalController.h"
#import "JKCommentCreatController.h"
#import "JKUserManager.h"
#import "JKDirectorslistCell.h"
#import "JKWorkDesCell.h"
#import "JKWorkImageListCell.h"

@interface JKWorkDetailController ()<UITableViewDelegate,UITableViewDataSource,ChooseTopicDelegate,TopicCommentDelegate,PhotoBroswerVCDelegate,WorkrefreshTableViewDelegate,CHLoginModalControllerDelegate>


@property (nonatomic , strong) UIImageView *bgImageView;

@property (nonatomic , strong) UIView *workDetailView;

@property (nonatomic ,strong) UIImageView *workBgImageView;

@property (nonatomic ,strong) UIImageView *workImageView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *strOneLabel;

@property (nonatomic , strong) UILabel *strTwoLabel;

@property (nonatomic , strong) UILabel *strThreeLabel;

@property (nonatomic , strong) UIView *lookPlayView;

@property (nonatomic , strong) UILabel *lookPlayTitle;

@property (nonatomic , strong) UILabel *lookPlayScore;

@property (nonatomic , strong) UIButton *score1;

@property (nonatomic , strong) UIButton *score2;

@property (nonatomic , strong) UIButton *score3;

@property (nonatomic , strong) UIButton *score4;

@property (nonatomic , strong) JKTopicListHeaderView *headerView;

@property (nonatomic , strong) UITableView *mainTableView;

@property (nonatomic , strong) UIButton *backBtn;

@property (nonatomic , strong) PhotoCotentView *contentView;

@property (nonatomic , strong) UIView *bottomView;

@property (nonatomic , strong) UIButton *favoriteBtn;

@property (nonatomic , strong) UIButton *commentBtn;

@property (nonatomic , strong) UIButton *shareBtn;

@property (nonatomic , strong) UIView *naviBgView;

@property (nonatomic , strong) JKTopicListHeaderView *naviHeaderView;

@property (nonatomic , strong) UILabel *naviTitleLabel;

@end

@implementation JKWorkDetailController

- (instancetype)initWithWorkId:(NSString *)workId
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKWorkDetailVM alloc]initWithWorkId:workId];
        
        self.viewModel.delegate = self;
        
        
    }
    return self;
}
- (void)tableViewReload{
    
    [self.viewModel requestData];
    
    [self.mainTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.bgImageView = [[UIImageView alloc]init];
    self.bgImageView.frame = CGRectMake(0, -20, ScreenWidth, ScreenHeight + 20);
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bgImageView];
    
    
    
    
    
    [self setupWorkDetailView];
    
    [self setupTableView];
    
    [self setupBottomView];
    
    self.naviBgView = [[UIView alloc]init];
    self.naviBgView.frame = CGRectMake(0, 0, ScreenWidth, 64 + 40 + 3);
    self.naviBgView.backgroundColor = [JKStyleConfiguration whiteColor];
    self.naviBgView.hidden = YES;
    
    [self.view addSubview:self.naviBgView];
    
    self.naviTitleLabel = [[UILabel alloc]init];
    self.naviTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.naviTitleLabel.frame = CGRectMake(0, 20, ScreenWidth, 40);
    self.naviTitleLabel.font = [JKStyleConfiguration naviTitleFont];
    self.naviTitleLabel.textColor = [JKStyleConfiguration blackColor];
    [self.naviBgView addSubview:self.naviTitleLabel];
    
    
    self.naviHeaderView = [[JKTopicListHeaderView alloc]initWithFilterTitles:self.viewModel.titlesArray selectedColor:[JKStyleConfiguration blackColor] isLine:NO];
    self.naviHeaderView.delegate = self;
    
    self.naviHeaderView.frame = CGRectMake(0, 64, ScreenWidth, 40);
    [self.naviBgView addSubview:self.naviHeaderView];
    
    
    
    
    self.backBtn = [self customLeftBackButton];
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setImage:[UIImage imageNamed:@"sharewhite"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(clickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    self.shareBtn.frame = CGRectMake(ScreenWidth - 15 - 25, 28, 25, 25);
    [self.view addSubview:self.shareBtn];
    
    [self binding];
    // Do any additional setup after loading the view.
}
- (void)clickShareBtn{
    
    
    
    
}
- (void)setupBottomView{
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.frame = CGRectMake(0, ScreenHeight - 50 , ScreenWidth, 50) ;
    [self.view addSubview:self.bottomView];
    self.bottomView.backgroundColor = [UIColor whiteColor];
     
    self.favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.favoriteBtn.frame = CGRectMake(0, 0, ScreenWidth/2- 0.5, 50);
    [self.favoriteBtn addTarget:self action:@selector(clickFavoriteBtn) forControlEvents:UIControlEventTouchUpInside];
    self.favoriteBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    [self.favoriteBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.favoriteBtn];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [JKStyleConfiguration lineColor];
    lineView.frame = CGRectMake(self.favoriteBtn.frame.origin.x + self.favoriteBtn.frame.size.width , 14, 1, 20 );
    [self.bottomView addSubview:lineView];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(lineView.frame.origin.x + lineView.frame.size.width, 0, ScreenWidth/2- 0.5, 50);
    [self.commentBtn addTarget:self action:@selector(clickCommentBtn) forControlEvents:UIControlEventTouchUpInside];
    self.commentBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    [self.commentBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    [self.bottomView addSubview:self.commentBtn];
    [self.commentBtn setImage:[UIImage imageNamed:@"dipinglun"] forState:UIControlStateNormal];
}

- (void)clickFavoriteBtn{
    
    [self.viewModel favoriteWork];
    
    
}

- (void)clickCommentBtn{
    
    
    [self.viewModel commentWork];
}

-(UIButton*)customLeftBackButton{
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame=CGRectMake(20, 15, 40,50);
//    [btn setTitle:@" 返回" forState:UIControlStateNormal];
    btn.titleLabel.font = [JKStyleConfiguration titleFont];
    [btn setImage:[UIImage imageNamed:@"backbai"] forState:UIControlStateNormal];
    [btn setAdjustsImageWhenHighlighted:NO];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    return btn;
} // 自定义导航栏按钮

-(void)popself
{
    [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
    
}
- (void)setupTableView{
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20 -44) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    @weakify(self)
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel requestMoreData];
    }];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    self.mainTableView.mj_footer = footer;
    
    self.mainTableView.tableHeaderView = self.workDetailView;
}

- (void)setupWorkDetailView{
    
    
    self.workDetailView = [[UIView alloc]init];
    self.workDetailView.backgroundColor = [UIColor clearColor];
    self.workDetailView.frame = CGRectMake(0, 0, ScreenWidth, 287);
    
    [self.workDetailView addSubview:self.bgImageView];
    self.workDetailView.layer.masksToBounds = YES;
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.bgImageView addSubview:whiteView];
    whiteView.frame = CGRectMake(0, 230, ScreenWidth, ScreenHeight);
    
    self.workBgImageView = [[UIImageView alloc]init];
    self.workBgImageView.frame = CGRectMake(-70, -50, ScreenWidth + 140, 260);
    [self.workDetailView addSubview:self.workBgImageView];
    self.workBgImageView.contentMode = UIViewContentModeScaleToFill;
    self.workBgImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    self.workImageView = [[UIImageView alloc]init];
    self.workImageView.frame = CGRectMake(20, 90, 110, 155);
    //    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.workDetailView addSubview:self.workImageView];
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.font = [JKStyleConfiguration hugeFont];
    self.nameLabel.textColor = [JKStyleConfiguration whiteColor];
    self.nameLabel.frame = CGRectMake(self.workImageView.frame.origin.x + self.workImageView.frame.size.width + 15, 90, ScreenWidth - (self.workImageView.frame.origin.x + self.workImageView.frame.size.width + 20) - 20, 25);
    [self.workDetailView addSubview:self.nameLabel];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [JKStyleConfiguration lineColor];
    lineView.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 10, ScreenWidth -  self.nameLabel.frame.origin.x, 1);
    [self.workDetailView addSubview:lineView];
    
    
    self.lookPlayView = [[UIView alloc]init];
    self.lookPlayView.frame = CGRectMake(ScreenWidth - 15 - 44, lineView.frame.origin.y + lineView.frame.size.height + 12, 44, 54);
//    self.lookPlayView.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;
//    self.lookPlayView.layer.borderWidth = 1;
    [self.workDetailView addSubview:self.lookPlayView];
    
    
    self.lookPlayTitle = [[UILabel alloc]init];
    self.lookPlayTitle.font = [JKStyleConfiguration middlecontentFont];
    self.lookPlayTitle.textColor = [JKStyleConfiguration whiteColor];
    self.lookPlayTitle.frame = CGRectMake(0, 5, self.lookPlayView.frame.size.width, 15);
    self.lookPlayTitle.textAlignment = NSTextAlignmentCenter;
    self.lookPlayTitle.text = @"看玩指数";
    [self.lookPlayView addSubview:self.lookPlayTitle];
    
    
    self.lookPlayScore = [[UILabel alloc]init];
    self.lookPlayScore.font = [JKStyleConfiguration veryHugeFont];
    self.lookPlayScore.textColor = [JKStyleConfiguration whiteColor];
    self.lookPlayScore.frame = CGRectMake(0,self.lookPlayTitle.frame.size.height + self.lookPlayTitle.frame.origin.y + 5, self.lookPlayView.frame.size.width, self.lookPlayView.frame.size.height - 25);
    self.lookPlayScore.textAlignment = NSTextAlignmentCenter;
    [self.lookPlayView addSubview:self.lookPlayScore];
    
    
    self.strOneLabel = [[UILabel alloc]init];
    self.strOneLabel.font = [JKStyleConfiguration contentFont];
    self.strOneLabel.textColor = [JKStyleConfiguration whiteColor];
    self.strOneLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, lineView.frame.origin.y + lineView.frame.size.height + 10,  self.lookPlayView.frame.origin.x - 10 - self.nameLabel.frame.origin.x , 20);
    [self.workDetailView addSubview:self.strOneLabel];
    
    
    self.strTwoLabel = [[UILabel alloc]init];
    self.strTwoLabel.font = [JKStyleConfiguration contentFont];
    self.strTwoLabel.textColor = [JKStyleConfiguration whiteColor];
    self.strTwoLabel.frame = CGRectMake(self.strOneLabel.frame.origin.x, self.strOneLabel.frame.origin.y + self.strOneLabel.frame.size.height , self.strOneLabel.frame.size.width , 20);
    [self.workDetailView addSubview:self.strTwoLabel];
    
    self.strThreeLabel = [[UILabel alloc]init];
    self.strThreeLabel.font = [JKStyleConfiguration contentFont];
    self.strThreeLabel.textColor = [JKStyleConfiguration whiteColor];
    self.strThreeLabel.frame = CGRectMake(self.strTwoLabel.frame.origin.x, self.strTwoLabel.frame.origin.y + self.strTwoLabel.frame.size.height , self.strTwoLabel.frame.size.width , 20);
    [self.workDetailView addSubview:self.strThreeLabel];
    
    
    self.score1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.score1 setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.score1.frame = CGRectMake(self.strThreeLabel.frame.origin.x-5, 220 , 50, 20);
    [self.workDetailView  addSubview:self.score1];
    self.score1.titleLabel.font = [JKStyleConfiguration contentFont];
    [self.score1 setTitleColor:[JKStyleConfiguration sixsixColor] forState:UIControlStateNormal];
    
    
    self.score2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.score2 setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.score2.frame = CGRectMake(self.score1.frame.origin.x + self.score1.frame.size.width , 220 , 50, 20);
    [self.workDetailView  addSubview:self.score2];
    self.score2.titleLabel.font = [JKStyleConfiguration contentFont];
    [self.score2 setTitleColor:[JKStyleConfiguration sixsixColor] forState:UIControlStateNormal];
    
    
    self.score3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.score3 setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.score3.frame = CGRectMake(self.score2.frame.origin.x + self.score2.frame.size.width, 220, 50, 20);
    [self.workDetailView  addSubview:self.score3];
    self.score3.titleLabel.font = [JKStyleConfiguration contentFont];
    [self.score3 setTitleColor:[JKStyleConfiguration sixsixColor] forState:UIControlStateNormal];
    
    self.score4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.score4 setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
    self.score4.frame = CGRectMake(self.score3.frame.origin.x + self.score3.frame.size.width, 220, 50, 20);
    [self.workDetailView  addSubview:self.score4];
    self.score4.titleLabel.font = [JKStyleConfiguration contentFont];
    [self.score4 setTitleColor:[JKStyleConfiguration sixsixColor] forState:UIControlStateNormal];

    
    self.headerView = [[JKTopicListHeaderView alloc]initWithFilterTitles:self.viewModel.titlesArray selectedColor:[JKStyleConfiguration blackColor] isLine:NO];
    self.headerView.delegate = self;
    
    self.headerView.frame = CGRectMake(0, 245, ScreenWidth, 40);
    [self.workDetailView addSubview:self.headerView];
    self.workDetailView.userInteractionEnabled = YES;
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.viewModel requestData];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
}
- (void)binding{
    
 
    
    RAC(self,strOneLabel.text) = RACObserve(self, viewModel.strOne);
    
    RAC(self,strTwoLabel.text) = RACObserve(self, viewModel.strTwo);
    
    RAC(self,strThreeLabel.text) = RACObserve(self, viewModel.strThree);
    
    
    
    @weakify(self)
    [RACObserve(self, viewModel.name) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        self.nameLabel.text = x;
        
        self.naviTitleLabel.text = x;
        
        
    }];
    
    [RACObserve(self, viewModel.jokerScore) subscribeNext:^(NSString *x) {
        @strongify(self)
        if ([x integerValue] > 0) {
            self.lookPlayScore.text = x;
            self.lookPlayScore.font = [JKStyleConfiguration veryHugeFont];
        }
        else{
            
            self.lookPlayScore.text = @"暂无";
            self.lookPlayScore.font = [JKStyleConfiguration subcontentFont];
        }
    }];
    [RACObserve(self, viewModel.workImage) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        NSString *image = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_mfit,h_100,w_140",x];
        
        [self.workImageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"Launch"]];
        
        
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:x]]];
    
        
    }];
    
    [RACObserve(self, viewModel.isfavorited) subscribeNext:^(NSNumber *x) {
        @strongify(self)
        
        if (self.viewModel.isfavorited) {
            
            [self.favoriteBtn setImage:[UIImage imageNamed:@"guanzhu"] forState:UIControlStateNormal];
        }
        else{
            [self.favoriteBtn setImage:[UIImage imageNamed:@"guanzhuan"] forState:UIControlStateNormal];
            
        }
        
        [self.favoriteBtn setTitle:[NSString stringWithFormat:@"关注 %@",self.viewModel.favoritedSize] forState:UIControlStateNormal];
        
         [self.favoriteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        
        [self.commentBtn setTitle:[NSString stringWithFormat:@"评论 %@",self.viewModel.commentSize] forState:UIControlStateNormal];
         [self.commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        
    }];
 
    [RACObserve(self, viewModel.workBgImage) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:x]];
        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            // 处理耗时操作的代码块...
//
//            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:x]]];
//            image  = [self coreBlurImage:image withBlurNumber:10];
//            //通知主线程刷新
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //回调或者说是通知主线程刷新，
//                
//                self.workBgImageView.image = image;
//            });
//            
//        });
        
    }];
    
    
    [RACObserve(self, viewModel.score1) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        if ([x integerValue] > 0) {
            
            [self.score1 setTitle:x forState:UIControlStateNormal];
            [self.score1 setImage:[UIImage imageNamed:@"douban"] forState:UIControlStateNormal];
            
        }
        else{
            
            [self.score1 setTitle:@"暂无" forState:UIControlStateNormal];
            [self.score1 setImage:[UIImage imageNamed:@"douban1"] forState:UIControlStateNormal];
        }
        
        [self.score1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
        
    }];
    [RACObserve(self, viewModel.score2) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        if ([x integerValue] > 0) {
            [self.score2 setTitle:x forState:UIControlStateNormal];
            [self.score2 setImage:[UIImage imageNamed:@"imdb"] forState:UIControlStateNormal];
        }
        else{
            [self.score2 setTitle:@"暂无" forState:UIControlStateNormal];
            [self.score2 setImage:[UIImage imageNamed:@"imdb1"] forState:UIControlStateNormal];
            
        }
        
        [self.score2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
        
    }];
    [RACObserve(self, viewModel.score3) subscribeNext:^(NSString *x) {
        @strongify(self)
        if ([x integerValue] > 0) {
            [self.score3 setTitle:x forState:UIControlStateNormal];
            [self.score3 setImage:[UIImage imageNamed:@"fanqie"] forState:UIControlStateNormal];
        }
        else{
            [self.score3 setTitle:@"暂无" forState:UIControlStateNormal];
            [self.score3 setImage:[UIImage imageNamed:@"fanqie1"] forState:UIControlStateNormal];
        }
        
        
        [self.score3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
        
    }];
    [RACObserve(self, viewModel.score4) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        
        if ([x integerValue] > 0) {
            [self.score4 setImage:[UIImage imageNamed:@"m"] forState:UIControlStateNormal];
            [self.score4 setTitle:x forState:UIControlStateNormal];
        }
        else{
            [self.score4 setImage:[UIImage imageNamed:@"m1"] forState:UIControlStateNormal];
            [self.score4 setTitle:@"暂无" forState:UIControlStateNormal];
        }
        
        
        [self.score4 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        
        
    }];
    
    
    [RACObserve(self, viewModel.topicCellVMs) subscribeNext:^(id x) {
        
        [self.mainTableView reloadData];
        [self.mainTableView.mj_footer endRefreshing];
    }];
    
    [RACObserve(self, viewModel.commentCellVMs) subscribeNext:^(id x) {
        
        [self.mainTableView reloadData];
        
        [self.mainTableView.mj_footer endRefreshing];
    }];
    
    
    [RACObserve(self, viewModel.myCellVMs) subscribeNext:^(id x) {
        
        [self.mainTableView reloadData];
        
        [self.mainTableView.mj_footer endRefreshing];
    }];
    
    
    [[RACSignal combineLatest:@[RACObserve(self, viewModel.descCellHeight),
                                RACObserve(self, viewModel.imagesCellHeight),
                                RACObserve(self, viewModel.directorsCellHeight)]] subscribeNext:^(id x) {
        @strongify(self);
        [self.mainTableView reloadData];
   
        [self.mainTableView.mj_footer endRefreshing];
    }];

}
- (UIImage *)coreBlurImage:(UIImage *)image
           withBlurNumber:(CGFloat)blur {
    //博客园-FlyElephant
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage  *inputImage=[CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.viewModel.filterType == JKFilmDataInfo) {
        
        return 3;
    }
    else if (self.viewModel.filterType == JKFilmDataComment ) {
        
        if (section == 0) {
            
            return self.viewModel.myCellVMs.count;
        }
        else if (section == 1) {
            
            return self.viewModel.topCellVMs.count;
        }
        else if (section == 2) {
            
            return self.viewModel.bottemCellVMs.count;
        }
        else{
            
            if (self.viewModel.commentCellVMs.count > 0) {
                return self.viewModel.commentCellVMs.count;
            }
            else{
                return 1;
            }
            
        }
    }
    else{
        
         return self.viewModel.topicCellVMs.count;
    }
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    if (self.viewModel.filterType == JKFilmDataInfo) {
        
        if (indexPath.row == 0) {

            JKDirectorslistCell *cell=  [[JKDirectorslistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            [cell loadUIWithTitle:@"导演及演员" directors:self.viewModel.directorsArr];
            
            return cell;

        }
        else if (indexPath.row == 1) {
            
            JKWorkDesCell *cell=  [[JKWorkDesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            [cell LoadUIWithTitle:@"简介" desc:self.viewModel.desc descLabelHeight:self.viewModel.descCellHeight - 36 - 40];
            
            return cell;
            
        }
        else{
            
            JKWorkImageListCell *cell=  [[JKWorkImageListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            cell.delegate = self;
            
            [cell LoadUIWithTitle:@"图片" images:self.viewModel.imageArrs descLabelHeight:self.viewModel.imagesCellHeight - 36];
            
            self.contentView = cell.contentImageView;
            
            return cell;
            
        }

    }
    else if (self.viewModel.filterType == JKFilmDataComment ) {
        
        if (indexPath.section == 0) {
            
            JKWorkCommentListCell *cell =  [[JKWorkCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            
            [cell loadDataWithVM: self.viewModel.myCellVMs[indexPath.row]];
            return cell;
        }
        else  if (indexPath.section == 1) {
            
            JKWorkCommentListCell *cell =  [[JKWorkCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            
            [cell loadDataWithVM: self.viewModel.topCellVMs[indexPath.row]];
            return cell;
        }
        else if (indexPath.section == 2) {
            
            JKWorkCommentListCell *cell =  [[JKWorkCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            [cell loadDataWithVM: self.viewModel.bottemCellVMs[indexPath.row]];
            return cell;
        }
        else{
            if (self.viewModel.commentCellVMs.count > 0) {
                JKWorkCommentListCell *cell =  [[JKWorkCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                
                
                //            cellVM.delegate = self;
                [cell loadDataWithVM:self.viewModel.commentCellVMs[indexPath.row]];
                return cell;
            }
            else{
                JKTopicSpareCommentCell *cell =  [[JKTopicSpareCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                
                return cell;
            }
            
            
        }

    }
    else{
        
        JKTopicListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[JKTopicListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        
        [cell loadDataWithVM:self.viewModel.topicCellVMs[indexPath.row]];
        
        
        cell.viewModel.delegate =self;
        
        return cell;

    }
 
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewModel.filterType == JKFilmDataInfo) {
        if (indexPath.row == 0) {
            
            return self.viewModel.directorsCellHeight;
            
        }
        else if (indexPath.row == 1) {
            
            return self.viewModel.descCellHeight;
            
        }
        else{
            
            return self.viewModel.imagesCellHeight;
            
        }
    }
    else if (self.viewModel.filterType == JKFilmDataComment ) {
        
        if (indexPath.section == 0) {
            
            return self.viewModel.myCellVMs[indexPath.row].cellHeight;
        }
        else if (indexPath.section == 1) {
            
            return self.viewModel.topCellVMs[indexPath.row].cellHeight;
        }
        else if (indexPath.section == 2) {
            
            return self.viewModel.bottemCellVMs[indexPath.row].cellHeight;
        }
        else{
            
            
            if (self.viewModel.commentCellVMs.count > 0) {
                
                return self.viewModel.commentCellVMs[indexPath.row].cellHeight;
            }
            else{
                return 80;
            }
        }
    }
    else{
        
        return self.viewModel.topicCellVMs[indexPath.row].cellHeight;
    }


}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (self.viewModel.filterType == JKFilmDataInfo) {
        return 0.01;
    }
    else if (self.viewModel.filterType == JKFilmDataComment ) {
        
        if (self.viewModel.myCellVMs.count == 0) {
            if (section== 0) {
                return 0.01;
            }
        }
        
        if (self.viewModel.topCellVMs.count == 0) {
            if (section== 1) {
                return 0.01;
            }
        }
        
        if (self.viewModel.bottemCellVMs.count == 0) {
            if (section== 2) {
                return 0.01;
            }
        }
        
        return 40;

    }
    else{
        
        return 0.01;
    }
    
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.viewModel.filterType == JKFilmDataInfo) {
        
        return nil;
    }
    else if (self.viewModel.filterType == JKFilmDataComment ) {
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
            
            if (self.viewModel.myCellVMs.count > 0) {
                label.text = @"我的评论";
            }
            else{
                bgView.hidden = YES;
            }
            
        }
        else if (section == 1) {
            
            if (self.viewModel.topCellVMs.count > 0) {
                label.text = @"最客观评论";
            }
            else{
                bgView.hidden = YES;
            }
            
        }
        else if (section == 2) {
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
    else{
        
        return nil;
    }

    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.viewModel.filterType == JKFilmDataInfo) {
        
        return 1;
    }
    else if (self.viewModel.filterType == JKFilmDataComment ) {
        
        return  4;
    }
    else{
        
        return 1;
    }

}



- (void)chooseTopicWithIndex:(NSInteger)index{
    
    [self.headerView changeSelectedUIWithIndex:index];
    
    [self.naviHeaderView changeSelectedUIWithIndex:index];
    
    
    
    if (index == 0) {
        
        self.viewModel.filterType = JKFilmDataInfo;
        
    }
    else if (index == 1) {
        
        self.viewModel.filterType = JKFilmDataComment;
        
    }
    else{
        
        self.viewModel.filterType = JKFilmDataTopic;
        
        
    }
    [self.mainTableView reloadData];
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
-(void)networkImageShow:(NSUInteger)index{
    
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
        NSArray *networkImages=self.viewModel.imageArrs;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
            //源frame
            UIImageView *imageV =(UIImageView *) weakSelf.contentView.subviews[i];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (self.mainTableView.contentOffset.y > 161 ) {
        
          self.naviBgView.hidden = NO;
        
        
        [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        
        [self.shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    }
    else{
          self.naviBgView.hidden = YES;
        
        
        [self.shareBtn setImage:[UIImage imageNamed:@"sharewhite"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"backbai"] forState:UIControlStateNormal];
    }
    
  
    
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
