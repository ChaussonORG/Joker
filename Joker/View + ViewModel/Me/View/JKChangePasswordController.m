//
//  JKChangePasswordController.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKChangePasswordController.h"
#import "JKMychangePasswordApi.h"
#import "JKUserManager.h"
@interface JKChangePasswordController ()

@property (nonatomic , strong) UILabel *alertLabel;

@property (nonatomic , strong) UIView *passView;

@property (nonatomic , strong) UITextField *oldPassword;

@property (nonatomic , strong) UITextField *password1;

@property (nonatomic , strong) UITextField *password2;

@property (nonatomic , strong) UIButton *nextBtn;

@end

@implementation JKChangePasswordController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBarHidden = NO;
    
//    self.navigationItem.rightBarButtonItem = [self customRightButton];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    
    self.title = @"修改密码";
    
    
    self.alertLabel = [[UILabel alloc]init];
    self.alertLabel.frame = CGRectMake(20, 15, ScreenWidth - 40, 45);
    self.alertLabel.text = @"你正在重新设置登录密码，设置完成后可以通过新密码登录看玩";
    self.alertLabel.numberOfLines = 2;
    [self.view addSubview:self.alertLabel];
    self.alertLabel.font = [JKStyleConfiguration titleFont];
    self.alertLabel.textColor = [JKStyleConfiguration ninenineColor];
    
    self.passView = [[UIView alloc]init];
    self.passView.frame = CGRectMake(0, self.alertLabel.frame.size.height + self.alertLabel.frame.origin.y + 15, ScreenWidth, 152);
    [self.view addSubview:self.passView];
    self.passView.backgroundColor = [JKStyleConfiguration whiteColor];
    
    UILabel *phoneTitleLabel = [[UILabel alloc]init];
    phoneTitleLabel.frame = CGRectMake(25, 15, 80, 20);
    [self.passView addSubview:phoneTitleLabel];
    phoneTitleLabel.text = @"手机号";
    phoneTitleLabel.font = [JKStyleConfiguration overstrikingFont];
    phoneTitleLabel.textColor = [JKStyleConfiguration ninenineColor];
    
    self.oldPassword = [[UITextField alloc]init];
    self.oldPassword.frame = CGRectMake(130, 15, ScreenWidth - 180, 25);
    self.oldPassword.leftViewMode = UITextFieldViewModeAlways ;
    self.oldPassword.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    [self.passView addSubview:self.oldPassword];
    NSMutableString *password  = [[NSMutableString alloc]initWithString:[JKUserManager sharedData].currentUser.username];
    [password replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.oldPassword.placeholder = password;
    self.oldPassword.secureTextEntry = YES;
    self.oldPassword.userInteractionEnabled = NO;
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [JKStyleConfiguration lineColor];
    [self.passView addSubview:line1];
    line1.frame = CGRectMake(25, phoneTitleLabel.frame.origin.y + phoneTitleLabel.frame.size.height + 15, ScreenWidth - 50, 1);
    
    
    UILabel *passwordTitleLabel = [[UILabel alloc]init];
    passwordTitleLabel.frame = CGRectMake(25, line1.frame.origin.y + 1 + 15, 80, 20);
    [self.passView addSubview:passwordTitleLabel];
    passwordTitleLabel.text = @"新密码(8个字符)";
    passwordTitleLabel.font = [JKStyleConfiguration overstrikingFont];
    passwordTitleLabel.textColor = [JKStyleConfiguration ninenineColor];
    
    self.password1 = [[UITextField alloc]init];
    self.password1.frame = CGRectMake(130, passwordTitleLabel.frame.origin.y, ScreenWidth - 180, 25);
    self.password1.leftViewMode = UITextFieldViewModeAlways ;
    self.password1.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    [self.passView addSubview:self.password1];
    self.password1.placeholder = @"请输入新登录密码";
    self.password1.secureTextEntry = YES;
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [JKStyleConfiguration lineColor];
    [self.passView addSubview:line2];
    line2.frame = CGRectMake(25, passwordTitleLabel.frame.origin.y + passwordTitleLabel.frame.size.height + 15, ScreenWidth - 50, 1);
    
    
    UILabel *password2TitleLabel = [[UILabel alloc]init];
    password2TitleLabel.frame = CGRectMake(25, line2.frame.origin.y + 1 + 15, 80, 20);
    [self.passView addSubview:password2TitleLabel];
    password2TitleLabel.text = @"确认新密码";
    password2TitleLabel.font = [JKStyleConfiguration overstrikingFont];
    password2TitleLabel.textColor = [JKStyleConfiguration ninenineColor];
    
    
    self.password2 = [[UITextField alloc]init];
    self.password2.frame = CGRectMake(130, password2TitleLabel.frame.origin.y, ScreenWidth - 180, 25);
    self.password2.leftViewMode = UITextFieldViewModeAlways ;
    self.password2.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    [self.passView addSubview:self.password2];
    self.password2.placeholder = @"再次输入新登录密码";
    self.password2.secureTextEntry = YES;
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame=CGRectMake(25, self.passView.frame.origin.y + self.passView.frame.size.height + 20, ScreenWidth - 50,40);
    self.nextBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.nextBtn setAdjustsImageWhenHighlighted:NO];
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.userInteractionEnabled = YES;
    [self.nextBtn setTitleColor:[JKStyleConfiguration whiteColor] forState:UIControlStateNormal];
    self.nextBtn.backgroundColor = [JKStyleConfiguration twotwoColor];
    [self.nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 20;
    self.nextBtn.layer.masksToBounds =  YES;
    [self.view addSubview:self.nextBtn];
    self.nextBtn.titleLabel.font = [JKStyleConfiguration hugeFont];
    // Do any additional setup after loading the view.
}
-(UIBarButtonItem*)customRightButton{
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame=CGRectMake(15, 15, 48,23);
    self.nextBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.nextBtn setAdjustsImageWhenHighlighted:NO];
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.userInteractionEnabled = YES;
    [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
    [self.nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
    self.nextBtn.layer.borderWidth = 1;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.nextBtn];
    
    return backItem;
    
    
}

- (void)clickNextBtn{
    
    if (self.password1.text.length < 8) {
        
        [CHProgressHUD showPlainText:@"请输入8位密码"];
        return;
    }
    
    if (self.password2.text.length < 8) {
        
        [CHProgressHUD showPlainText:@"请输入8位密码"];
        return;
    }
    
    if ( [self.password1.text isEqualToString:self.password2.text] && self.password1.text.length > 0 && self.password2.text.length > 0) {
        
        JKMychangePasswordApi *api = [[JKMychangePasswordApi alloc]initWithOldPassword:self.oldPassword.text andNewPassword:self.password2.text];
        
        [api startWithSuccessBlock:^(__kindof JKMychangePasswordApi *request) {
            
            if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
                [CHProgressHUD showPlainText:@"修改成功"];
                [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
                
            }
            else{
                
                [CHProgressHUD showPlainText:request.response.responseJSONObject[@"data"]];
            }
            
        } failureBlock:^(__kindof JKMychangePasswordApi *request) {
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
            
        }];
        
        
        
    }
    else{
        
        [CHProgressHUD showPlainText:@"请填写密码"];
        
        return;
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
