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
//#import "TOYBindPhoneController.h"
#import <CHProgressHUD/CHProgressHUD.h>
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


#define UINAVGATIONHEIGHT 64
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CHLoginViewController ()

@end

@implementation CHLoginViewController{
   
}
#pragma mark init

#pragma mark Activity
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpSubviews];
    
    
    [CHProgressHUD setTextDuration:0.8];
//    [self loadUI];
    [self regisetButtonAction];

}
- (void)setUpSubviews{
    
    
    self.wechatLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem ];
    [self.wechatLoginBtn setImage:[[UIImage imageNamed:@"wechatLogin"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [self.view addSubview:self.wechatLoginBtn];
    
    
    self.qqLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem ];
    [self.qqLoginBtn setImage:[[UIImage imageNamed:@"qqLogin"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  forState:UIControlStateNormal];
    
    [self.view addSubview:self.qqLoginBtn];
    
    self.qqLoginBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 + 20, [UIScreen mainScreen].bounds.size.height - 20 - 44 , 44, 44);
    
    self.wechatLoginBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 44 - 20, [UIScreen mainScreen].bounds.size.height - 20 - 44 , 44, 44);
    
    
}
- (void)loadUI
{
    self.username.layer.borderColor = [JKStyleConfiguration lineColor].CGColor;
    self.username.layer.borderWidth = 1;
    
    self.passWordText.layer.borderColor = [JKStyleConfiguration lineColor].CGColor;
    self.passWordText.layer.borderWidth = 1;
 

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:TRUE];

 
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:FALSE];
}
#pragma mark Private
- (void)regisetButtonAction{
    @weakify(self);
    if (self.registerBtn) {
        [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self regisetAction:x];
        }];
    }

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
                                    return @(username.length >= 11 && password.length >= 6 );
                                }];
        [validUser subscribeNext:^(NSNumber *value) {
            @strongify(self);
           self.loginBtn.backgroundColor = [value boolValue]?kUIColorFromRGB(0xFFDD56):kUIColorFromRGB(0xFFEB99);
            self.loginBtn.titleLabel.textColor = [value boolValue]?kUIColorFromRGB(0x484848):kUIColorFromRGB(0x9C9C9C);
            self.loginBtn.tintColor = [value boolValue]?kUIColorFromRGB(0x484848):kUIColorFromRGB(0x9C9C9C);
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
