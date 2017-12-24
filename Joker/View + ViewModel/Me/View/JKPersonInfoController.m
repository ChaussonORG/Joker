//
//  JKPersonInfoController.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonInfoController.h"
#import "JKPersonInfoCell.h"
#import "TOYDatePickerView.h"
#import "JKProfileApi.h"
#import "JKUserManager.h"
#import "JKPersonPickGenderView.h"
@interface JKPersonInfoController ()<UITableViewDelegate,UITableViewDataSource,JKPersonInfoCellVMDelegate,datePickerDelegete,genderPickerDelegete>

@property (nonatomic , strong) UITableView *mainTableView;

@end

@implementation JKPersonInfoController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
     [self.viewModel requestData];
    [self.mainTableView reloadData];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[JKPersonInfoVM alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = [JKStyleConfiguration screenBackgroundColor];

    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [JKStyleConfiguration screenBackgroundColor];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    
    
   
    
    [self binding];
}
- (void)binding{
    
    @weakify(self)
    [RACObserve(self, viewModel.cellViewModels) subscribeNext:^(id x) {
      @strongify(self)
        
        [self.mainTableView reloadData];
        
    }];
    
    [RACObserve(self, viewModel.contentArr) subscribeNext:^(id x) {
        @strongify(self)
        
        [self.mainTableView reloadData];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.cellViewModels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    JKPersonInfoCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[JKPersonInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    JKPersonInfoCellVM *cellVM =self.viewModel.cellViewModels[indexPath.row];
    cellVM.delegate = self;
    [cell loadDataWithVM:cellVM];
    
    return cell;
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
-(void)changeGender{
    
    JKPersonPickGenderView *pickView = [[JKPersonPickGenderView alloc]init];
    
    pickView.delegete = self;
    
    [pickView show];
    
}
-(void)changeBrithDay{
    
    
    TOYDatePickerView *pickView = [[TOYDatePickerView alloc]initWithDateStyle:TOYBabyAge tempDate:nil];
    
    pickView.delegete = self;
    [pickView show];
    
}
- (void)transferSelectedGender:(NSString*)gender{
    
    JKProfileApi *api = [[JKProfileApi alloc]init];
    
    if ([gender isEqualToString:@"男"]) {
        
        api.gender = @"0";
    }
    else if ([gender isEqualToString:@"女"]) {
        
        api.gender = @"1";
    }
        
    
    [api startWithSuccessBlock:^(__kindof JKProfileApi *request) {
        
        if([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            JKUser *user= [[JKUserManager sharedData].currentUser copy];
            user.gender = [api.gender integerValue];
            [[JKUserManager sharedData] saveUserWithJKUser:user];
            
            [self.viewModel requestData];
            
            [self.mainTableView reloadData];
        }
        
    } failureBlock:^(__kindof JKProfileApi *request) {
        
        
    }];
    
}
- (void)transferSelectedDate:(NSString*)date{
    
    JKProfileApi *api = [[JKProfileApi alloc]init];
    api.birthday = [NSString stringWithFormat:@"%@", [self timeSwitchTimestamp:date]];
    
    [api startWithSuccessBlock:^(__kindof JKProfileApi *request) {
        
        if([request.response.responseJSONObject[@"code"] isEqualToString:@"200"]) {
            
            JKUser *user= [[JKUserManager sharedData].currentUser copy];
            user.birthday = api.birthday;
            [[JKUserManager sharedData] saveUserWithJKUser:user];
            
            [self.viewModel requestData];
            
            [self.mainTableView reloadData];
        }
        
    } failureBlock:^(__kindof JKProfileApi *request) {
        
        
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

- (NSString *)timeStrwithTimestamp:(NSString *)timestamp{
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* needFormatDate = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:needFormatDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];//这里的格式必须和DateString格式一致
    
    NSDate * nowDate = [NSDate date];
    
    
    // ------取当前时间和转换时间两个日期对象的时间间隔
    NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
    
    NSLog(@"time----%f",time);
    // ------再然后，把间隔的秒数折算成天数和小时数：
    
    NSString *dateStr = [[NSString alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
    NSString *nowYear = [dateFormatter stringFromDate:nowDate];
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    dateStr = [dateFormatter stringFromDate:needFormatDate];
    
    return dateStr;
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
