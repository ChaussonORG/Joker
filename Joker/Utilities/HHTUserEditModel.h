//
//  STUserEditViewModel.h
//  SurfingTV
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "TOYUser.h"

@interface HHTUserEditModel : NSObject

+ (void)updateAvatar:(UIImage *)image success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler;
+ (void)updateProfileInfo:(NSDictionary *)user success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler;
+ (void)updateAvatarBuy:(UIImage *)image success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler;

+ (void)updateFile:(UIImage *)image success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler;

+ (void)updateIcon:(UIImage *)image success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler;
@end
