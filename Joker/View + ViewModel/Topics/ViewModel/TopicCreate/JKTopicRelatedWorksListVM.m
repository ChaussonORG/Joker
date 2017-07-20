//
//  JKTopicRelatedWorksListVM.m
//  Joker
//
//  Created by 朱彦君 on 2017/7/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKTopicRelatedWorksListVM.h"
#import "JKMyfavoriteWorksApi.h"

@interface JKTopicRelatedWorksListVM()<chooseFilmDelegate>
@property (nonatomic , strong) NSMutableArray <JKFilmCollectionViewCellVM*>*tempCellViewModels;

@end
@implementation JKTopicRelatedWorksListVM
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cellViewModels = [NSMutableArray array];
        
        self.tempCellViewModels = [NSMutableArray array];
    }
    return self;
}



- (void)reloadData{
     
    JKMyfavoriteWorksApi *api = [[JKMyfavoriteWorksApi alloc]init];
    api.requestModel.limit = 200;
    
    [api startWithSuccessBlock:^(__kindof JKMyfavoriteWorksApi *request) {
        
        NSMutableArray <JKFilmCollectionViewCellVM*>*cellViewModels = [NSMutableArray array];
        for (JKMyfavoriteWorksModelItems *items in request.model.data.items) {
            
            [cellViewModels addObject:[self assembleViewModelWithItems:items]];
            
        }
        
        self.cellViewModels = [cellViewModels copy];
        
        self.tempCellViewModels = [cellViewModels copy];
        
    } failureBlock:^(__kindof JKMyfavoriteWorksApi *request) {
        
        
        
        
    }];
    
    
}

- (JKFilmCollectionViewCellVM *)assembleViewModelWithItems:(JKMyfavoriteWorksModelItems *)items{
    
    JKFilmCollectionViewCellVM *cellVM = [[JKFilmCollectionViewCellVM alloc]init];
    
    cellVM.delegate = self;
     cellVM.type = items.type;
    
    NSString *imageUrl;
    NSString *name;
    NSString *score;
    NSString *projectId;
    
    if ([items.type isEqualToString:@"MOVIE"]) {
        
        name = items.film.name;
        
        imageUrl = items.film.coverImage;
        
        projectId = items.film.id;
        
        score = items.film.joker_score;
        
    }
    else if ([items.type isEqualToString:@"TV"]) {
        
        name = items.tv.name;
        
        imageUrl = items.tv.coverImage;
        
        projectId = items.tv.id;
        
        score = items.tv.joker_score;
        
    }
    else if ([items.type isEqualToString:@"ANIMATION"]) {
        
        
        name = items.animation.name;
        
        imageUrl = items.animation.coverImage;
        
        projectId = items.animation.id;
        
        score = items.animation.joker_score;
    }
    
    else if ([items.type isEqualToString:@"GAME"]) {
        
        name = items.game.name;
        
        imageUrl = items.game.coverImage;
        
        projectId = items.game.id;
        
        score = items.game.joker_score;
        
    }
    else if ([items.type isEqualToString:@""]) {
        
        
        
    }
    cellVM.name = name;
    
    cellVM.imageUrl = imageUrl;
    
    cellVM.projectId = projectId;
    
    cellVM.joker_score = score;
    
    return cellVM;
    
    
}
- (void)fetchSearchKeywords:(NSString *)keywords{
     
    if (keywords.length == 0 || [[NSString stringWithFormat:@"%d",[keywords characterAtIndex:0]] isEqualToString:@" "]) {
        
        
         self.cellViewModels = [self.tempCellViewModels copy];
       
        
    }
    else{
        
        
        NSMutableArray <JKFilmCollectionViewCellVM*>*cellViewModels = [NSMutableArray array];
        
        for (JKFilmCollectionViewCellVM *cellVM in self.tempCellViewModels) {
            
            if ([cellVM.name containsString:keywords]) {
                
                [cellViewModels addObject:cellVM];
                
            }
        }
         self.cellViewModels = [cellViewModels copy];
        
    }
}

-(void)fetchFilmCollectionViewCellVM:(JKFilmCollectionViewCellVM *)cellViewModel{
    
    [self.delegate fetchRelateWork:cellViewModel.projectId relateType:cellViewModel.type relateWorkName:cellViewModel.name];
    
    [[ASNavigator shareModalCenter] popFormerlyViewControllerWithAnimation:YES];
    
}
@end
