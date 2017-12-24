//
//  JKPersonInfoHeaderController.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonInfoHeaderController.h"
#import "JKProfileApi.h"
#import "CHImagePicker.h"
#import "HHTUserEditModel.h"
#import "JKUserManager.h"
@interface JKPersonInfoHeaderController ()
@property (nonatomic , strong) UIButton *nextBtn;

@property (nonatomic , strong) UIImageView *headerView;
@end

@implementation JKPersonInfoHeaderController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.rightBarButtonItem = [self customRightButton];
  
}

-(UIBarButtonItem*)customRightButton{
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame=CGRectMake(30, 15, 48,23);
    self.nextBtn.titleLabel.font = [JKStyleConfiguration hugeFont];
    [self.nextBtn setAdjustsImageWhenHighlighted:NO];
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.userInteractionEnabled = YES;
    [self.nextBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    [self.nextBtn setTitle:@"..." forState:UIControlStateNormal];
//    self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
//    self.nextBtn.layer.borderWidth = 1;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.nextBtn];
    self.nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    return backItem;
    
    
}

- (void)clickNextBtn{
    @weakify(self)
    [CHImagePicker show:YES picker:self completion:^(UIImage *image) {
        @strongify(self)
        @weakify(self)
        [HHTUserEditModel updateAvatarBuy:image success:^(SDBaseResponse *userInfo) {
            @strongify(self);
            
            NSArray *array = (NSArray *)userInfo.data;
            
            NSDictionary *data = [array objectAtIndex:0];
            
            NSString *imageUrl = [data objectForKey:@"url"];
            
            JKUser *user= [[JKUserManager sharedData].currentUser copy];
            user.photo = imageUrl;
            [[JKUserManager sharedData] saveUserWithJKUser:user];
            
            self.headerView.image = image;
            
        } failed:^{
            
        }];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人头像";
    
    self.view.backgroundColor = [JKStyleConfiguration twotwoColor];
    
    self.headerView = [[UIImageView alloc]init];
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.headerView.contentMode = UIViewContentModeScaleAspectFit;
    self.headerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    [self.view addSubview:self.headerView]; 
    
    // Do any additional setup after loading the view.
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
