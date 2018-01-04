//
//  JKTopicDetailBottomVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/16.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicDetailBottomVM.h"

@implementation JKTopicDetailBottomVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.currentPage = 1;
        
    }
    return self;
}


- (void)refresh{
    
    
    [self.delegate refresh];
}

- (void)up{
    
    if (self.currentPage > 1) {
        
        self.currentPage --;
        
        if (self.currentPage != 1) {
            self.isUpable = YES;
        }
        else{
            self.isUpable = NO;
        }
        
        [self.delegate upWithOffset:(self.currentPage -1)*PAGELIMIT];
    }
    else{
        
        self.isUpable = NO;
 
        
    }
    
    
    
    
}

- (void)down{
    
   
    
    if (self.currentPage < self.pageCount) {
        
        self.currentPage ++;
        
        if (self.currentPage != self.pageCount) {
            
            self.isDownable = YES;
        }
        else{
            
            self.isDownable = NO;
        }
        
        self.isUpable = YES;
        
        [self.delegate downWithOffset:(self.currentPage - 1)*PAGELIMIT];
    }
    else{
        
        self.isDownable = NO;
    }
    
    
    
}

- (void)reply{
    
    [self.delegate reply];
    
    
}
@end
