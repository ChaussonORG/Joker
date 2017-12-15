//
//  CHCommonMacro.h
//  Shipping
//
//  Created by Chausson on 16/5/23.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#ifndef CHCommonMacro_h
#define CHCommonMacro_h

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define CH_TRANSFORM_TEXTSIZE(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
/* 计算文字高度宽度 */
#define CHSCREEN_IPHONE_4 [UIScreen mainScreen].bouxnds.size.width == 480
#define CHSCREEN_IPHONE_5 [UIScreen mainScreen].bounds.size.width == 568
#define CHSCREEN_IPHONE_6 [UIScreen mainScreen].bounds.size.width == 667
#define CHSCREEN_IPHONE_6PLUS [UIScreen mainScreen].bounds.size.width == 736
#define CHSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CHSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define CHFORMATESTR(formate,units,value) value?[NSString stringWithFormat:@"%@：%@%@",formate,value,units]:[NSString stringWithFormat:@"%@：",formate];

#define __WEAK_SELF_CHSLIDE     __weak typeof(self) weakSelf = self;
#define __STRONG_SELF_CHSLIDE   __strong typeof(weakSelf) strongSelf = weakSelf;


#define RequestLimit 10
#endif /* CHCommonMacro_h */
