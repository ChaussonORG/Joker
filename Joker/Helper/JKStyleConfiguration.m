//
//  HHTStyleConfiguration.m
//  Shipping
//
//  Created by 朱彦君 on 16/5/11.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "JKStyleConfiguration.h"
#import "UIColor+Hex.h"

#define PINGFANG_FONT(size) [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ?[UIFont fontWithName:@"PingFangSC-Regular" size:size]:[UIFont fontWithName:@"Helvetica" size:size];

#define IS_LOWER_IPHONE6_SCREEN [[UIScreen mainScreen] bounds].size.height == 568

@implementation JKStyleConfiguration
#pragma mark Font
+ (UIFont *)naviTitleFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        size = 17.0;
    }
    else{
        
        size = 17.0;
    }
    
    return PINGFANG_FONT(size);
    
}
+ (UIFont *)mainTitleFont{
    
    CGFloat size ;
    
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        size = 20.0;
    }
    else{
        
        size = 21.0;
    }
    
    return PINGFANG_FONT(size);
    
}
+ (UIFont *)titleFont{
    
    CGFloat size ;
    
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        size = 14.0;
    }
    else{
        
        size = 15.0;
    }
    
    return PINGFANG_FONT(size);
}


+ (UIFont *)contentFont{
    
    
    CGFloat size ;
    
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        size = 11.0;
    }
    else{
        
        size = 12.0;
    }
    
    return  PINGFANG_FONT(size);
    
}

+ (UIFont *)subcontentFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        
        size = 12.0;
    }
    else{
        
        size = 13.0;
    }
    
    
    
    return  PINGFANG_FONT(size);
    
}
+ (UIFont *)minContentFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        
        size = 9.0;
    }
    else{
        
        size = 10.0;
    }
    
    
    
    return  PINGFANG_FONT(size);
    
}

+ (UIFont *)middlecontentFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        
        size = 8.0;
    }
    else{
        
        size = 9.0;
    }
    
    return  PINGFANG_FONT(size);
    
}
+ (UIFont *)minicontentFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        
        size = 8.0;
    }
    else{
        
        size = 8.0;
    }
    
    return  PINGFANG_FONT(size);
    
}

+ (UIFont *)overstrikingFont{
    
    
    CGFloat size ;
    
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        size = 15.0;
    }
    else{
        
        size = 16.0;
    }
    
    return  PINGFANG_FONT(size);
    
}

+ (UIFont *)hugeFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        
        size = 16.0;
    }
    else{
        
        size = 17.0;
    }
    
    return  PINGFANG_FONT(size);
    
}

+ (UIFont *)numberFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        
        size = 18.0;
    }
    else{
        
        size = 19.0;
    }
    
    return  PINGFANG_FONT(size);
    
    
}

+ (UIFont *)veryHugeFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        
        size = 18.0;
    }
    else{
        
        size = 19.0;
    }
    
    return  PINGFANG_FONT(size);
    
    
}


+ (UIFont *)MasterFont{
    
    CGFloat size ;
    
    if (IS_LOWER_IPHONE6_SCREEN) {
        
        size = 28.0;
    }
    else{
        
        size = 30.0;
    }
    
    return  PINGFANG_FONT(size);
    
    
}

#pragma mark Color

+ (UIColor *)blueMainColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration blueMainColorHex]];
}
+ (UIColor *)redColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration
                                        redColorHex]];
}
+ (UIColor *)orangeColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration orangeColorHex]];
}
+ (UIColor *)greenColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration greenColorHex]];
}
+ (UIColor *)drakGrayTextColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration drakGrayTextColorHex]];
}
+ (UIColor *)lightGrayTextColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration lightGrayTextColorHex]];
}
+ (UIColor *)grayTextColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration grayTextColorHex]];
}

+ (UIColor *)whiteColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration whiteColorHex]];
}
+ (UIColor *)screenBackgroundColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration screenBackgroundColorHex]];
}


+ (UIColor *)screenSpareColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration screenSpareColorHex]];
}

+ (UIColor *)blackColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration blackColorHex]];
}

+ (UIColor *)lineColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration lineColorHex]];
}

+ (UIColor *)borderColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration borderColorHex]];
}

+ (UIColor *)yellowColor{
    return [UIColor colorWithHexString:[JKStyleConfiguration yellowColorHex]];
}
+ (UIColor *)pickViewBgColor
{
    return [UIColor colorWithHexString:[JKStyleConfiguration pickViewBgColorHex]];
    
}

+ (UIColor *)placeHolderColor
{
    return [UIColor colorWithHexString:[JKStyleConfiguration placeHolderColorHex]];
    
}


+ (UIColor *)borderLineColor
{
    return [UIColor colorWithHexString:[JKStyleConfiguration borderLineColorHex]];
    
}


