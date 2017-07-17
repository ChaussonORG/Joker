//
//  config.h
//  joker
//
//  Created by 肖松 on 15-6-15.
//  Copyright (c) 2015年 chausson. All rights reserved.
//

#ifndef joker_config_h
#define joker_config_h


#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IOS6 [[[UIDevice currentDevice]systemVersion]floatValue] >= 6.0 && [[[UIDevice currentDevice]systemVersion]floatValue] < 7.0
#define IOS7 [[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0 && [[[UIDevice currentDevice]systemVersion]floatValue] < 8.0
#define IOS8 [[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0


#define IOScreenH6Plus [[UIScreen mainScreen] bounds].size.height == 736
#define IOScreenH6 [[UIScreen mainScreen] bounds].size.height == 667
#define IOScreenH5 [[UIScreen mainScreen] bounds].size.height == 568
#define IOScreenH4 [[UIScreen mainScreen] bounds].size.height == 480
#define IOScreenW5 [[UIScreen mainScreen] bounds].size.width == 320
#define Iphone6Plus   [UIScreen mainScreen].bounds.size.width == 414
#define Iphone6   [UIScreen mainScreen].bounds.size.width == 375
#define IOSScreenH   [UIScreen mainScreen].bounds.size.height
#define IOSScreenW   [UIScreen mainScreen].bounds.size.width
#define IOSSYSTEM9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 &&[[[UIDevice currentDevice] systemVersion] floatValue] < 10.0
#define KLeftViewWidth IOSScreenW/5*4
#define KAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define KImageScaleH 0.33358321 
#define KGameScaleH 0.27673897
#define KImageScaleW 0.346
#define KHomeBarHeight 64
#define KMAINCOLOR 0xf0f0f5
#define HeiTiFontMedium @"STHeitiK-Medium"
#define HeiTiFontLight @"STHeitiK-Light"
#define HelveticaFontBold @"Helvetica-Bold"
#define HelveticaFontMedium @"Helvetica-Neue-Medium"
#define HelveticaFont @"Helvetica"
#define KWebService @"http://icodeyp.sinaapp.com/"
#define KHomeApiUrl @"findypInfo.action"
#define KAddCommentApiUrl @"addPinglunInfo.action"
#define KNewsApiUrl @"findypNews.action"
#define KCommentApiUrl @"addPinglunInfo.action"
#define KAllCommentApiUrl @"findPinglunInfoByid.action"
#define KRegisterApiUrl @"addUser.action"
#define LoginActionApi @"findUsersByAccount.action"
#define RegisterActionApi @"addUser.action"
#define KDetailApi @"findypInfoByid.action"
#define KFavourlApi @"addCollect.action"
#define KCommentBehavior @"updateFavourNumber.action"
#define KWantedApi @"getWantedInfo.action"
#define KWatchedApi @"getWatchedInfo.action"
#define KBarTag 1001
#define KStatusSuccess @"200"
#define KWIFITAP @"服务器请求失败,请检查您的网络状态是否连接"

#define JokerAppKey @"a123492f8ac0"
#define JokerAppSecret @"d0b21e4db2698734dfaacb84fba2e689"
#define JokerAccountKey @"Info"
#define JokerCommentMessageIndexOne @"我对导演只剩下同情"
#define JokerCommentMessageIndexTwo @"已造成生理不适"
#define JokerCommentMessageIndexThree @"已造成心理不适"
#define JokerCommentMessageIndexFour @"看完这片，我的下限又降低了"
#define JokerCommentMessageIndexFive @"不值一看"
#define JokerCommentMessageIndexSix @"凑合，及格"
#define JokerCommentMessageIndexSeven @"还行，值得一看"
#define JokerCommentMessageIndexEight @"好看，值得推荐"
#define JokerCommentMessageIndexNine @"太好看了，一定要看"
#define JokerCommentMessageIndexTen @"神作，不看人生不完整"

#endif
