//
//  JKPersonInfoNameController.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonInfoNameController.h"
#import "JKProfileApi.h"
@interface JKPersonInfoNameController ()
@property (nonatomic , strong) UIButton *nextBtn;

@property (nonatomic , strong) UITextField *nameField;
@end

@implementation JKPersonInfoNameController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.rightBarButtonItem = [self customRightButton];
  
}

-(UIBarButtonItem*)customRightButton{
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame=CGRectMake(15, 15, 48,23);
    self.nextBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    [self.nextBtn setAdjustsImageWhenHighlighted:NO];
    [self.nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.userInteractionEnabled = YES;
    [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
    [self.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
    self.nextBtn.layer.borderWidth = 1;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.nextBtn];
    
    return backItem;
    
    
}

- (void)clickNextBtn{
    
    
    if (self.nameField.text.length > 0) {
        JKProfileApi *api = [[JKProfileApi alloc]init];
        
        api.nickname = self.nameField.text;
        
        [api startWithSuccessBlock:^(__kindof JKProfileApi *request) {
            
            
            if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
                
                
                
            }
            
            
        } failureBlock:^(__kindof JKProfileApi *request) {
            
        }];
    }
    else{
        
        [CHProgressHUD showPlainText:@"请填写昵称"];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"姓名";
    
    self.view.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    
    
    UIView *line1 = [[UIView alloc]init];
    line1.frame = CGRectMake(0, 10, ScreenWidth, 0.3);
    line1.backgroundColor = [JKStyleConfiguration lineColor];
    [self.view addSubview:line1];
    
    UIView *whiteBgView = [[UIView alloc]init];
    whiteBgView.frame = CGRectMake(0, line1.frame.size.height + line1.frame.origin.y, ScreenWidth, 40);
    whiteBgView.backgroundColor = [JKStyleConfiguration whiteColor];
    [self.view addSubview:whiteBgView];
    
    UIView *line2 = [[UIView alloc]init];
    line2.frame = CGRectMake(0, whiteBgView.frame.size.height + whiteBgView.frame.origin.y, ScreenWidth, 0.3);
    line2.backgroundColor = [JKStyleConfiguration lineColor];
    [self.view addSubview:line2];
    
    self.nameField = [[UITextField alloc]init];
    self.nameField.frame = CGRectMake(20, 5, ScreenWidth - 40, 30);
    self.nameField.clearButtonMode = UITextFieldViewModeAlways;
    self.nameField.text = self.name;
    [whiteBgView addSubview:self.nameField];
    
    
    @weakify(self);
    [self.nameField.rac_textSignal subscribeNext:^(NSString *content){
        @strongify(self);
       
        if (self.nameField.text.length > 0 && ![self.nameField.text isEqualToString:self.name]) {
            
            [self.nextBtn setTitleColor:[JKStyleConfiguration blackColor] forState:UIControlStateNormal];
            self.nextBtn.layer.borderColor = [JKStyleConfiguration blackColor].CGColor;
            
            self.nextBtn.enabled = YES;
            
        }
        else{
            
            [self.nextBtn setTitleColor:[JKStyleConfiguration ccccccColor] forState:UIControlStateNormal];
            
            self.nextBtn.layer.borderColor = [JKStyleConfiguration ccccccColor].CGColor;
            self.nextBtn.enabled = NO;
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Do any additional setup after loading the
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
