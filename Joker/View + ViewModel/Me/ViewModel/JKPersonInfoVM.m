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

@interface  JKPersonInfoVM ()

@property (nonatomic ,strong) NSArray *titleArray;

@property (nonatomic ,strong) NSMutableArray *contentArr;

@end

@implementation JKPersonInfoVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cellViewModels = [NSMutableArray array];
        
        self.titleArray = @[@"头像",@"昵称",@"性别",@"生日"];
        
        self.contentArr = [NSMutableArray array];
        
        [self.contentArr addObject:[JKUserManager sharedData].currentUser.photo];
        
        [self.contentArr addObject:[JKUserManager sharedData].currentUser.nickname];
        
        
        if ([JKUserManager sharedData].currentUser.gender == 0) {
            
            [self.contentArr addObject:@"男"];
            
            
        }
        else{
            
            [self.contentArr addObject:@"女"];
        }
        [self.contentArr addObject: [HHTGetString timeStrwithTimestamp:[JKUserManager sharedData].currentUser.birthday]];
    }
    return self;
}
- (void)requestData{
    
    
    for (int i = 0; i < 4 ; i ++) {
        
        JKPersonInfoCellVM   *cellVM = [[JKPersonInfoCellVM  alloc]init];
        
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
@end
