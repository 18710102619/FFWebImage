//
//  FFWebImageManager.h
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/5.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFWebImageManager : NSObject

/// 图像缓冲池
/// 如果内存吃紧，缓存被释放，还可以从沙盒继续加载
/// 注意：使用NSCache，一定要保证缓存的对象即使被释放，依然有途径加载回来！
@property(nonatomic,strong)NSCache *imageCache;

/// 单例的全局入口
+ (instancetype)sharedManager;

/// 负责下载指定的URL
- (void)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *image))finished;

/// 取消指定 URLString 对应的下载操作
- (void)cancelDownloadWithURLString:(NSString *)URLString;

@end
