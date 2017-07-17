
//
//  TypeEnumClass.h
//  joker
//
//  Created by 肖松 on 15-8-1.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#ifndef joker_TypeEnumClass_h
#define joker_TypeEnumClass_h
#define JokerReduceAction @"down"
#define JokerAddAction @"up"
// 分类的类型
typedef NS_ENUM(NSInteger, JokerClassifyType)
{
    JokerNewsType = 0,
    JokerFilmType = 1,
    JokerTvType = 2,
    JokerGameType = 3,
    JokerCartoonType = 4,
    JokerTopicType = 5
};
//时间类型
typedef NS_ENUM(NSInteger, DateFormatType)
{
    DateFormatWithAll ,
    DateFormatWithDay ,
    DateFormatWithMouth ,
    DateFormatWithYear
};
// 刷新类型
typedef NS_ENUM(NSInteger, JokerRefreshType)
{
    JokerRefreshDown,
    JokerRefreshUp
};
typedef NS_ENUM(NSInteger, UIHomeViewState) {
    UIHomeViewUnSelectdState,
    UIHomeViewOnSelectdState
};
typedef NS_ENUM(NSInteger, UIHomeBarShowState) {
    UIHomeBarApper,
    UIHomeBarDisApper
};
typedef NS_ENUM(NSInteger, HomeScrollViewState) {
    HomeScrollViewBeginScroll,
    HomeScrollViewEndScroll,
    HomeScrollViewDidEndScroll,
};
typedef NS_ENUM(NSInteger, DetailPageScrollState) {
    DetailPageScrollTop,
    DetailPageScrollBottom,
    DetailPageScrollDidBottom
};

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);
// 更新block
typedef void (^UpdateDataBlock)(NSInteger type);
#endif
