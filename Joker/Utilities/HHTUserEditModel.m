//
//  STUserEditViewModel.m
//  SurfingTV
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "HHTUserEditModel.h"
#import <SDBaseRequest/SDBaseRequest.h>
#import "SDUploadImageAPI.h"
//#import "TOYUserManager.h"
#import "HHTUploadImageApi.h"
//#import "HHTUploadFileApi.h"
#import <CHProgressHUD/CHProgressHUD.h>
#import "JKIconCommitApi.h"
@implementation HHTUserEditModel

+ (void)updateIcon:(UIImage *)image success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler{
    
    NSString *name = [[NSUUID UUID] UUIDString];
    JKIconCommitApi *imageUploader = [[JKIconCommitApi alloc]initWithImage:image imageName:name fileName:name];
    [imageUploader startWithSuccessBlock:^(__kindof CHBaseRequest *request) {
        
        JKIconCommitApi *uploader = (JKIconCommitApi *)request;
        if (uploader.baseResponse.code == 200) {
            successHandler(uploader.baseResponse);
        } else {
            successHandler(uploader.baseResponse);
        }
    } failureBlock:^(__kindof CHBaseRequest *request) {
        if (failedHandler) {
            failedHandler();
        }
    }];

}

+ (void)updateAvatar:(UIImage *)image success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler {
    NSString *name = [[NSUUID UUID] UUIDString];
    SDUploadImageAPI *imageUploader = [[SDUploadImageAPI alloc]initWithImage:image imageName:name fileName:name];
    [imageUploader startWithSuccessBlock:^(__kindof CHBaseRequest *request) {
        
        SDUploadImageAPI *uploader = (SDUploadImageAPI *)request;
        if (uploader.baseResponse.code == 200) {
            successHandler(uploader.baseResponse);
        } else {
            successHandler(uploader.baseResponse);
        }
    } failureBlock:^(__kindof CHBaseRequest *request) {
        if (failedHandler) {
            failedHandler();
        }
    }];
}
+ (void)updateAvatarBuy:(UIImage *)image success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler {
    NSString *name = [[NSUUID UUID] UUIDString];
    HHTUploadImageApi *imageUploader = [[HHTUploadImageApi alloc]initWithImage:image imageName:name fileName:name];
    
    [CHProgressHUD show:YES];
    [imageUploader startWithSuccessBlock:^(__kindof HHTUploadImageApi *request) {
        
        HHTUploadImageApi *uploader = (HHTUploadImageApi *)request;
        if (uploader.baseResponse.code == 200) {
            successHandler(uploader.baseResponse);
            
           
        } else {
            successHandler(uploader.baseResponse);
        }
         [CHProgressHUD hide:NO];
    } failureBlock:^(__kindof HHTUploadImageApi *request) {
        if (failedHandler) {
            failedHandler();
        }
         [CHProgressHUD hide:NO];
        
        [CHProgressHUD showPlainText:@"操作失败,请重新尝试"];
    }];
}
+ (void)updateProfileInfo:(NSDictionary *)user success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler {

    SDUpdateProfileAPI *profileUpdater = [[SDUpdateProfileAPI alloc]initWithProfile:user];
    [profileUpdater startWithSuccessBlock:^(__kindof CHBaseRequest *request) {
        if (successHandler) {
            SDUpdateProfileAPI *updater = (SDUpdateProfileAPI *)request;
            if (updater.baseResponse.code == 200) {
                successHandler(updater.baseResponse);
            } else {
                successHandler(updater.baseResponse);
            }
        }
    } failureBlock:^(__kindof CHBaseRequest *request) {
        if (failedHandler) {
            failedHandler();
        }
    }];
}


//+ (void)updateFile:(UIImage *)image success:(void (^) (id userInfo))successHandler failed:(void (^) (void))failedHandler {
//    NSString *name = [[NSUUID UUID] UUIDString];
//    name = [NSString stringWithFormat:@"%@.jpg",name];
//    HHTUploadFileApi *imageUploader = [[HHTUploadFileApi alloc]initWithImage:image imageName:name fileName:name];
//    
//    [CHProgressHUD show:YES];
//    [imageUploader startWithSuccessBlock:^(__kindof HHTUploadImageApi *request) {
//        
//        HHTUploadImageApi *uploader = (HHTUploadImageApi *)request;
//        if (uploader.baseResponse.code == 200) {
//            successHandler(uploader.baseResponse);
//            
//            
//        } else {
//            successHandler(uploader.baseResponse);
//        }
//        [CHProgressHUD hide:NO];
//    } failureBlock:^(__kindof HHTUploadImageApi *request) {
//        if (failedHandler) {
//            failedHandler();
//        }
//        [CHProgressHUD hide:NO];
//        
//        [CHProgressHUD showPlainText:@"操作失败,请重新尝试"];
//    }];
//}
@end
