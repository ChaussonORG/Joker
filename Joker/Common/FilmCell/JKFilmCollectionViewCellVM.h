//
//  JKFilmCollectionViewCellVM.h
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JKFilmCollectionViewCellVM;
@protocol chooseFilmDelegate <NSObject>

- (void)fetchFilmCollectionViewCellVM:(JKFilmCollectionViewCellVM *)cellViewModel;

@end

@interface JKFilmCollectionViewCellVM : NSObject

@property (nonatomic , strong) NSString *projectId;

@property (nonatomic , strong) NSString *imageUrl;

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *joker_score;

@property (nonatomic , strong) NSString *type;

@property (nonatomic , weak) id<chooseFilmDelegate>delegate;

@property (nonatomic , assign) BOOL isON;

@property (nonatomic , strong) NSString *favotiteCount;

- (void)chosed;


@end
