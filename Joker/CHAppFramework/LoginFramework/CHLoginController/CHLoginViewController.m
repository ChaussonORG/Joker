//
//  CHLoginViewController.m
//
//  Created by Chausson on 15/11/4.
//  Copyright © Chausson. All rights reserved.
//

#import "CHUserInfoModel.h"
#import "CHLoginViewController.h"
#import "CHLoginModalController.h"
#import "SDLoginAPI.h"
#import "CHSocialServiceCenter.h"
#import "SDAuthorLoginAPI.h"
#import "JKUserManager.h"
#import <CHProgressHUD/CHProgressHUD.h>
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "JKSendCodeApi.h"
#import "JKPerfectUserInfoController.h"
#import "JKRegisterApi.h"
#define UINAVGATIONHEIGHT 64
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CHLoginViewController ()

@property (nonatomic , strong) UIButton *changePassBtn;

@property (nonatomic , strong) UIButton *changeregistPassBtn;

@end

@implementation CHLoginViewController{
   
}
#pragma mark init

#pragma mark Activity
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.backBtn.frame = CGRectMake(15, 33, 20, 20);
    [self.view addSubview:self.backBtn];
    
    
    
    [self setUploginViews];
    
    [self setUpRegisterViews];
    
    self.logoView = [[UIImageView alloc]init];
    self.logoView.frame = CGRectMake((ScreenWidth - 60)/2, 125, 70, 70);
    [self.view addSubview:self.logoView];
    self.logoView.image = [UIImage imageNamed:@"jokericon"];
    self.logoView.contentMode = UIViewContentModeScaleAspectFill;
    self.logoView.layer.cornerRadius = 35;
    self.logoView.layer.masksToBounds = YES;
    
    
    [CHProgressHUD setTextDuration:0.8];
//    [self loadUI];
    [self regisetButtonAction];

}

- (void)setUpRegisterViews{
    self.registerbgView= [[UIView alloc]init];
    self.registerbgView.backgroundColor = [JKStyleConfiguration whiteColor];
    self.registerbgView.frame = CGRectMake(25, 155, ScreenWidth - 50, 360);
    [self.view addSubview:self.registerbgView];
    
    self.registerbgView.hidden = YES;
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"欢迎来到看玩";
    titleLabel.textColor = [JKStyleConfiguration twotwoColor];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.registerbgView addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0, 50, self.registerbgView.frame.size.width, 30);
    
   
    self.registerUsername = [[UITextField alloc]init];
    self.registerUsername.font = [JKStyleConfiguration overstrikingFont];;
    self.registerUsername.placeholder = @"手机号";
    self.registerUsername.frame = CGRectMake(30,titleLabel.frame.size.height + titleLabel.frame.origin.y + 25 , 200 , 20);
    [self.registerbgView addSubview:self.registerUsername];
    self.registerUsername.keyboardType = UIKeyboardTypeNumberPad;
    
    self.sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendCodeBtn.frame = CGRectMake(self.registerbgView.frame.size.width - 28 - 30,  self.registerUsername.frame.origin.y - 4 , 28, 28);
    [self.sendCodeBtn setImage:[UIImage imageNamed:@"sendCode"] forState:UIControlStateNormal];
    [self.sendCodeBtn setTitleColor:[JKStyleConfiguration whiteColor] forState:UIControlStateNormal];
//    self.sendCodeBtn.backgroundColor = [JKStyleConfiguration twotwoColor];
    self.sendCodeBtn.titleLabel.font = [JKStyleConfiguration hugeFont];
