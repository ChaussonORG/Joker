//
//  JKTopicRelatedWorksListController.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/18.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicRelatedWorksListController.h"
#import "JKFilmCollectionViewCell.h"
@interface JKTopicRelatedWorksListController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property (nonatomic , strong) UIView *searchView;

@property (nonatomic , strong) UISearchBar *searchBar;

@property (nonatomic , strong) UILabel *subTitleLabel;

@property (nonatomic , strong) UIImageView *lineView;

@property (nonatomic , strong) UICollectionView *collectionView;

@end

@implementation JKTopicRelatedWorksListController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.viewModel = [[JKTopicRelatedWorksListVM alloc]init];
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关联作品";
    
    [self.viewModel reloadData];
    
    self.searchView = [[UIView alloc]init];
    [self.view addSubview:self.searchView];
    self.searchView.frame = CGRectMake(0, 0, ScreenWidth, 100);
    self.searchView.backgroundColor = [JKStyleConfiguration grayBackgroundColor];
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.frame = CGRectMake(15, 20, ScreenWidth - 30, 34);
    self.searchBar.backgroundColor = [JKStyleConfiguration whiteColor];
    self.searchBar.placeholder = @"搜索作品";
    [self.searchView addSubview:self.searchBar];
    self.searchBar.delegate = self;
    
    self.lineView = [[UIImageView alloc]init];
    self.lineView.frame = CGRectMake(90, self.searchBar.frame.origin.y + self.searchBar.frame.size.height + 25, ScreenWidth - 180, 2);
    [self.searchView addSubview:self.lineView];
    self.lineView.backgroundColor = [JKStyleConfiguration lineColor];
    
    self.subTitleLabel = [[UILabel alloc]init];
    self.subTitleLabel.text = @"我关注的作品";
    self.subTitleLabel.frame = CGRectMake(145, self.searchBar.frame.size.height + self.searchBar.frame.origin.y, ScreenWidth - 290, 50);
    [self.searchView addSubview:self.subTitleLabel];
    self.subTitleLabel.backgroundColor = [JKStyleConfiguration grayBackgroundColor];
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.textColor = [JKStyleConfiguration blackColor];
    self.subTitleLabel.font = [JKStyleConfiguration subcontentFont];
    
    
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, self.searchView.frame.origin.y + self.searchView.frame.size.height, [UIScreen mainScreen].bounds.size.width, ScreenHeight - (self.searchView.frame.origin.y + self.searchView.frame.size.height) - 64) collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.backgroundColor = [JKStyleConfiguration whiteColor];
    [_collectionView registerClass:[JKFilmCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
    
    [self binding];
    // Do any additional setup after loading the view.
}

- (void)binding{
    
    @weakify(self)
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(NSString *x) {
        @strongify(self)
        
        [self.collectionView reloadData];
    }];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.viewModel.cellViewModels.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"UICollectionViewCell";
    JKFilmCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell loadDataWithVM:self.viewModel.cellViewModels[indexPath.row]];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 80)/3, 185);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
     
    [self.viewModel fetchSearchKeywords:searchText];
 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.searchBar resignFirstResponder];
    
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
