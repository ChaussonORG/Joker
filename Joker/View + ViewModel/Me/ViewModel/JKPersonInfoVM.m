//
//  JKPersonInfoVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/12/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKPersonInfoVM.h"
#import "JKUserManager.h"
#import "HHTGetString.h"


@interface  JKPersonInfoVM ()<JKPersonInfoCellVMDelegate>



@end

@implementation JKPersonInfoVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cellViewModels = [NSMutableArray array];
        
        self.titleArray = @[@"头像",@"昵称",@"性别",@"生日"];
        
        
    }
    return self;
}
- (void)requestData{
    
    
    if (self.contentArr.count> 0) {
        [self.contentArr removeAllObjects];
    }
    else{
        
        self.contentArr = [NSMutableArray array];
    }
    
    
    [self.contentArr addObject:[JKUserManager sharedData].currentUser.photo];
    
    
    if ([JKUserManager sharedData].currentUser.nickname) {
         [self.contentArr addObject:[JKUserManager sharedData].currentUser.nickname];
    }
    else{
        
         [self.contentArr addObject:@" "];
    }
    
    
    if ([JKUserManager sharedData].currentUser.gender == 0) {
        
        [self.contentArr addObject:@"男"];
        
        
    }
    else{
        
        [self.contentArr addObject:@"女"];
    }
    
    
    [self.contentArr addObject: [self timeStrwithTimestamp:[JKUserManager sharedData].currentUser.birthday]];
    
    if (self.cellViewModels.count > 0) {
        
        [self.cellViewModels removeAllObjects];
    }
    for (int i = 0; i < 4 ; i ++) {
        
        JKPersonInfoCellVM   *cellVM = [[JKPersonInfoCellVM  alloc]init];
        
        cellVM.delegate = self;
        
        cellVM.mainTitle = self.titleArray[i];
        
        cellVM.content = self.contentArr[i];
        
        if (i == 0) {
            
            cellVM.type = JKPersonInfoImage;
            
        }
        else{
            
            cellVM.type = JKPersonInfoWord;
        }
        [self.cellViewModels addObject:cellVM];
    }
    
    
    
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

@end
