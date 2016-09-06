//
//  UIImageView+WebImage.h
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/6.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

/// 图片对应的URL
@property(nonatomic,copy)NSString *URLString;

/// 设置 URLString 对应的网络图像
- (void)setImageWithURLString:(NSString *)URLString;

@end
