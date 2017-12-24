//
//  JKPerfectUserInfoController.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPerfectUserInfoController.h"
#import "JKIconCommitApi.h"
#import "CHImagePicker.h"
#import "HHTUserEditModel.h"
#import "JKPerfectInfoApi.h"
#import "JKUserManager.h"
#import "TOYDatePickerView.h"



@interface JKPerfectUserInfoController ()<datePickerDelegete>

@property (nonatomic , strong) UIButton *iconBtn;

@property (nonatomic , strong) UILabel *iconLabel;

@property (nonatomic , strong) UITextField *nickName;


@property (nonatomic , strong) UIButton *nanBtn;

@property (nonatomic , strong) UIButton *nvBtn;

@property (nonatomic , assign) BOOL isMan;

@property (nonatomic , strong) UILabel *brithDay;


@property (nonatomic , strong) UIButton *finishBtn;

@property (nonatomic , strong) NSString *photo;

@property (nonatomic , strong) NSString *brithDayStr;

@property (nonatomic , strong) UIButton *stepBtn;

@end

@implementation JKPerfectUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"完善资料";
    
    self.view.backgroundColor = [JKStyleConfiguration whiteColor];
    
    [self setupSubviews];
    // Do any additional setup after loading the view.
}

- (void)setupSubviews{
    
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.iconBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [self.view addSubview:self.iconBtn];
    [self.iconBtn addTarget:self action:@selector(clickIconBtn) forControlEvents:UIControlEventTouchUpInside];
    self.iconBtn.frame = CGRectMake((ScreenWidth - 74)/2, 118, 75, 75);
    self.iconBtn.layer.cornerRadius = 75/2;
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    self.iconLabel = [[UILabel alloc]init];
    self.iconLabel.text = @"上传头像";
    self.iconLabel.font = [JKStyleConfiguration subcontentFont];
    self.iconLabel.textColor = [JKStyleConfiguration twotwoColor];
     [self.view addSubview:self.iconLabel];
    self.iconLabel.frame = CGRectMake(0, self.iconBtn.frame.origin.y + self.iconBtn.frame.size.height + 10, ScreenWidth, 15);
    self.iconLabel.textAlignment = NSTextAlignmentCenter;
    
    self.nickName = [[UITextField alloc]init];
    self.nickName.frame = CGRectMake(50, self.iconLabel.frame.size.height + self.iconLabel.frame.origin.y + 15, ScreenWidth - 100, 20);
    [self.view addSubview:self.nickName];
    self.nickName.placeholder = @"昵称";
    self.nickName.font = [JKStyleConfiguration titleFont];
    
    
    self.nanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nanBtn.frame = CGRectMake(50, self.nickName.frame.size.height + self.nickName.frame.origin.y + 24, ScreenWidth/2 - 50 - 10, 30);
    self.nanBtn.layer.borderColor = [JKStyleConfiguration twotwoColor].CGColor;
    self.nanBtn.layer.borderWidth = 2;
    [self.nanBtn setTitle:@"男" forState:UIControlStateNormal];
    [self.nanBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    self.nanBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    [self.view addSubview:self.nanBtn];
    [self.nanBtn addTarget:self action:@selector(clickNanBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.nvBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nvBtn.frame = CGRectMake( ScreenWidth/2 + 10, self.nickName.frame.size.height + self.nickName.frame.origin.y + 24, ScreenWidth/2 - 50 - 10, 30);
    self.nvBtn.layer.borderColor = [JKStyleConfiguration eeeeeeColor].CGColor;
    self.nvBtn.layer.borderWidth = 1;
    [self.nvBtn setTitle:@"女" forState:UIControlStateNormal];
    [self.nvBtn setTitleColor:[JKStyleConfiguration placeHolderColor] forState:UIControlStateNormal];
    self.nvBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    [self.view addSubview:self.nvBtn];
     [self.nvBtn addTarget:self action:@selector(clickNvBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.brithDay = [[UILabel alloc]init];
    self.brithDay.frame = CGRectMake(50, self.nvBtn.frame.size.height + self.nvBtn.frame.origin.y + 15, ScreenWidth - 100, 20);
    [self.view addSubview:self.brithDay];
    self.brithDay.text = @"请选择生日";
    self.brithDay.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBrithDay)];
    
    [self.brithDay addGestureRecognizer:tap];
    self.brithDay.font = [JKStyleConfiguration titleFont];
    
    
    self.finishBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.finishBtn.frame = CGRectMake(70, self.brithDay.frame.origin.y + self.brithDay.frame.size.height + 30, self.view.frame.size.width - 140, 40);
    [self.finishBtn setTitleColor:[JKStyleConfiguration whiteColor] forState:UIControlStateNormal];
    self.finishBtn.backgroundColor = [JKStyleConfiguration twotwoColor];
    self.finishBtn.titleLabel.font = [JKStyleConfiguration hugeFont];
    self.finishBtn.layer.cornerRadius = 20;
    self.finishBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.finishBtn];
    [self.finishBtn addTarget:self action:@selector(clickFinishBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.stepBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.stepBtn setTitle:@"跳过此步 >" forState:UIControlStateNormal];
    self.stepBtn.frame = CGRectMake(70, self.finishBtn.frame.origin.y + self.finishBtn.frame.size.height + 10, self.view.frame.size.width - 140, 40);
    [self.stepBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    self.stepBtn.backgroundColor = [JKStyleConfiguration whiteColor];
    self.stepBtn.titleLabel.font = [JKStyleConfiguration subcontentFont];
    self.stepBtn.layer.cornerRadius = 20;
    self.stepBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.stepBtn];
    [self.stepBtn addTarget:self action:@selector(clickStepBtn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickStepBtn{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
    
}

- (void)transferSelectedDate:(NSString *)date{
    
    //!!!date
    self.brithDay.text = date;
//    self.ageLabel.text = [self intervalSinceNow:date];
    
    
}

- (void)clickBrithDay{
    
    
    TOYDatePickerView *pickView = [[TOYDatePickerView alloc]initWithDateStyle:TOYBabyAge tempDate:nil];
    
    pickView.delegete = self;
    [pickView show];
    
}
- (void)clickFinishBtn{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *token = [self.data objectForKey:@"token"];
    if (token) {
        [dic setObject:token forKey:@"token"];
        [[CHNetworkConfig sharedInstance] addheaderFieldParameter:dic];
    }
    
    self.brithDayStr =  [self timeSwitchTimestamp:self.brithDay.text];
    
    JKPerfectInfoApi *api = [[JKPerfectInfoApi alloc]initWithPhoto:self.photo];
    api.photo = self.photo;
    api.birthday = self.brithDayStr;
    api.nickName = self.nickName.text;
    
    if (_isMan) {
        api.gender = @"1";
    }
    else{
        api.gender = @"0";
        
    }
    [api startWithSuccessBlock:^(__kindof JKPerfectInfoApi *request) {
        
        if ([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            [[JKUserManager sharedData] saveUserWithInfo:self.data];
            
            [JKUserManager sharedData].currentUser.photo = self.photo;
            
            [JKUserManager sharedData].currentUser.nickname = self.nickName.text;
            
            [JKUserManager sharedData].currentUser.gender = self.isMan? 1:0;
            
            [JKUserManager sharedData].currentUser.birthday = self.brithDayStr;
            
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
                
                
            }];
            
            
        }else{
            
            [CHProgressHUD showPlainText:request.response.responseJSONObject[@"message"]];
        }
        
        
        
        
    } failureBlock:^(__kindof JKPerfectInfoApi *request) {
        
        
    }];
    
}

- (NSString *)timeSwitchTimestamp:(NSString *)formatTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"]; //(@" hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    //    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    //    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    
    
    return timeString;
    
}

- (void)clickNanBtn{
    
    self.isMan = YES;
    
    self.nanBtn.layer.borderColor = [JKStyleConfiguration twotwoColor].CGColor;
    self.nanBtn.layer.borderWidth = 2;
    [self.nanBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];
    
    
    self.nvBtn.layer.borderColor = [JKStyleConfiguration eeeeeeColor].CGColor;
    self.nvBtn.layer.borderWidth = 1;
    [self.nvBtn setTitleColor:[JKStyleConfiguration placeHolderColor] forState:UIControlStateNormal];
}
- (void)clickNvBtn{
    
    
    self.isMan = NO;
    
    self.nanBtn.layer.borderColor = [JKStyleConfiguration eeeeeeColor].CGColor;
    self.nanBtn.layer.borderWidth = 1;
    [self.nanBtn setTitleColor:[JKStyleConfiguration placeHolderColor] forState:UIControlStateNormal];
    
    
    self.nvBtn.layer.borderColor = [JKStyleConfiguration twotwoColor].CGColor;
    self.nvBtn.layer.borderWidth = 2;
    [self.nvBtn setTitleColor:[JKStyleConfiguration twotwoColor] forState:UIControlStateNormal];

    
    
}
- (void)clickIconBtn{
    
    
    
    @weakify(self)
    [CHImagePicker show:YES picker:self completion:^(UIImage *image) {
        [CHProgressHUD show:YES];
        [HHTUserEditModel updateIcon:image success:^(SDBaseResponse *userInfo) {
            @strongify(self);
            
            NSArray *array = (NSArray *)userInfo.data;
            
            NSDictionary *data = [array objectAtIndex:0];
            
            self.photo = [data objectForKey:@"url"];
            
            [self.iconBtn setImage:image forState:UIControlStateNormal];
            [CHProgressHUD hide:YES];
        } failed:^{
            
        }];
    }];
    
    
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
