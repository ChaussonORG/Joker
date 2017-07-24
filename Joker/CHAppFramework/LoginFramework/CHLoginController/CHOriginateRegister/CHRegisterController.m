//
//  CHRegisterController.m
//  FrameWorkPractice
//
//  Created by Chausson on 16/3/21.
//  Copyright © Chausson . All rights reserved.
//

#import "CHRegisterController.h"
//#import "TOYRegisterWithInviteCodeApi.h"
#import "SDSendCodeAPI.h"
#import "JKStyleConfiguration.h"
//#import "TOYSystemHelpController.h"
//#import "CHEnvironmentSupply.h"
#import <CHProgressHUD/CHProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CHRegisterController ()
@property (nonatomic , strong) UILabel *agreedLabel;

@property (nonatomic , strong) UIButton *agreeBtn;

@property (nonatomic , strong) UIButton *protocolBtn;
@end

@implementation CHRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubviews];
    [self regisetButtonAction];
    
}
#pragma mark Private


- (void)setUpSubviews{
    
    self.agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agreeBtn.frame = CGRectMake(24, 340 + 10, 18, 18);
    
    self.agreeBtn.selected = YES;
    
    [self.agreeBtn setImage:[[UIImage imageNamed:@"agreeIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    
    [self.agreeBtn setImage:[[UIImage imageNamed:@"disagreeIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    [self.agreeBtn addTarget:self action:@selector(clickAgreeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.agreeBtn];
    
    
    self.agreedLabel = [[UILabel alloc]init];
    self.agreedLabel.frame = CGRectMake(self.agreeBtn.frame.origin.x + self.agreeBtn.frame.size.width + 5, self.agreeBtn.frame.origin.y, 98, 18);
    self.agreedLabel.text = @"我已同意并阅读";
    self.agreedLabel.textColor = [JKStyleConfiguration blackColor];
    self.agreedLabel.font = [JKStyleConfiguration subcontentFont];
    [self.view addSubview:self.agreedLabel];
    
    
    self.protocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.protocolBtn.frame = CGRectMake(self.agreedLabel.frame.origin.x + self.agreedLabel.frame.size.width - 8 , self.agreedLabel.frame.origin.y , 240 - self.agreedLabel.frame.size.width, 18);
    [self.protocolBtn setTitle:@"《玩乐多用户协议》" forState:UIControlStateNormal];
    self.protocolBtn.tintColor = [JKStyleConfiguration redColor];
    self.protocolBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.protocolBtn addTarget:self action:@selector(clickProtocolBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.protocolBtn];

}


- (void)clickAgreeBtn{
    
    self.agreeBtn.selected = !self.agreeBtn.selected;
}
- (void)clickProtocolBtn{
    
    
//    NSString *url = [NSString stringWithFormat:@"%@/app/h5/reg",[CHEnvironmentSupply servicePath]];
//    
//    TOYSystemHelpController *vc = [[TOYSystemHelpController alloc]initWithURL:url];
//    vc.title = @"玩乐多用户协议";
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (void)regisetButtonAction{
    @weakify(self);
    if (self.registerBtn) {
        RACSignal *validUser = [RACSignal
                                combineLatest:@[[self.phoneField rac_textSignal],
                                                [self.checkCodeField rac_textSignal],
                                                [self.passwordField rac_textSignal],
                                                ]
                                reduce:^(NSString *username, NSString *code,NSString *password){
                                    return @(username.length >= 11 && password.length >= 6 && code.length > 0);
                                }];
        [validUser subscribeNext:^(NSNumber *value) {
            @strongify(self);
            self.registerBtn.enabled = [value boolValue];
            self.registerBtn.backgroundColor = [value boolValue]?kUIColorFromRGB(0xFFDD56):kUIColorFromRGB(0xFFEB99);
        }];
        [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self registerAccount];
        }];
    }
    if (self.fetchCheckCode) {
        [[self.fetchCheckCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self fetchCheckCodeAction];
        }];
    }
    if (self.protocal) {
        [[self.protocal rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
         
        }];
    }
    if (self.hiddenPassword) {
        self.hiddenPassword.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(UIButton *input) {
            @strongify(self);
            self.passwordField.secureTextEntry = !input.selected;
            input.selected = !input.selected;
            return [RACSignal empty];
        }];
    }
    
}

// 登录响应事件
- (void)registerAccount{
//    NSAssert(self.registerPathURL.length > 0, @"Please Input Login URL Path When You Used LoginModal");
    if (self.phoneField.text.length == 0 || self.passwordField.text.length == 0 || self.checkCodeField.text.length == 0) {
        [CHProgressHUD showPlainText:@"输入的内容不能为空"];
        return;
    }  
    
    if (self.agreeBtn.isSelected == NO) {
        [CHProgressHUD showPlainText:@"您必须同意玩乐多用户协议才能进行下一步操作"];
        return;
        
    }
 //   NSAssert(self.registerPathURL.length > 0, @"Register Path URL Is Nil");
    [self registerFirstResponsed];
    [CHProgressHUD show:YES];
//    TOYRegisterWithInviteCodeApi *registerRequest = [[TOYRegisterWithInviteCodeApi alloc]initWithAccount:self.phoneField.text password:self.passwordField.text phoneCode:self.checkCodeField.text];
//    
//    registerRequest.inviteCode = self.inviteCodeField.text;
//    [registerRequest startWithSuccessBlock:^(__kindof TOYRegisterWithInviteCodeApi *request) {
//        if (request.baseResponse.code == 200) {
//            [CHProgressHUD hideWithText:request.baseResponse.message animated:YES];
//            if (self.loginModalViewController) {
//                if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_willCompletionWithSuccess:)]) {
//                    [self.loginModalViewController.delegate ch_willCompletionWithSuccess:request.baseResponse.data];
//                }
//                [self.loginModalViewController dismissViewControllerAnimated:YES completion:^{
//                    if ([self.loginModalViewController.delegate respondsToSelector:@selector(ch_completionLoginWithSuccessful:)]) {
//                        [self.loginModalViewController.delegate ch_completionLoginWithSuccessful:request.baseResponse.data];
//                    }
//                }];
//            }
//
////            [self.navigationController popToRootViewControllerAnimated:YES];
//        }else{
//            [CHProgressHUD hideWithText:request.baseResponse.message animated:YES];
//        }
//    } failureBlock:^(__kindof TOYRegisterWithInviteCodeApi *request) {
//            [CHProgressHUD hideWithText:@"注册用户失败，请确认网络后重试" animated:YES];
//    }];
    
}
- (void)countDownWithTime:(int )time{

    __block int _surplusSecond = time;
         //全局并发队列
         dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
         //主队列；属于串行队列
         dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
         //定时循环执行事件
        @weakify(self);
         dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
         dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
         dispatch_source_set_event_handler(timer, ^{ //计时器事件处理器
          //      CHLLog(@"Event Handler");
             @strongify(self);
                 if (_surplusSecond <= 0) {
                         dispatch_source_cancel(timer); //取消定时循环计时器；使得句柄被调用，即事件被执行
                        self.fetchCheckCode.enabled = YES;
                         dispatch_async(mainQueue, ^{
                            // [self.fetchCheckCode setBackgroundColor:kUIColorFromRGB(0x01a1ff)];
                             [self.fetchCheckCode setTitle:@"重新获取" forState:UIControlStateNormal];
                    
                             });
                     } else {
                             _surplusSecond--;
                              self.fetchCheckCode.enabled = NO;
    
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 NSString *btnInfo = [NSString stringWithFormat:@"%ld秒", (long)(_surplusSecond + 1)];
                                 self.fetchCheckCode.titleLabel.text = btnInfo;
                                 [self.fetchCheckCode setTitle:btnInfo forState:UIControlStateDisabled];
                               //
                               // [self.fetchCheckCode setBackgroundColor:kUIColorFromRGB(0xb2b2b2)];
 
                                });
                         }
             });
         dispatch_source_set_cancel_handler(timer, ^{ //计时器取消处理器；调用 dispatch_source_cancel 时执行
                 CHLLog(@"Cancel Handler");
             });
         dispatch_resume(timer);  //恢复定时循环计时器；Dispatch Source 创建完后默认状态是挂起的，需要主动恢复，否则事件不会被传递，也不会被执行
}


- (void)checkCodeCountDownWithTime:(int)time{
    __block int timeout= time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.fetchCheckCode setTitle:@"重新获取" forState:UIControlStateNormal];
                self.fetchCheckCode.userInteractionEnabled = YES;
                self.fetchCheckCode.enabled = YES;

            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 120;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                        NSLog(@"____%@",strTime);
                
                self.fetchCheckCode.titleLabel.text =[NSString  stringWithFormat:@"%@秒",strTime];
                [self.fetchCheckCode setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                
                
                self.fetchCheckCode.userInteractionEnabled = NO;
                self.fetchCheckCode.enabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
  
}
- (void)registerFirstResponsed{
    [self.phoneField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.checkCodeField resignFirstResponder];
}
#pragma mark IBAction
- (void)fetchCheckCodeAction{
    if (self.phoneField.text.length == 0 && self.phoneField.text.length != 11) {
        [CHProgressHUD showPlainText:@"请输入正确的手机号码"];
        return;
    }
    [self registerFirstResponsed];
//    [self countDownWithTime:60];
    
    [self checkCodeCountDownWithTime:60];
  //  NSAssert(self.checkCodePathURL.length > 0, @"Register Path URL Is Nil");
    SDSendCodeAPI *sendCode = [[SDSendCodeAPI alloc]initWithCellPhone:self.phoneField.text];
    [sendCode startWithSuccessBlock:^(__kindof SDSendCodeAPI *request) {
        if (request.baseResponse.code != 200) {
            [CHProgressHUD showPlainText:request.baseResponse.message];
        }
    } failureBlock:^(__kindof SDSendCodeAPI *request) {
        [CHProgressHUD showPlainText:@"发送验证码，请确认网络后重试"];
    }];
    
}

- (void)regisetAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"register" sender:self];
}
- (void)resetPassword:(UIButton *)sender {
    [self performSegueWithIdentifier:@"reset" sender:self];
}
- (void)dealloc{
    
}
    


@end
