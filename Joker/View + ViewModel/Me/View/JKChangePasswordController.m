//
//  JKChangePasswordController.m
//  Joker
//
//  Created by 朱彦君 on 2017/10/31.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKChangePasswordController.h"
#import "JKMychangePasswordApi.h"
@interface JKChangePasswordController ()

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
    
    self.navigationItem.rightBarButtonItem = [self customRightButton];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    self.title = @"修改密码";
    
    
    self.oldPassword = [[UITextField alloc]init];
    self.oldPassword.frame = CGRectMake(20, 20, ScreenWidth - 40, 30);
    self.oldPassword.leftViewMode = UITextFieldViewModeAlways ;
    self.oldPassword.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    [self.view addSubview:self.oldPassword];
    self.oldPassword.placeholder = @"输入原密码";
    self.oldPassword.secureTextEntry = YES;
    
    self.password1 = [[UITextField alloc]init];
    self.password1.frame = CGRectMake(20, self.oldPassword.frame.origin.y + self.oldPassword.frame.size.height+ 10 , ScreenWidth - 40, 30);
    self.password1.leftViewMode = UITextFieldViewModeAlways ;
    self.password1.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    [self.view addSubview:self.password1];
    self.password1.placeholder = @"输入新密码";
    self.password1.secureTextEntry = YES;
    
    self.password2 = [[UITextField alloc]init];
    self.password2.frame = CGRectMake(20, self.password1.frame.origin.y + self.password1.frame.size.height+ 10, ScreenWidth - 40, 30);
    self.password2.leftViewMode = UITextFieldViewModeAlways ;
    self.password2.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    [self.view addSubview:self.password2];
    self.password2.placeholder = @"确认新密码";
    self.password2.secureTextEntry = YES;
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
    
    if (self.oldPassword.text.length > 0 && [self.password1.text isEqualToString:self.password2.text] && self.password1.text.length > 0 && self.password2.text.length > 0) {
        
        JKMychangePasswordApi *api = [[JKMychangePasswordApi alloc]initWithOldPassword:self.oldPassword.text andNewPassword:self.password2.text];
        
        [api startWithSuccessBlock:^(__kindof JKMychangePasswordApi *request) {
            
            if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
                
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
