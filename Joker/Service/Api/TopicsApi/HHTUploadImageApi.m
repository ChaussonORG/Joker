//
//  TOYBuyUploadImageApi.m
//  ToyMan
//
//  Created by 郭金涛 on 16/9/9.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "HHTUploadImageApi.h"

@implementation HHTUploadImageApi{
    NSData *_imageData;
    
}
- (instancetype)initWithImage:(UIImage *)image
                    imageName:(NSString *)imageName
                     fileName:(NSString *)fileName{
    self = [super init];
    if (self) {
        NSParameterAssert(image);
        _imageName = imageName;
        _fileName = fileName;
        if (UIImagePNGRepresentation(image) == nil) {
            
            _imageData = UIImageJPEGRepresentation(image, 1);
            
        } else {
            
//            _imageData = UIImagePNGRepresentation(image);
            
            _imageData = UIImageJPEGRepresentation(image, 0.7);
        }
    }
    return self;
}

- (NSDictionary *)requestDataInfo{
    return @{@"data":_imageData,
             @"name":_imageName,
             @"filename":_fileName,
             @"mimeType":@"image/jpeg"};
}
- (CHRequestMethod)requestMethod{
    return CHRequestMethodPostData;
}
- (NSString *)requestPathUrl{
    return [NSString stringWithFormat:@"/admin/image"];
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
@end