//    self.sendCodeBtn.layer.cornerRadius = 20;
//    self.sendCodeBtn.layer.masksToBounds = YES;
    [self.registerbgView addSubview:self.sendCodeBtn];
    [self.sendCodeBtn addTarget:self action:@selector(clickSendCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *usernameline = [[UIView alloc]init];
    usernameline.frame = CGRectMake(self.registerUsername.frame.origin.x, self.registerUsername.frame.size.height + self.registerUsername.frame.origin.y + 10, self.loginbgView.frame.size.width - 2 * self.registerUsername.frame.origin.x, 1);
    [self.registerbgView addSubview:usernameline];
    usernameline.backgroundColor = [JKStyleConfiguration lineColor];
   
    
    self.registerCodeText = [[UITextField alloc]init];
    self.registerCodeText.font = [JKStyleConfiguration overstrikingFont];;
    self.registerCodeText.frame = CGRectMake( 30,usernameline.frame.size.height + usernameline.frame.origin.y + 20 , 200 , 20);
    [self.registerbgView addSubview:self.registerCodeText];
    self.registerCodeText.placeholder = @"收到的验证码";
    
    UIView *codeline = [[UIView alloc]init];
    codeline.frame = CGRectMake(self.registerCodeText.frame.origin.x, self.registerCodeText.frame.size.height + self.registerCodeText.frame.origin.y + 10, self.loginbgView.frame.size.width - 2 * self.registerCodeText.frame.origin.x, 1);
    [self.registerbgView addSubview:codeline];
    codeline.backgroundColor = [JKStyleConfiguration lineColor];
    
    self.registerPassWordText = [[UITextField alloc]init];
    self.registerPassWordText.font = [JKStyleConfiguration overstrikingFont];;
    self.registerPassWordText.frame = CGRectMake( 30,codeline.frame.size.height + codeline.frame.origin.y + 20 , 200 , 20);
    [self.registerbgView addSubview:self.registerPassWordText];
    self.registerPassWordText.placeholder = @"密码(8个字符以上)";
    self.registerPassWordText.secureTextEntry = YES;
    
    self.changeregistPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeregistPassBtn.frame = CGRectMake(self.registerbgView.frame.size.width - 20 - 40, self.registerPassWordText.frame.origin.y, 40, 20);
    [self.changeregistPassBtn setTitle:@"显示" forState:UIControlStateNormal];
    [self.changeregistPassBtn setTitle:@"隐藏" forState:UIControlStateSelected];
    [self.changeregistPassBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.changeregistPassBtn.titleLabel.font = [JKStyleConfiguration overstrikingFont];
    [self.registerbgView addSubview:self.changeregistPassBtn];
    [self.changeregistPassBtn addTarget:self action:@selector(clickChangeRegisterPassBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *passwordline = [[UIView alloc]init];
    passwordline.frame = CGRectMake(self.registerPassWordText.frame.origin.x, self.registerPassWordText.frame.size.height + self.registerPassWordText.frame.origin.y + 10, self.loginbgView.frame.size.width - 2 * self.registerPassWordText.frame.origin.x, 1);
    [self.registerbgView addSubview:passwordline];
    passwordline.backgroundColor = [JKStyleConfiguration lineColor];
    
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.frame = CGRectMake(40, passwordline.frame.origin.y + passwordline.frame.size.height + 30, self.registerbgView.frame.size.width - 80, 40);
    [self.nextBtn setTitleColor:[JKStyleConfiguration whiteColor] forState:UIControlStateNormal];
    self.nextBtn.backgroundColor = [JKStyleConfiguration twotwoColor];
    self.nextBtn.titleLabel.font = [JKStyleConfiguration hugeFont];
    self.nextBtn.layer.cornerRadius = 20;
    self.nextBtn.layer.masksToBounds = YES;
    [self.registerbgView addSubview:self.nextBtn];
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.haveAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.haveAccountBtn setTitle:@"已有账号 >" forState:UIControlStateNormal];
    self.haveAccountBtn.frame = CGRectMake(120, self.nextBtn.frame.origin.y + self.nextBtn.frame.size.height + 10, self.registerbgView.frame.size.width - 240, 20);
    [self.haveAccountBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    
    self.haveAccountBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    [self.registerbgView addSubview:self.haveAccountBtn];

    [self.haveAccountBtn addTarget:self action:@selector(clickHaveAccountBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)clickChangePassBtn:(UIButton *)sender{
    
    self.changePassBtn.selected  =  !self.changePassBtn.selected;
    
    
    if (self.changePassBtn.selected) {
        
        self.passWordText.secureTextEntry = NO;
    }
    else{
        
        self.passWordText.secureTextEntry = YES;
        
    }
    
    
}


- (void)clickChangeRegisterPassBtn:(UIButton *)sender{
    
    self.changeregistPassBtn.selected  =  !self.changeregistPassBtn.selected;
    
    
    if (self.changeregistPassBtn.selected) {
        
        self.registerPassWordText.secureTextEntry = NO;
    }
    else{
        
        self.registerPassWordText.secureTextEntry = YES;
        
    }
    
    
}

- (void)clickNextBtn{
    
    if (self.registerUsername.text.length < 1) {
        
        [CHProgressHUD showPlainText:@"请输入手机号"];
        
        return;
    }
    
    if (self.registerUsername.text.length > 11) {
        [CHProgressHUD showPlainText:@"输入手机号错误"];
        
        return;
    }
    
    if (self.registerCodeText.text.length == 0) {
        [CHProgressHUD showPlainText:@"输入手机验证码"];
        
        return;
    }
    
    if (self.registerPassWordText.text.length < 8) {
        [CHProgressHUD showPlainText:@"密码为8个字符以上"];
        
        return;
    }
    
    
    JKRegisterApi *api = [[JKRegisterApi alloc]initWithPhone:self.registerUsername.text];
    api.code = self.registerCodeText.text;
    api.password = self.registerPassWordText.text;
    
    [api startWithSuccessBlock:^(__kindof JKRegisterApi *request) {
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            NSDictionary *data = request.response.responseJSONObject[@"data"];
             
            
            [self gotoPerfectInfoWithData:data];
        }
        else{
            
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        }
    } failureBlock:^(__kindof JKRegisterApi *request) {
        
        
    }];
 
    
    
}

- (void)gotoPerfectInfoWithData:(NSDictionary *)data{
     
    JKPerfectUserInfoController *vc = [[JKPerfectUserInfoController alloc]init];
    vc.phone = self.registerUsername.text;
    vc.code = self.registerCodeText.text;
    vc.data = data;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickSendCodeBtn{
    
    if (self.registerUsername.text.length < 1) {
        
        [CHProgressHUD showPlainText:@"请输入手机号"];
        
        return;
    }
    
    if (self.registerUsername.text.length > 11) {
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
    
 
    
    
    
    JKSendCodeApi *api = [[JKSendCodeApi alloc]initWithPhone:self.registerUsername.text];
    
    [api startWithSuccessBlock:^(__kindof JKSendCodeApi *request) {
        
        
    } failureBlock:^(__kindof JKSendCodeApi *request) {
        
        
        
    }];
}
- (void)clickHaveAccountBtn{
    
    self.registerbgView.hidden = YES;
    
    self.loginbgView.hidden = NO;
    
    self.weiboLoginBtn.hidden = NO;
    
    self.wechatLoginBtn.hidden = NO;
    
    self.disanfangline.hidden = NO;
}

- (void)clickRegisterBtn{
    
    self.registerbgView.hidden = NO;
    
    self.loginbgView.hidden = YES;
    
    self.weiboLoginBtn.hidden = YES;
    
    self.wechatLoginBtn.hidden = YES;
    
    self.disanfangline.hidden = YES;
}
- (void)setUploginViews{
    
    self.loginbgView= [[UIView alloc]init];
    self.loginbgView.backgroundColor = [JKStyleConfiguration whiteColor];
    self.loginbgView.frame = CGRectMake(25, 155, ScreenWidth - 50, 320);
    [self.view addSubview:self.loginbgView];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"欢迎来到看玩";
    titleLabel.textColor = [JKStyleConfiguration twotwoColor];
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.loginbgView addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0, 50, self.loginbgView.frame.size.width, 30);
    
    UILabel *photoLabel = [[UILabel alloc]init];
    photoLabel.text = @"手机号";
    photoLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    photoLabel.font = [JKStyleConfiguration overstrikingFont];;
    photoLabel.textAlignment = NSTextAlignmentCenter;
    [self.loginbgView addSubview:photoLabel];
    photoLabel.frame = CGRectMake(30, titleLabel.frame.size.height + titleLabel.frame.origin.y + 25, 50 , 20);
    
    photoLabel.frame = CGRectMake(30, titleLabel.frame.size.height + titleLabel.frame.origin.y + 25, 0 , 20);
    photoLabel.hidden = YES;
    
    self.username = [[UITextField alloc]init];
    self.username.font = [JKStyleConfiguration overstrikingFont];;
    self.username.frame = CGRectMake(photoLabel.frame.origin.x + photoLabel.frame.size.width + 30, photoLabel.frame.origin.y , 200 , 20);
    [self.loginbgView addSubview:self.username];
    self.username.keyboardType = UIKeyboardTypeNumberPad;
    self.username.placeholder  =@"手机号";
    self.username.frame = CGRectMake(30,titleLabel.frame.size.height + titleLabel.frame.origin.y + 25 , 200 , 20);
    
    UIView *usernameline = [[UIView alloc]init];
    usernameline.frame = CGRectMake(photoLabel.frame.origin.x, photoLabel.frame.size.height + photoLabel.frame.origin.y + 10, self.loginbgView.frame.size.width - 2 * photoLabel.frame.origin.x, 1);
    [self.loginbgView addSubview:usernameline];
    usernameline.backgroundColor = [JKStyleConfiguration lineColor];
    usernameline.frame = CGRectMake(photoLabel.frame.origin.x, photoLabel.frame.size.height + photoLabel.frame.origin.y + 10, self.loginbgView.frame.size.width - 2 * photoLabel.frame.origin.x, 1);
    
    
    UILabel *passwordLabel = [[UILabel alloc]init];
    passwordLabel.text = @"密码";
    passwordLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
    passwordLabel.font = [JKStyleConfiguration overstrikingFont];;
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    [self.loginbgView addSubview:passwordLabel];
    passwordLabel.frame = CGRectMake(30, usernameline.frame.size.height + usernameline.frame.origin.y + 20, 50 , 20);
    passwordLabel.hidden= YES;
    
    self.passWordText = [[UITextField alloc]init];
    self.passWordText.font = [JKStyleConfiguration overstrikingFont];;
    self.passWordText.frame = CGRectMake(passwordLabel.frame.origin.x + passwordLabel.frame.size.width + 30, passwordLabel.frame.origin.y , 200 , 20);
    [self.loginbgView addSubview:self.passWordText];
    self.passWordText.placeholder  =@"密码";
    self.passWordText.frame = CGRectMake( 30,usernameline.frame.size.height + usernameline.frame.origin.y + 20 , 200 , 20);
    self.passWordText.secureTextEntry = YES;
    
    self.changePassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changePassBtn.frame = CGRectMake(self.loginbgView.frame.size.width - 20 - 40, self.passWordText.frame.origin.y, 40, 20);
    [self.changePassBtn setTitle:@"显示" forState:UIControlStateNormal];
    [self.changePassBtn setTitle:@"隐藏" forState:UIControlStateSelected];
    [self.changePassBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.changePassBtn.titleLabel.font = [JKStyleConfiguration overstrikingFont];
    [self.loginbgView addSubview:self.changePassBtn];
    [self.changePassBtn addTarget:self action:@selector(clickChangePassBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *passwordline = [[UIView alloc]init];
    passwordline.frame = CGRectMake(passwordLabel.frame.origin.x, passwordLabel.frame.size.height + passwordLabel.frame.origin.y + 10, self.loginbgView.frame.size.width - 2 * photoLabel.frame.origin.x, 1);
    [self.loginbgView addSubview:passwordline];
    passwordline.backgroundColor = [JKStyleConfiguration lineColor];
    
    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.forgetBtn.frame = CGRectMake(self.loginbgView.frame.size.width - 60 - 30, passwordline.frame.origin.y + passwordline.frame.size.height + 5, 60, 25);
    [self.forgetBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    self.forgetBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.loginbgView addSubview:self.forgetBtn];
    
    
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.frame = CGRectMake(40, self.forgetBtn.frame.origin.y + self.forgetBtn.frame.size.height + 15, self.loginbgView.frame.size.width - 80, 40);
    [self.loginBtn setTitleColor:[JKStyleConfiguration whiteColor] forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [JKStyleConfiguration twotwoColor];
    self.loginBtn.titleLabel.font = [JKStyleConfiguration hugeFont];
    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginbgView addSubview:self.loginBtn];
    
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerBtn setTitle:@"注册看玩 >" forState:UIControlStateNormal];
    self.registerBtn.frame = CGRectMake(120, self.loginBtn.frame.origin.y + self.loginBtn.frame.size.height + 10, self.loginbgView.frame.size.width - 240, 20);
    [self.registerBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
   
    self.registerBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    [self.loginbgView addSubview:self.registerBtn];
    
    [self.registerBtn addTarget:self action:@selector(clickRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.disanfangline = [[UILabel alloc]init];
     self.disanfangline.frame = CGRectMake(0, ScreenHeight - 100 - 20, ScreenWidth, 20);
     self.disanfangline.text = @" - 使用其他账号登录 - ";
     self.disanfangline.textColor = [JKStyleConfiguration aaaaaaColor];
     self.disanfangline.font = [JKStyleConfiguration contentFont];
    [self.view addSubview: self.disanfangline];
     self.disanfangline.textAlignment = NSTextAlignmentCenter;
    
    self.weiboLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weiboLoginBtn.frame = CGRectMake((ScreenWidth - 30)/2 - 50,  self.disanfangline.frame.origin.y +  self.disanfangline.frame.size.height + 15, 50, 50);
    self.weiboLoginBtn.layer.cornerRadius = 25;
    self.weiboLoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.weiboLoginBtn];
    [self.weiboLoginBtn setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
    
    
    
    self.wechatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wechatLoginBtn.frame = CGRectMake(ScreenWidth/2 + 15, self.weiboLoginBtn.frame.origin.y , 50, 50);
    self.wechatLoginBtn.layer.cornerRadius = 25;
    self.wechatLoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.weiboLoginBtn];
    [self.wechatLoginBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [self.view addSubview:self.wechatLoginBtn];
    
    
    
    
    
    self.qqLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem ];
    [self.qqLoginBtn setImage:[[UIImage imageNamed:@"qqLogin"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    
    [self.view addSubview:self.qqLoginBtn];
    
    self.qqLoginBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 + 20, [UIScreen mainScreen].bounds.size.height - 20 - 44 , 44, 44);
    
//    self.wechatLoginBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 44 - 20, [UIScreen mainScreen].bounds.size.height - 20 - 44 , 44, 44);
//    
    
}
- (void)loadUI
{
//    self.username.layer.borderColor = [JKStyleConfiguration lineColor].CGColor;
//    self.username.layer.borderWidth = 1;
//    
//    self.passWordText.layer.borderColor = [JKStyleConfiguration lineColor].CGColor;
//    self.passWordText.layer.borderWidth = 1;
 

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:TRUE];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
 
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:FALSE];
}
#pragma mark Private
- (void)regisetButtonAction{
    @weakify(self);
//    if (self.registerBtn) {
//        [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//            @strongify(self);
//            [self regisetAction:x];
//        }];
//    }

    if (self.backBtn) {
        self.backBtn.hidden = self.loginModalViewController.needBackButton;
        [[self.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self backForword:x];
        }];
    }
    if (self.forgetBtn) {
        [[self.forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self resetPassword:x];
        }];
    }
    if (self.loginBtn) {
        RACSignal *validUser = [RACSignal
                                combineLatest:@[[self.username rac_textSignal],
                                                [self.passWordText rac_textSignal],
                                                ]
                                reduce:^(NSString *username, NSString *password){
                                    return @(username.length >= 11 && password.length >= 8 );
                                }];
        [validUser subscribeNext:^(NSNumber *value) {
            @strongify(self);
//           self.loginBtn.backgroundColor = [value boolValue]?kUIColorFromRGB(0xFFDD56):kUIColorFromRGB(0xFFEB99);
            UIColor *color = [value boolValue]?[JKStyleConfiguration whiteColor]:kUIColorFromRGB(0x9C9C9C);
//            self.loginBtn.tintColor = [value boolValue]?kUIColorFromRGB(0x484848):kUIColorFromRGB(0x9C9C9C);
            
            [self.loginBtn setTitleColor:color forState:UIControlStateNormal];
        }];
        self.loginBtn.rac_command = [[RACCommand alloc]initWithEnabled:validUser signalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self login];
            return [RACSignal empty];
        }];
    }
    
    if (self.qqLoginBtn) {
        [[self.qqLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self qqLogin:x];
        }];
    }
    if (self.wechatLoginBtn) {
        [[self.wechatLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self weChatLogin:x];
        }];
    }
}

// 登录响应事件
- (void)login{
    [CHProgressHUD show:YES];
    SDLoginAPI *login = [[SDLoginAPI alloc]initWithAccount:self.username.text password:self.passWordText.text];
    [login startWithSuccessBlock:^(__kindof SDLoginAPI *request) {
        if (request.baseResponse.code == 200 ) {
            [CHProgressHUD hide:YES];
            if (self.loginModalViewController) {
                if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_willCompletionWithSuccess:)]) {
                    [self.loginModalViewController.delegate ch_willCompletionWithSuccess:request.baseResponse.data];
                }
                [self.loginModalViewController dismissViewControllerAnimated:YES completion:^{
                    if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithSuccessful:)]) {
                        [self.loginModalViewController.delegate ch_completionLoginWithSuccessful:request.baseResponse.data];
                    }
                }];
            }
        }else{
            NSString *message = request.baseResponse.message;

            [CHProgressHUD hideWithText:message animated:YES];
            CHLLog(@"Login Message = %@",message);
            NSError *failureError = [[NSError alloc]initWithDomain:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__] code:request.baseResponse.code userInfo:@{@"message":message}];
            if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithFailur:)]) {
                [self.loginModalViewController.delegate ch_completionLoginWithFailur:failureError];
            }

        }
    } failureBlock:^(__kindof CHBaseRequest *request) {
        [CHProgressHUD hideWithText:@"网络连接失败,请重新尝试" animated:YES];
        if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithFailur:)]) {
            [self.loginModalViewController.delegate ch_completionLoginWithFailur:request.response.error];
        }
    }];
    
}

