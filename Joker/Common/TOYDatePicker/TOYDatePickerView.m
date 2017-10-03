//
//  TOYDatePickerView.m
//  ToyMan
//
//  Created by 朱彦君 on 16/8/18.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "TOYDatePickerView.h"
#import "JKStyleConfiguration.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define KNavitionBarHeight 64

@interface TOYDatePickerView()<UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIView *naviBarView;

@property (nonatomic , strong) UIView *bgView;

@property (nonatomic , strong) UIButton *sureBtn;

@property (nonatomic , strong) UIPickerView *pickerView;

@property (nonatomic , strong) UILabel *promptLabel;

@property (nonatomic , strong) UILabel *tipsLabel;

@property (nonatomic , assign) TOYDateStyle style;

@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic , strong) NSString *tempDate;

@property (nonatomic , strong) UIView *topLineView;

@property (nonatomic , strong) UIView *bottomlineView;

@property (assign ,nonatomic) BOOL isTranslucent;

@end
@implementation TOYDatePickerView{
    
    UIViewController *_screenController;
     PickCallback _callback;
}

- (instancetype)initWithDateStyle:(TOYDateStyle)style tempDate:(NSString *)tempDate
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        _style = style;
        _tempDate = tempDate;
        [self setUpSubviews];
        
        [self pickDataSource];
    }
    return self;
}



- (void)setUpSubviews{
    
//    self.naviBarView = [[UIView alloc]init];
//    self.naviBarView.backgroundColor = [UIColor clearColor];
//    self.naviBarView.frame = CGRectMake(0, -64, ScreenWidth, 64);
    
    
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [JKStyleConfiguration whiteColor];
    self.bgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);
    
    self.promptLabel = [[UILabel alloc]init];
    self.promptLabel.textColor = [JKStyleConfiguration blackColor];
    self.promptLabel.font = [JKStyleConfiguration titleFont];
    self.promptLabel.frame = CGRectMake(10, 15, 100, 15);
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font = [JKStyleConfiguration titleFont];
    self.sureBtn.tintColor  = [JKStyleConfiguration twotwoColor];
    self.sureBtn.frame = CGRectMake(ScreenWidth - 5 - 40, 8, 40, 30);
    [self.sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.topLineView = [[UIView alloc]init];
    self.topLineView.frame = CGRectMake(0, 47, ScreenWidth, 1);
    self.topLineView.backgroundColor = [JKStyleConfiguration lineColor];
    
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.backgroundColor = [JKStyleConfiguration pickViewBgColor];
    self.pickerView.frame = CGRectMake(0, 46, ScreenWidth, 163);
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.bottomlineView = [[UIView alloc] init];
    self.bottomlineView.frame = CGRectMake(0, self.pickerView.frame.origin.y + self.pickerView.frame.size.height, ScreenWidth, 1);
    self.bottomlineView.backgroundColor = [JKStyleConfiguration lineColor];
    
    self.tipsLabel = [[UILabel alloc]init];
    self.tipsLabel.numberOfLines = 2;
    self.tipsLabel.textColor = [JKStyleConfiguration lightGrayTextColor];
//    self.tipsLabel.font = [JKStyleConfiguration tipFont];
    self.tipsLabel.frame = CGRectMake((ScreenWidth - 280)/2, self.bottomlineView.frame.origin.y + self.bottomlineView.frame.size.height + 7, 280, 30);
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.promptLabel];
    [self.bgView addSubview:self.sureBtn];
    [self.bgView addSubview:self.pickerView];
    [self.bgView addSubview:self.tipsLabel];
    [self.bgView addSubview:self.topLineView];
    [self.bgView addSubview:self.bottomlineView];
    
    
    if (_style == TOYPickUpDate) {
        _promptLabel.text = @"选择送货日期";
         _tipsLabel.text  = @"租赁时间一旦确认，我们将会安排人员到指定取件地址，取走您的玩具，请确保时间准确无误";
    }
    else if(_style == TOYPickUpTime){
        _promptLabel.text = @"选择取货时间";
        _tipsLabel.text  = @"退租时间一旦确认，我们将会安排人员到指定取件地址，取走您的玩具，请确保时间准确无误";
        
    }
    else if(_style == TOYRentDate){
        _promptLabel.text = @"选择租期";
        _tipsLabel.text  = @"";//!!
        
    }
    else if(_style == TOYBabyAge){
        _promptLabel.text = @"选择年龄";
        _tipsLabel.text  = @"";//!!
        
    }
    else if(_style == TOYBoughtTime){
        _promptLabel.text = @"选择购入时间";
        _tipsLabel.text  = @"";//!!
        
    }
    else{
        _promptLabel.text = @"选择送货时间";
        _tipsLabel.text  = @"";
    }
    
    
    
}

