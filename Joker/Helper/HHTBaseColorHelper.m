//
//  HHTBaseColorHelper.m
//  Shipping
//
//  Created by Chausson on 16/5/10.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "HHTBaseColorHelper.h"
#import "UIColor+Hex.h"
@implementation HHTBaseColorHelper
+ (UIColor *)blueMainColor{
    return [UIColor colorWithHexString:[HHTBaseColorHelper blueMainColorHex]];
}
+ (UIColor *)redColor{
    return [UIColor colorWithHexString:[HHTBaseColorHelper redColorHex]];
}
+ (UIColor *)orangeColor{
    return [UIColor colorWithHexString:[HHTBaseColorHelper orangeColorHex]];
}
+ (UIColor *)greenColor{
    return [UIColor colorWithHexString:[HHTBaseColorHelper greenColorHex]];
}
+ (UIColor *)drakGrayTextColor{
    return [UIColor colorWithHexString:[HHTBaseColorHelper drakGrayTextColorHex]];
}
+ (UIColor *)lightGrayTextColor{
    return [UIColor colorWithHexString:[HHTBaseColorHelper lightGrayTextColorHex]];
}
+ (UIColor *)grayTextColor{
    return [UIColor colorWithHexString:[HHTBaseColorHelper grayTextColorHex]];
}
+ (UIColor *)lineColor{
    return [UIColor colorWithHexString:@"E5E5E5"];
}

+ (NSString *)blueMainColorHex{
    return @"#0052B5";
}
+ (NSString *)redColorHex{
    return @"DB0000";
}
+ (NSString *)orangeColorHex{
    return @"DB8A00";
}
+ (NSString *)greenColorHex{
    return @"32B500";
}
+ (NSString *)drakGrayTextColorHex{
    return @"404040";
}
+ (NSString *)lightGrayTextColorHex{
    return @"808080";
}
+ (NSString *)grayTextColorHex{
    return @"bfbfbf";
}
@end
