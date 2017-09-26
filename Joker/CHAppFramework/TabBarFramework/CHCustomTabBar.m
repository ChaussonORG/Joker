//
//  CHCustomTabBar.m
//  WinZhen
//
//  Created by 郭金涛 on 15/10/31.
//  Copyright © 2015年 郭金涛. All rights reserved.
//
#import "CHTabBarViewModel.h"
#import "CHCustomTabBar.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CHBarItemViewModel.h"
#import "CHTabBarViewModel.h"
#import "JKUserManager.h"
#import "CHLoginModalController.h"

#define KIndexCount 10

@interface CHCustomTabBar()<CHLoginModalControllerDelegate>

@end

@implementation CHCustomTabBar{
    CHTabBarViewModel *tabBarViewModel;
}


- (instancetype)initWithTabViewModel:(CHTabBarViewModel *)tabViewModel{
    self = [super init];
    if (self) {
        self -> tabBarViewModel = tabViewModel;
        self.backgroundColor = [self colorWithHexString:tabViewModel.color alpha:1];
        //!!!客户新增需求
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3;
        [self initSubviews];
       
    }
    return self;
}


- (void)initSubviews
{
    //添加毛玻璃效果
    if ([self -> tabBarViewModel.style isEqualToString:@"UIVisualEffectView"]) {
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffectView.frame = self.bounds;
        visualEffectView.alpha = 1.0;
        [self addSubview:visualEffectView];
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self->tabBarViewModel.barItemViewModels.count] ;
    for (NSInteger i = 0; i < self -> tabBarViewModel.barItemViewModels.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CHBarItemViewModel *batItemViewModel =  self -> tabBarViewModel.barItemViewModels[i];
        [button setImage:[UIImage imageNamed:batItemViewModel.unselectIcon] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:batItemViewModel.selectedIcon] forState:(UIControlStateSelected)];
        button.tag = i+KIndexCount;
        [button addTarget:self action:@selector(customButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        button.layer.masksToBounds = YES;
        [self addSubview:button];
        [array addObject:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset([UIScreen mainScreen].bounds.size.width /  self -> tabBarViewModel.barItemViewModels.count * i+ (([UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width /  self -> tabBarViewModel.barItemViewModels.count * ( self -> tabBarViewModel.barItemViewModels.count - 1) - 50) / 2) );
            make.height.equalTo(@50);
            make.width.equalTo(@50);
        }];
    }
    self->_buttons = [array copy];
    [self customButtonAction:(UIButton *)[self viewWithTag:self -> tabBarViewModel.currentIndex+KIndexCount]];
    
}

- (void)setSelectIndex:(NSUInteger)index
{
    NSUInteger currentIndex = _tabBarViewModel.currentIndex;
    NSUInteger desIndex = index;
    
    if (self->_tabBarViewModel.shouldSelectItem != nil && !self -> _tabBarViewModel.shouldSelectItem(desIndex)) {
        return;
    }
    
    UIButton *currentBtn = (UIButton *)[self viewWithTag:currentIndex + KIndexCount];
    UIButton *desBtn = (UIButton *)[self viewWithTag:desIndex + KIndexCount];
    
    currentBtn.selected = NO;
    desBtn.selected = YES;
    
    [self selectedItem:desIndex];
}



- (void)customButtonAction:(UIButton *)button
{
    
    if (button.tag-KIndexCount == 2) {
        if ([[JKUserManager sharedData] isUserEffective]) {
            
            
        }
        else{
            
            [self login];
            
            return;
        }
    }
    
    
    UIButton *btn = (UIButton *)[self viewWithTag:self -> tabBarViewModel.currentIndex+KIndexCount];
    btn.selected = NO;
    button.selected = YES;
    [self selectedItem:button.tag-KIndexCount];
    
}

- (void)login
{
    CHLoginModalController *vc = [[CHLoginModalController alloc] init];
    vc.delegate = self;
    [[ASNavigator shareModalCenter].fetchCurrentViewController presentViewController:vc animated:YES completion:nil];
}
- (void)ch_willCompletionWithSuccess:(NSDictionary *)info
{
    [[JKUserManager sharedData] saveUserWithInfo:info];
    
    
}


- (void)selectedItem:(NSInteger )index
{
   [self -> tabBarViewModel selectItem:index];
    
}
- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
@end
