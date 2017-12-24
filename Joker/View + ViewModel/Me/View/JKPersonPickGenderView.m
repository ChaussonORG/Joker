//
//  JKPersonPickGenderView.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/24.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonPickGenderView.h"
@interface JKPersonPickGenderView()<UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIView *naviBarView;

@property (nonatomic , strong) UIView *bgView;

@property (nonatomic , strong) UIButton *sureBtn;

@property (nonatomic , strong) UIPickerView *pickerView;

@property (nonatomic , strong) UILabel *promptLabel;

@property (nonatomic , strong) UILabel *tipsLabel;

@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic , strong) NSString *tempDate;

@property (nonatomic , strong) UIView *topLineView;

@property (nonatomic , strong) UIView *bottomlineView;

@property (assign ,nonatomic) BOOL isTranslucent;

@end
@implementation JKPersonPickGenderView{
    
    UIViewController *_screenController;
    PickCallback _callback;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
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
    self.tipsLabel.font = [JKStyleConfiguration subcontentFont];
    self.tipsLabel.frame = CGRectMake((ScreenWidth - 280)/2, self.bottomlineView.frame.origin.y + self.bottomlineView.frame.size.height + 7, 280, 30);
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.promptLabel];
    [self.bgView addSubview:self.sureBtn];
    [self.bgView addSubview:self.pickerView];
    [self.bgView addSubview:self.tipsLabel];
    [self.bgView addSubview:self.topLineView];
    [self.bgView addSubview:self.bottomlineView];
    
    
}
- (void)pickDataSource{
    
    self.dataSource = [NSMutableArray array]; 
    [self.dataSource addObject:@"男"];
    [self.dataSource addObject:@"女"];
    
}
- (void)clickSureBtn{
    
    NSInteger index = [self.pickerView selectedRowInComponent:0];
    
    NSString *data = [self.dataSource objectAtIndex:index];
    
    [self.delegete transferSelectedGender:data];
    
    [self closeView];
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
   return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataSource.count;
    
    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
   return self.dataSource[row];
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    
      return [UIScreen mainScreen].bounds.size.width;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 35;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [JKStyleConfiguration whiteColor];
    
    UILabel *myView = nil;
    
    
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, ScreenWidth, 35)];
    
    myView.textAlignment = NSTextAlignmentCenter;
    
    myView.text = [self.dataSource objectAtIndex:row];
    
    myView.font = [JKStyleConfiguration contentFont];
    
    myView.backgroundColor = [UIColor clearColor];
    
    
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
    
    
    
}

@end
