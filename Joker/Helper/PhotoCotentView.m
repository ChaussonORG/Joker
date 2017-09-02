//
//  PhotoCotentView.m
//  CorePhotoBroswerVC
//
//  Created by 冯成林 on 15/5/15.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "PhotoCotentView.h"

@implementation PhotoCotentView



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    NSUInteger maxRow = _images.count%4 == 0?_images.count/4: _images.count/4 + 1;
    
    NSUInteger maxCol = 4;
    
    CGFloat width = (ScreenWidth - 50)/4;
    
    CGFloat height = width;

    
    //遍历
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        
        NSUInteger row = idx % 4;
        
        NSUInteger col = idx / 4;
        
        CGFloat x = 10 + row * (width + 10);
        
        CGFloat y = col * (height + 10);
        
        CGRect frame = CGRectMake(x, y, width, height);
        
        NSLog(@"x = %f , y = %f , width = %f ,height = %f",frame.origin.x,frame.origin.y ,frame.size.width ,frame.size.height);
        
        subView.frame = frame;
    }];
}



-(void)setImages:(NSArray *)images{
    
    _images = images;
    
    [images enumerateObjectsUsingBlock:^(NSString *image, NSUInteger idx, BOOL *stop) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        int width = (ScreenWidth - 50)/4;
        
        image = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,m_lfit,h_%d,w_%d",image,width,width];
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:image]];
        
        //开启事件
        imageV.userInteractionEnabled = YES;
        
        //模式
        imageV.contentMode=UIViewContentModeScaleAspectFit;
        
        imageV.clipsToBounds = YES;
        
        //添加手势
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage:)]];
        
        //设置tag
        imageV.tag = idx;
        
        [self addSubview:imageV];
    }];
}


-(void)touchImage:(UITapGestureRecognizer *)tap{
    if(_ClickImageBlock != nil) _ClickImageBlock(tap.view.tag);
}




@end