+ (UIColor *)purpleColor
{
    return [UIColor colorWithHexString:[JKStyleConfiguration purpleColorHex]];
    
}


+ (UIColor *)blueBorderColor
{
    return [UIColor colorWithHexString:[JKStyleConfiguration blueBorderColorHex]];
    
}


+ (UIColor *)orangeBorderColor
{
    return [UIColor colorWithHexString:[JKStyleConfiguration orangeBorderColorHex]];
    
}


+ (UIColor *)veryLightGrayTextColor
{
    return [UIColor colorWithHexString:[JKStyleConfiguration veryLightGrayTextColorHex]];
    
}

+ (UIColor *)grayBackgroundColor
{
    return [UIColor colorWithHexString:[JKStyleConfiguration grayBackgroundColorHex]];
    
}

+ (UIColor *)blueKeywordColor{
    
    return [UIColor colorWithHexString:[JKStyleConfiguration blueKeywordColorHex]];
    
}


+ (UIColor *)aaaaaaColor{
    
    return [UIColor colorWithHexString:[JKStyleConfiguration aaaaaaColorHex]];
    
}

+ (UIColor *)eeeeeeColor{
    
    return [UIColor colorWithHexString:[JKStyleConfiguration eeeeeeColorHex]];
    
}


+ (UIColor *)bbbbbbColor{
    
    return [UIColor colorWithHexString:[JKStyleConfiguration bbbbbbColorHex]];
    
}


+ (UIColor *)ccccccColor{
    
    return [UIColor colorWithHexString:[JKStyleConfiguration ccccccColorHex]];
    
}

+ (UIColor *)ddddddColor{
    
    return [UIColor colorWithHexString:[JKStyleConfiguration ddddddColorHex]];
    
}

+ (NSString *)eeeeeeColorHex{
    return @"#eeeeee";
}

+ (NSString *)aaaaaaColorHex{
    return @"#aaaaaa";
}

+ (NSString *)bbbbbbColorHex{
    return @"#bbbbbb";
}

+ (NSString *)ccccccColorHex{
    return @"#cccccc";
}

+ (NSString *)ddddddColorHex{
    return @"#dddddd";
}



+ (UIColor *)sixsixColor{
    
    return [UIColor colorWithHexString:[JKStyleConfiguration sixsixColorHex]];
    
}

+ (UIColor *)twotwoColor{
    
    return [UIColor colorWithHexString:[JKStyleConfiguration twotwoColorHex]];
    
}

+ (UIColor *)ninenineColor{
    
     return [UIColor colorWithHexString:[JKStyleConfiguration ninenineColorHex]];
}

+ (NSString *)sixsixColorHex{
    return @"#666666";
}


+ (NSString *)pickViewBgColorHex{
    return @"#E7E7E7";
}

+ (NSString *)blueMainColorHex{
    return @"#00A0DC";
}
+ (NSString *)redColorHex{
    return @"#ff501e";
}
+ (NSString *)orangeColorHex{
    return @"#F6A623";
}
+ (NSString *)greenColorHex{
    return @"32B500";
}
+ (NSString *)drakGrayTextColorHex{
    return @"#888888";
}
+ (NSString *)lightGrayTextColorHex{
    return @"#aaaaaa";
}
+ (NSString *)grayTextColorHex{
    return @"#b4b4b4";
}
+ (NSString *)whiteColorHex{
    return @"#FFFFFF";
}
+ (NSString *)screenBackgroundColorHex{
    return @"#F2F2F2";
}

+ (NSString *)screenSpareColorHex{
    return @"#FAFAFA";
}
+ (NSString *)blackColorHex{
    return @"#444444";
}

+ (NSString *)lineColorHex{
    return @"#eeeeee";
}

+ (NSString *)borderColorHex{
    return @"#C3C3C3";
}


+ (NSString *)yellowColorHex{
    return @"#F49031";
}


+ (NSString *)placeHolderColorHex{
    return @"#A8A8A8";
}


+ (NSString *)borderLineColorHex{
    return @"#989898";
}

+ (NSString *)purpleColorHex{
    return @"#6D47F8";
}


+ (NSString *)blueBorderColorHex{
    return @"#00A5FF";
}

+ (NSString *)orangeBorderColorHex{
    return @"#EA4D16";
}


+ (NSString *)veryLightGrayTextColorHex{
    return @"#A8A8A8";
}


+ (NSString *)grayBackgroundColorHex{
    return @"#F5F5F5";
}


+ (NSString *)blueKeywordColorHex{
    
    return @"#507db9";
    
}

+ (NSString *)twotwoColorHex{
    
    return @"#222222";
    
}


+ (NSString *)ninenineColorHex{
    
    return @"#999999";
}

+(NSString*)convertNull:(id)object{
    
    // 转换空串
    
    if ([object isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if (object==nil){
        return @"无";
    }
    return object;
    
}
@end