- (void)qqLogin:(UIButton *)button
{
    [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialQQ controller:self completion:^(CHSocialResponseData *response) {
        if (response.openId && response.accessToken) {
            SDAuthorLoginAPI *api = [[SDAuthorLoginAPI alloc] initWithOpenID:response.openId accessToken:response.accessToken type:SDAuthorQQ];
            [api startWithSuccessBlock:^(__kindof SDAuthorLoginAPI *request) {
                if (request.baseResponse.code == 200 ) {
                    [CHProgressHUD hide:YES];
                    NSString *cellphone = [self convertNull: request.response.responseJSONObject[@"data"][@"profile"][@"cellphone"]];
                    if ([cellphone isEqualToString:@" "] || [cellphone isEqualToString:@"无"]) {
                        
                        
//                        TOYBindPhoneController *vc = [[TOYBindPhoneController alloc]init];
//                        
//                        [vc.viewModel fetchToken:response.accessToken];
//                        
//                        [vc.viewModel fetchLoginType:TOYQQLogin];
//                        
//                        [vc.viewModel fetchUserId:request.response.responseJSONObject[@"data"][@"profile"][@"userId"]];
//                        
//                        [self.navigationController pushViewController:vc animated:YES];
                        [CHProgressHUD showPlainText:@"暂无绑定"];
                    }
                    else{
                        if (self.loginModalViewController) {
                            if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_willCompletionWithSuccess:)]) {
                                [self.loginModalViewController.delegate ch_willCompletionWithSuccess:request.baseResponse.data];
                            }
                            [self.loginModalViewController dismissViewControllerAnimated:YES completion:^{
                                if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithSuccessful:)]) {
                                    [self.loginModalViewController.delegate ch_completionLoginWithSuccessful:request.baseResponse.data];
                                }
                            }];
                        }
                    }
                    
                }
                else{
                    NSString *message = request.baseResponse.message;
                    
                    [CHProgressHUD hideWithText:message animated:YES];
                    CHLLog(@"Login Message = %@",message);
                    NSError *failureError = [[NSError alloc]initWithDomain:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__] code:request.baseResponse.code userInfo:@{@"message":message}];
                    if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithFailur:)]) {
                        [self.loginModalViewController.delegate ch_completionLoginWithFailur:failureError];
                    }
                    
                }
                

            } failureBlock:^(__kindof CHBaseRequest *request) {
                [CHProgressHUD hideWithText:@"网络连接失败,请重新尝试" animated:YES];
                if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithFailur:)]) {
                    [self.loginModalViewController.delegate ch_completionLoginWithFailur:request.response.error];
                }
            }];
        }
        
    }];
}
- (void)weChatLogin:(UIButton *)button
{
    [[CHSocialServiceCenter shareInstance]loginInAppliactionType:CHSocialWeChat controller:self completion:^(CHSocialResponseData *response) {
        if (response.openId && response.accessToken) {
            SDAuthorLoginAPI *api = [[SDAuthorLoginAPI alloc] initWithOpenID:response.openId accessToken:response.accessToken type:SDAuthorWeChat];
            [api startWithSuccessBlock:^(__kindof SDAuthorLoginAPI *request) {
                if (request.baseResponse.code == 200 ) {
                    [CHProgressHUD hide:YES];
                    
                    NSString *cellphone = [self convertNull: request.response.responseJSONObject[@"data"][@"profile"][@"cellphone"]];
                    if ([cellphone isEqualToString:@" "] || [cellphone isEqualToString:@"无"]) {
//                    
//                        TOYBindPhoneController *vc = [[TOYBindPhoneController alloc]init];
//                        
//                        [vc.viewModel fetchToken:response.accessToken];
//                        
//                        [vc.viewModel fetchLoginType:TOYWechatLogin];
//                        
//                        [vc.viewModel fetchUserId:request.response.responseJSONObject[@"data"][@"profile"][@"userId"]];
//                        
//                        [self.navigationController pushViewController:vc animated:YES];
                          [CHProgressHUD showPlainText:@"暂无绑定"];
                    }
                    else{
                        if (self.loginModalViewController) {
                            if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_willCompletionWithSuccess:)]) {
                                [self.loginModalViewController.delegate ch_willCompletionWithSuccess:request.baseResponse.data];
                            }
                            [self.loginModalViewController dismissViewControllerAnimated:YES completion:^{
                                if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithSuccessful:)]) {
                                    [self.loginModalViewController.delegate ch_completionLoginWithSuccessful:request.baseResponse.data];
                                }
                            }];
                        }
                    }
                    
                }  
                else{
                    NSString *message = request.baseResponse.message;
                    
                    [CHProgressHUD hideWithText:message animated:YES];
                    CHLLog(@"Login Message = %@",message);
                    NSError *failureError = [[NSError alloc]initWithDomain:[NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__] code:request.baseResponse.code userInfo:@{@"message":message}];
                    if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithFailur:)]) {
                        [self.loginModalViewController.delegate ch_completionLoginWithFailur:failureError];
                    }
                    
                }
                
                
            } failureBlock:^(__kindof CHBaseRequest *request) {
                [CHProgressHUD hideWithText:@"网络链接失败,请重新尝试" animated:YES];
                if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithFailur:)]) {
                    [self.loginModalViewController.delegate ch_completionLoginWithFailur:request.response.error];
                }
            }];
        }
        
    }];
}



