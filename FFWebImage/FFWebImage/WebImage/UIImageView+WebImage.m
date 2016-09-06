//
//  UIImageView+WebImage.m
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/6.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import "FFWebImageManager.h"
#import <objc/runtime.h>

@implementation UIImageView (WebImage)


- (void)setImageWithURLString:(NSString *)URLString
{
    // 判断 URL
    if (![URLString isEqualToString:self.URLString]) {
        // 从缓冲池获取下载操作，并且取消
        [[FFWebImageManager sharedManager]cancelDownloadWithURLString:self.URLString];
        // 清空图片
        self.image=nil;
    }
    
    // 记录要下载的URL
    self.URLString=URLString;
    __weak typeof(self) weakSelf=self;
    [[FFWebImageManager sharedManager]downloadImageOperationWithURLString:self.URLString finished:^(UIImage *image) {
        weakSelf.image=image;
    }];
}

#pragma mark - 运行时关联对象

const void *FFURLStringKey=@"FFURLStringKey";

- (void)setURLString:(NSString *)URLString
{
    /**
     动态关联属性
     
     1、关联到的对象 self
     2、属性的 key
     3、记录属性的值
     4、属性的引用关系
     OBJC_ASSOCIATION_RETAIN_NONATOMIC 对应 ARC 中的 strong
     OBJC_ASSOCIATION_ASSIGN 对应 ARC 中的 assign
     MRC 中 没有 weak ，只有 assign
     
     weak 和 assign 区别，都不会强引用
     weak 引用的对象，一旦引用计数 为 0，会自动指向 nil
     assign 引用的对象，一旦引用计数 为 0，对象地址不变，因此 MRC 开发中，最常见的 bug 就是野指针
     
     默认的属性是什么：assign
     */
    objc_setAssociatedObject(self, FFURLStringKey, URLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)URLString
{
    /**
     1、关联到的对象 self
     2、属性的 key
     */
    return objc_getAssociatedObject(self, FFURLStringKey);
}

@end
