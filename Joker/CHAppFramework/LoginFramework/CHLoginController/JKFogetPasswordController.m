//
//  JKFogetPasswordController.m
//  Joker
//
//  Created by 朱彦君 on 2017/11/26.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKFogetPasswordController.h"
#import "JKSendCodeApi.h"
#import "JKForgetPasswordApi.h"
@interface JKFogetPasswordController ()

@property (nonatomic , strong) UILabel *alertLabel;

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic)  UITextField *username;
@property (strong, nonatomic)  UITextField *codeText;
@property (strong, nonatomic)  UITextField *passwordText;
@property (strong, nonatomic) UITextField *password2Text;
@property (strong, nonatomic) UIButton *sendCodeBtn;
@property (strong, nonatomic) UIButton *nextBtn;

@property (strong, nonatomic) UIButton *gotoLoginBtn;

@end

@implementation JKFogetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"忘记密码";
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
     self.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    self.alertLabel = [[UILabel alloc]init];
    self.alertLabel.frame = CGRectMake(80, 140, ScreenWidth - 160, 30);
    [self.view addSubview:self.alertLabel];
    self.alertLabel.textAlignment = NSTextAlignmentCenter;
    self.alertLabel.text = @"验证身份，重置密码";
    self.alertLabel.font = [UIFont systemFontOfSize:20];
    self.alertLabel.textColor = [JKStyleConfiguration twotwoColor];
    
    
    self.username = [[UITextField alloc]init];
    self.username.font = [JKStyleConfiguration overstrikingFont];;
    self.username.placeholder = @"请输入手机号";
    self.username.frame = CGRectMake(60,self.alertLabel.frame.size.height + self.alertLabel.frame.origin.y + 25 , ScreenWidth - 120 , 20);
    [self.view addSubview:self.username];
    self.username.keyboardType = UIKeyboardTypeNumberPad;
    
    self.sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendCodeBtn.frame = CGRectMake(ScreenWidth - 90,  self.username.frame.origin.y - 4 , 28, 28);
    [self.sendCodeBtn setImage:[UIImage imageNamed:@"sendCode"] forState:UIControlStateNormal];
    [self.sendCodeBtn setTitleColor:[JKStyleConfiguration whiteColor] forState:UIControlStateNormal];
    //    self.sendCodeBtn.backgroundColor = [JKStyleConfiguration twotwoColor];
    self.sendCodeBtn.titleLabel.font = [JKStyleConfiguration hugeFont];
    //    self.sendCodeBtn.layer.cornerRadius = 20;
    //    self.sendCodeBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.sendCodeBtn];
    [self.sendCodeBtn addTarget:self action:@selector(clickSendCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *usernameline = [[UIView alloc]init];
    usernameline.frame = CGRectMake(60, self.username.frame.size.height + self.username.frame.origin.y + 10, ScreenWidth - 120, 1);
    [self.view addSubview:usernameline];
    usernameline.backgroundColor = [JKStyleConfiguration lineColor];
    
    
    self.codeText = [[UITextField alloc]init];
    self.codeText.font = [JKStyleConfiguration overstrikingFont];;
    self.codeText.frame = CGRectMake( 60,usernameline.frame.size.height + usernameline.frame.origin.y + 20 , ScreenWidth - 120 , 20);
    [self.view  addSubview:self.codeText];
    self.codeText.placeholder = @"请输入收到的验证码";
    
    UIView *codeline = [[UIView alloc]init];
    codeline.frame = CGRectMake(60, self.codeText.frame.size.height + self.codeText.frame.origin.y + 10, ScreenWidth - 120, 1);
    [self.view addSubview:codeline];
    codeline.backgroundColor = [JKStyleConfiguration lineColor];
    
    self.passwordText = [[UITextField alloc]init];
    self.passwordText.font = [JKStyleConfiguration overstrikingFont];;
    self.passwordText.frame = CGRectMake( 60,codeline.frame.size.height + codeline.frame.origin.y + 20 , ScreenWidth - 120 , 20);
    [self.view addSubview:self.passwordText];
    self.passwordText.placeholder = @"请输入新登录密码";
    self.passwordText.secureTextEntry = YES;
    
    
    UIView *passwordline = [[UIView alloc]init];
    passwordline.frame = CGRectMake(60, self.passwordText.frame.size.height + self.passwordText.frame.origin.y + 10, ScreenWidth - 120, 1);
    [self.view addSubview:passwordline];
    passwordline.backgroundColor = [JKStyleConfiguration lineColor];
    
    
    self.password2Text = [[UITextField alloc]init];
    self.password2Text.font = [JKStyleConfiguration overstrikingFont];;
    self.password2Text.frame = CGRectMake( 60,passwordline.frame.size.height + passwordline.frame.origin.y + 20 , ScreenWidth - 120 , 20);
    [self.view addSubview:self.password2Text];
    self.password2Text.placeholder = @"再次输入新登录密码";
    self.password2Text.secureTextEntry = YES;
    
    
    UIView *passwordline2 = [[UIView alloc]init];
    passwordline2.frame = CGRectMake(60, self.password2Text.frame.size.height + self.password2Text.frame.origin.y + 10, ScreenWidth - 120, 1);
    [self.view addSubview:passwordline2];
    passwordline2.backgroundColor = [JKStyleConfiguration lineColor];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.nextBtn.frame = CGRectMake(70, passwordline2.frame.origin.y + passwordline2.frame.size.height + 30, ScreenWidth - 140, 40);
    [self.nextBtn setTitleColor:[JKStyleConfiguration whiteColor] forState:UIControlStateNormal];
    self.nextBtn.backgroundColor = [JKStyleConfiguration twotwoColor];
    self.nextBtn.titleLabel.font = [JKStyleConfiguration hugeFont];
    self.nextBtn.layer.cornerRadius = 20;
    self.nextBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.nextBtn];
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.gotoLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.gotoLoginBtn setTitle:@"现在登录 >" forState:UIControlStateNormal];
    self.gotoLoginBtn.frame = CGRectMake(120, self.nextBtn.frame.origin.y + self.nextBtn.frame.size.height + 10, ScreenWidth - 240, 20);
    [self.gotoLoginBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    
    self.gotoLoginBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    [self.view addSubview:self.gotoLoginBtn];
    
    [self.gotoLoginBtn addTarget:self action:@selector(clickGotoLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(UIBarButtonItem*)customLeftBackButton{
    
    ;
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame=CGRectMake(0, 15, 80,50);
    [btn setTitle:@" 返回" forState:UIControlStateNormal];
    btn.titleLabel.font = [JKStyleConfiguration titleFont];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn setAdjustsImageWhenHighlighted:NO];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return backItem;
} // 自定义导航栏按钮

-(void)popself
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickSendCodeBtn{
    
    if (self.username.text.length < 1) {
        
        [CHProgressHUD showPlainText:@"请输入手机号"];
        
        return;
    }
    
    if (self.username.text.length > 11) {
        [CHProgressHUD showPlainText:@"输入手机号错误"];
        
        return;
    }
    
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.sendCodeBtn setImage:[UIImage imageNamed:@"sendCode"] forState:UIControlStateNormal];
                self.sendCodeBtn.backgroundColor = [UIColor clearColor];
                self.sendCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.sendCodeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                self.sendCodeBtn.backgroundColor = [JKStyleConfiguration blackColor];
                [self.sendCodeBtn setTitleColor:[JKStyleConfiguration whiteColor] forState:UIControlStateNormal];
                //设置按钮显示读秒效果
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%.2d", seconds] forState:UIControlStateNormal];
                
                self.sendCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
    
    JKSendCodeApi *api = [[JKSendCodeApi alloc]initWithPhone:self.username.text];
    
    [api startWithSuccessBlock:^(__kindof JKSendCodeApi *request) {
        
        
    } failureBlock:^(__kindof JKSendCodeApi *request) {
        
        
        
    }];
    
}

- (void)clickNextBtn{
    if (self.username.text.length < 1) {
        
        [CHProgressHUD showPlainText:@"请输入手机号"];
        
        return;
    }
    
    if (self.username.text.length > 11) {
        [CHProgressHUD showPlainText:@"输入手机号错误"];
        
        return;
    }
    
    if (self.codeText.text.length == 0) {
        [CHProgressHUD showPlainText:@"输入手机验证码"];
        
        return;
    }
    
    if (self.passwordText.text.length < 8) {
        [CHProgressHUD showPlainText:@"密码为8个字符以上"];
        
        return;
    }
    
    if (![self.passwordText.text isEqualToString:self.password2Text.text]) {
        [CHProgressHUD showPlainText:@"2次密码不一致"];
        
        return;
    }
    
    
    JKForgetPasswordApi *api = [[JKForgetPasswordApi alloc]initWithPhone:self.username.text];
    api.code = self.codeText.text;
    api.password = self.password2Text.text;
    
    [api startWithSuccessBlock:^(__kindof JKForgetPasswordApi *request) {
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            NSDictionary *data = request.response.responseJSONObject[@"data"];
            
            
            [CHProgressHUD showPlainText:@"修改成功"];
   
        }
        else{
            
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        }
    } failureBlock:^(__kindof JKForgetPasswordApi *request) {
        [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        
    }];
    
    
    
}

- (void)clickGotoLoginBtn{
    
    [self.navigationController   popViewControllerAnimated:YES];

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