- (NSString*)convertNull:(id)object{
    
    // 转换空串
    
    if ([object isEqual:[NSNull null]]) {
        return @" ";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @" ";
    }
    else if (object==nil){
        return @"无";
    }
    return object;
    
}
#pragma mark IBAction
- (void)backForword:(UIButton *)sender {

    [self.loginModalViewController dismissViewControllerAnimated:YES completion:^{
        if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithCancel)]) {
            [self.loginModalViewController.delegate ch_completionLoginWithCancel];
        }
   //     self.loginModalViewController = nil;
    }];

}
- (void)regisetAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"register" sender:self];
}
- (void)resetPassword:(UIButton *)sender {
    [self performSegueWithIdentifier:@"reset" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([segue.identifier isEqualToString:@"register"]) {
        // segue.destinationViewController：获取连线时所指的界面（VC）
        if (self.loginModalViewController) {
        [segue.destinationViewController setValue:self.loginModalViewController forKey:@"loginModalViewController"];
        [segue.destinationViewController setValue:self.loginModalViewController.registerPathURL forKey:@"registerPathURL"];
        [segue.destinationViewController setValue:self.loginModalViewController.checkCodePathURL forKey:@"checkCodePathURL"];
        }
    }else{
        if (self.loginModalViewController) {
            [segue.destinationViewController setValue:self.loginModalViewController forKey:@"loginModalViewController"];
            [segue.destinationViewController setValue:self.loginModalViewController.resetPathURL forKey:@"resetPathURL"];
            [segue.destinationViewController setValue:self.loginModalViewController.checkCodePathURL forKey:@"checkCodePathURL"];
        }
    }
}
- (void)dealloc{
    
}
@end