- (void)clickSureBtn{
    
    
    if (self.style  == TOYBabyAge) {
        NSInteger compOneindex = [self.pickerView selectedRowInComponent:0];
        NSInteger compTwoindex = [self.pickerView selectedRowInComponent:1];
        NSInteger compThreeindex = [self.pickerView selectedRowInComponent:2];
        
        NSString *year = self.dataSource[0][compOneindex];
        NSString *month = self.dataSource[1][compTwoindex];
        NSString *day = self.dataSource[2][compThreeindex];
        
        year = [self cutSubStringFromSuperString:year Withheader:nil tail:@"年"];
        month = [self cutSubStringFromSuperString:month Withheader:nil tail:@"月"];
        day = [self cutSubStringFromSuperString:day Withheader:nil tail:@"日"];
        
        NSString *date = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
        
        [self.delegete transferSelectedDate:date];
        
        [self closeView];
        
    }
    else  if (self.style  == TOYBoughtTime){
        
        NSInteger compOneindex = [self.pickerView selectedRowInComponent:0];
        NSInteger compTwoindex = [self.pickerView selectedRowInComponent:1];
        
        NSString *year = self.dataSource[0][compOneindex];
        NSString *month = self.dataSource[1][compTwoindex];
        
        NSString *date;
        if (month.length > 2) {
            date = [NSString stringWithFormat:@"%@%@",year,month];
        }
        else{
            
            date = [NSString stringWithFormat:@"%@0%@",year,month];
            
        }
        
        
        [self.delegete transferSelectedDate:date];
        
        [self closeView];
    }
    else{
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        
        NSString *date = [self.dataSource objectAtIndex:index];
        
        [self.delegete transferSelectedDate:date];
        
        [self closeView];
    }
    
    
}

- (NSString *)cutSubStringFromSuperString:(NSString *)superString Withheader:(NSString*)header tail:(NSString *)tail{
    
    NSRange headRange ;
    
    if (header) {
        headRange  = [superString rangeOfString:header];
    }
    else{
        
        
        headRange = NSMakeRange(0, 0);
    }
    
    
    NSRange urlRange ;
    if (tail) {
        NSRange tailRange = [superString rangeOfString:tail];
        urlRange = NSMakeRange(headRange.location + header.length, tailRange.location -headRange.location - header.length);
    }
    else{
        urlRange = NSMakeRange(headRange.location + header.length, superString.length -header.length);
    }
    
    
    
    NSString *amount = [superString substringWithRange:urlRange];
    
    return amount;
}

- (void)pickDataSource{
    
    if (self.style == TOYPickUpTime) {
        
        self.dataSource = [NSMutableArray array];
        
        [self.dataSource addObject:@"09:00-10:00"];
        [self.dataSource addObject:@"10:00-11:00"];
        [self.dataSource addObject:@"11:00-12:00"];
        [self.dataSource addObject:@"12:00-13:00"];
        [self.dataSource addObject:@"13:00-14:00"];
        [self.dataSource addObject:@"14:00-15:00"];
        [self.dataSource addObject:@"15:00-16:00"];
        [self.dataSource addObject:@"16:00-17:00"];
        
    }
    else if(self.style  == TOYRentDate){
        
        
        self.dataSource = [NSMutableArray array];
        
        
        for (int i = 7; i < 61 ; i++) {
            
            
            NSString *str = [NSString stringWithFormat:@"%d天",i];
            
              [self.dataSource addObject:str];
            
        }
    
    }
    else if(self.style  == TOYBabyAge){
        
        self.dataSource = [NSMutableArray array];
        
        NSMutableArray *arrYear= [NSMutableArray array];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        
        
        for (int i = 1960; i < [dateTime integerValue] + 1 ; i++) {
            
            
            NSString *str = [NSString stringWithFormat:@"%d年",i];
            
            [arrYear addObject:str];
            
        }
        [self.dataSource addObject:arrYear];
        
        NSMutableArray *arrMonth = [NSMutableArray array];
        
        for (int i = 1; i < 13 ; i++) {
            
            
            NSString *str = [NSString stringWithFormat:@"%d月",i];
            
            [arrMonth addObject:str];
            
        }
        
        [self.dataSource addObject:arrMonth];
       
        
        [self setUpBabyAgeDayForDataSourceWithYear:self.dataSource[0][0] month:self.dataSource[1][0]];
        
        
    }
    else if(self.style  == TOYBoughtTime){
        
        self.dataSource = [NSMutableArray array];
        
        NSMutableArray *arrYear= [NSMutableArray array];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        
        
        for (int i = ([dateTime intValue] - 100 + 1); i < [dateTime integerValue] + 1 ; i++) {
            
            
            NSString *str = [NSString stringWithFormat:@"%d年",i];
            
            [arrYear addObject:str];
            
        }
        [self.dataSource addObject:arrYear];
        
        NSMutableArray *arrMonth = [NSMutableArray array];
        
        for (int i = 1; i < 13 ; i++) {
            
            
            NSString *str = [NSString stringWithFormat:@"%d月",i];
            
            [arrMonth addObject:str];
            
        }
        
        [self.dataSource addObject:arrMonth];
        
    }
    else{
        
        self.dataSource = [NSMutableArray array];
        
        
        for (int days = 1; days < 8; days ++) {
            
            NSString *day   = [[self class] assembleDaysStringWithCount:days];
            
            NSString *deadline = [[self class] todayAfterDays:days];
           
            if (![deadline compare: _tempDate]) {
                
                break;
                
            }
          
            [self.dataSource addObject:day];
        }
        
        
    }
    
}

