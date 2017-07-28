//
//  HHTStyleConfiguration.h
//  Shipping
//
//  Created by 朱彦君 on 16/5/11.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface  JKStyleConfiguration : NSObject


#pragma mark Font

/*
 *导航栏标题字体
 */
+ (UIFont *)naviTitleFont;
/*
 *主标题字体
 */
+ (UIFont *)mainTitleFont;
/*
 *标题字体
 */
+ (UIFont *)titleFont;
/*
 *内容字体
 */
+ (UIFont *)contentFont;
/*
 *详细内容字体
 */
+ (UIFont *)subcontentFont;
/*
 *历史信息字体
 */
+ (UIFont *)middlecontentFont;
/*
 *加粗字体
 */
+ (UIFont *)overstrikingFont;
/*
 *大字体
 */
+ (UIFont *)hugeFont;
/*
 *数字字体
 */

+ (UIFont *)numberFont;

/*
 *小字体
 */
+ (UIFont *)minicontentFont;
/*
 *最大字体
 */
+ (UIFont *)MasterFont;


+ (UIFont *)minContentFont;


+ (UIFont *)veryHugeFont;

#pragma mark Color

+ (UIColor *)blueMainColor;
+ (UIColor *)redColor;
+ (UIColor *)orangeColor;
+ (UIColor *)greenColor;
+ (UIColor *)drakGrayTextColor;
+ (UIColor *)lightGrayTextColor;
+ (UIColor *)grayTextColor;
+ (UIColor *)whiteColor;
+ (UIColor *)screenBackgroundColor;
+ (UIColor *)blackColor;
+ (UIColor *)lineColor;
+ (UIColor *)borderColor;
+ (UIColor *)yellowColor;
+ (UIColor *)pickViewBgColor;
+ (UIColor *)placeHolderColor;

+ (UIColor *)borderLineColor;
+ (UIColor *)purpleColor;
+ (UIColor *)blueBorderColor;
+ (UIColor *)orangeBorderColor;
+ (UIColor *)veryLightGrayTextColor;

+ (UIColor *)screenSpareColor;

+ (UIColor *)grayBackgroundColor;


+ (UIColor *)blueKeywordColor;


+ (UIColor *)aaaaaaColor;

+ (UIColor *)bbbbbbColor;

+ (UIColor *)ccccccColor;

+ (UIColor *)sixsixColor;
/*
 *转换空字符串
 */
+(NSString*)convertNull:(id)object;
@end
