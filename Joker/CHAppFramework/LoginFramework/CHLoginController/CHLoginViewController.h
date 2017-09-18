//
//  CHLoginViewController.h
//
//  Created by Chausson on 15/11/4.
//  Copyright © Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHLoginModalController.h"

@interface CHLoginViewController : UIViewController
@property (strong, nonatomic) UIButton *forgetBtn;
@property (strong, nonatomic) UIButton *registerBtn;
@property (strong, nonatomic)  UIButton *backBtn;
@property (strong, nonatomic)  UIButton *loginBtn;
@property (strong, nonatomic)  UITextField *username;
@property (strong, nonatomic)  UITextField *passWordText;
@property (nonatomic ,weak) CHLoginModalController *loginModalViewController;
@property (strong, nonatomic)  UIButton *qqLoginBtn;
@property (strong, nonatomic) UIButton *wechatLoginBtn;
@property (strong, nonatomic) UIButton *weiboLoginBtn;
@property (strong, nonatomic) UIView *loginbgView;
@property (strong, nonatomic) UILabel *disanfangline;
@property (strong, nonatomic) UIView *registerbgView;
@property (strong, nonatomic)  UITextField *registerUsername;
@property (strong, nonatomic)  UITextField *registerPassWordText;
@property (strong, nonatomic)  UITextField *registerCodeText;
@property (strong, nonatomic) UIButton *sendCodeBtn;
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) UIButton *haveAccountBtn;

@property (strong, nonatomic) UILabel *readProtolLabel;

@property (strong, nonatomic) UIButton *openProtolBtn;
@end