- (void)setUpBabyAgeMonthForDataSourceWithYear:(NSString *)year{
    
    
    if (self.dataSource.count > 1) {
        
        [self.dataSource removeObjectAtIndex:1];
        
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    NSString *yearStr = [self cutSubStringFromSuperString:year Withheader:nil tail:@"年"];
    
    if ([yearStr integerValue] >= [dateTime integerValue]) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM"];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        
        NSMutableArray *arrMonth = [NSMutableArray array];
        
        for (int i = 1; i < [dateTime integerValue] + 1 ; i++) {
            
            
            NSString *str = [NSString stringWithFormat:@"%d月",i];
            
            [arrMonth addObject:str];
            
        }
        
        [self.dataSource insertObject:arrMonth atIndex:1];
        
        
    }
    else{
        
        NSMutableArray *arrMonth = [NSMutableArray array];
        
        for (int i = 1; i < 13 ; i++) {
            
            
            NSString *str = [NSString stringWithFormat:@"%d月",i];
            
            [arrMonth addObject:str];
            
        }
        
         [self.dataSource insertObject:arrMonth atIndex:1];
        
    }
    
    [self.pickerView reloadComponent:1];
    
}


- (void)setUpBabyAgeDayForDataSourceWithYear:(NSString*)year month:(NSString*)month{
    
    
    
    
     NSString *yearStr = [self cutSubStringFromSuperString:year Withheader:nil tail:@"年"];
    
    
    if (self.dataSource.count > 2) {
        [self.dataSource removeObjectAtIndex:2];
    }
    
    NSMutableArray *arrDay = [NSMutableArray array];
    
    NSInteger dayCount = [self howManyDaysInThisYear:[year integerValue] withMonth:[month integerValue]];
    
    for (int i = 1; i < dayCount + 1 ; i++) {
        
        
        NSString *str = [NSString stringWithFormat:@"%d日",i];
        
        [arrDay addObject:str];
        
    }
    
    [self.dataSource addObject:arrDay];
    
    [self.pickerView reloadComponent:2];
    
}

- (NSInteger)howManyDaysInThisYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

+ (NSString *)todayAfterDays:(NSInteger)days{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese] ;
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [components setDay:([components day] + days)];
    NSDate *beginningOfWeek = [calendar dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}
