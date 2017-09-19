//
//  JKIconCommitApi.m
//  Joker
//
//  Created by 朱彦君 on 2017/9/19.
//  Copyright © 2017年 朱彦君. All rights reserved.
//

#import "JKIconCommitApi.h"
 
@implementation JKIconCommitApi{
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
    return [NSString stringWithFormat:@"/app/image"];
}
- (void)requestCompletionBeforeBlock{
    _baseResponse = [[SDBaseResponse alloc]initWithJSON:self.response.responseJSONObject];
}
@end
