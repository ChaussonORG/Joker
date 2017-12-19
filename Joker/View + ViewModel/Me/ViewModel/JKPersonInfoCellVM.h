//
//  JKPersonInfoCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/12/9.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JKPersonInfoType){
    JKPersonInfoImage,
    JKPersonInfoWord,
};
@interface JKPersonInfoCellVM : NSObject

@property (nonatomic , strong) NSString *mainTitle;

//@property (nonatomic , strong) NSString *headerimage;

@property (nonatomic , strong) NSString *content;

@property (nonatomic , assign) JKPersonInfoType type;


- (void)gotoEditInfo;
@end