+(NSString *)assembleDaysStringWithCount:(NSInteger)days
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese] ;
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [components setDay:([components day] + days)];
    [components setWeekday:([components weekday] +days)];
    
    NSDate *beginningOfWeek = [calendar dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    NSString *weekDay ;
    switch ([components weekday]%7) {
        case 0:{
            weekDay = @"周六";
            break;
        }
        case 1:{
            weekDay = @"周日";
            break;
        }
        case 2:{
            weekDay = @"周一";
            break;
        }
        case 3:{
            weekDay = @"周二";
            break;
        }
        case 4:{
            weekDay = @"周三";
            break;
        }
        case 5:{
            weekDay = @"周四";
            break;
        }
        case 6:{
            weekDay = @"周五";
            break;
        }
            
        default:
            break;
    }
    NSString *date = [NSString stringWithFormat:@"%@(%@)",[dateday stringFromDate:beginningOfWeek],weekDay];
    return date;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (self.style  == TOYBabyAge) {
        
        return 3;
    }
    if (self.style  == TOYBoughtTime) {
        
        return 2;
    }
    else{
        return 1;
    }
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if (self.style  == TOYBabyAge) {
        
          return [[self.dataSource objectAtIndex:component] count];
    }
    if (self.style  == TOYBoughtTime) {
        
        return [[self.dataSource objectAtIndex:component] count];
    }
    else{
          return self.dataSource.count;
    }
  
    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (self.style  == TOYBabyAge) {
        
        return self.dataSource[component][row];
        
    }
    else if (self.style  == TOYBoughtTime) {
        
        return self.dataSource[component][row];
        
    }
    else{
        return self.dataSource[row];
    }
    
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    
    if (self.style  == TOYBabyAge) {
        
        return [UIScreen mainScreen].bounds.size.width/3;
    }
    else if (self.style  == TOYBoughtTime) {
        
        return [UIScreen mainScreen].bounds.size.width/3;
    }else{
        return [UIScreen mainScreen].bounds.size.width;
    }
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 35;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [JKStyleConfiguration whiteColor];
    
    UILabel *myView = nil;
    
    
    if (self.style  == TOYBabyAge) {
        
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth/3, 35)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [self.dataSource objectAtIndex:component][row];
        
        myView.font = [JKStyleConfiguration titleFont];
        
        myView.backgroundColor = [UIColor clearColor];
        
        
    }
    else if (self.style  == TOYBoughtTime) {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth/3, 35)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [self.dataSource objectAtIndex:component][row];
        
        myView.font = [JKStyleConfiguration titleFont];
        
        myView.backgroundColor = [UIColor clearColor];
        
        
    }else{
        if (component == 0) {
            
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 35)];
            
            myView.textAlignment = NSTextAlignmentCenter;
            
            myView.text = [self.dataSource objectAtIndex:row];
            
            myView.font = [JKStyleConfiguration titleFont];
            
            myView.backgroundColor = [UIColor clearColor];
            
        }else {
            myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 35)];
            
            myView.text = [self.dataSource objectAtIndex:row];
            
            myView.textAlignment = NSTextAlignmentCenter;
            
            myView.font = [JKStyleConfiguration titleFont];
            
            myView.backgroundColor = [UIColor clearColor];
            
        }
    }
    
  
    
    [selectedView addSubview:myView];
    return selectedView;
    
}
- (void)show{
    
    [self showInView:[self getCurrentVC]];
}

- (void)showInView:(UIViewController *)Sview
{
    
    if(Sview==nil){
        //        [[UIApplication sharedApplication].delegate.window addSubview:self];
    }else{
        //[view addSubview:self];
        self.isTranslucent =  !Sview.navigationController.navigationBar.isTranslucent && Sview.navigationController.navigationBar;
        
        
        [Sview.view addSubview:self];
        
    }
    [self animeData];
}
-(void)animeData{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    CGFloat orginY = ScreenHeight - self.bgView.frame.size.height ;
    if (self.isTranslucent) {
//        orginY-=KNavitionBarHeight;
    }
    [UIView animateWithDuration:.25 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [UIView animateWithDuration:.25 animations:^{
            [self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x, orginY, self.bgView.frame.size.width, self.bgView.frame.size.height)];
        }];
    } completion:^(BOOL finished) {
    }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;
    }
//    [self closeView];
    return NO;
}
- (void)closeView{
    
    
    [UIView animateWithDuration:.25 animations:^{
        [self.bgView setFrame:CGRectMake(0, ScreenHeight,ScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
}
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] lastObject];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (self.style == TOYBabyAge) {
        
        if (component == 0 || component == 1) {
            
            
            NSInteger compOneindex = [self.pickerView selectedRowInComponent:0];
            
            
            [self setUpBabyAgeMonthForDataSourceWithYear:self.dataSource[0][compOneindex]];
            
            NSInteger compTwoindex = [self.pickerView selectedRowInComponent:1];
            
            [self setUpBabyAgeDayForDataSourceWithYear:self.dataSource[0][compOneindex] month:self.dataSource[1][compTwoindex]];
            
        }
    }
    
    if (self.style == TOYBoughtTime) {
        
        
        if (component == 0) {
            
            
            NSInteger compOneindex = [self.pickerView selectedRowInComponent:0];
            
            
            [self setUpBabyAgeMonthForDataSourceWithYear:self.dataSource[0][compOneindex]];
            
            
            
        }
        
        
    }
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
