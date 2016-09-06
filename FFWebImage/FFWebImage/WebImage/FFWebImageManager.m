//
//  FFWebImageManager.m
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/5.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFWebImageManager.h"
#import "FFWebImageOperation.h"
#import "NSString+Path.h"

@interface FFWebImageManager ()

/// 队列
@property(nonatomic,strong)NSOperationQueue *downloadQueue;
/// 操作缓冲池
@property(nonatomic,strong)NSMutableDictionary *operationCache;

@end

@implementation FFWebImageManager

#pragma mark - 懒加载

- (NSCache *)imageCache
{
    if (_imageCache==nil) {
        _imageCache=[[NSCache alloc]init];
        _imageCache.countLimit=15;
    }
    return _imageCache;
}

- (NSMutableDictionary *)operationCache
{
    if (_operationCache==nil) {
        _operationCache=[NSMutableDictionary dictionary];
    }
    return _operationCache;
}

- (NSOperationQueue *)downloadQueue
{
    if (_downloadQueue==nil) {
        _downloadQueue=[[NSOperationQueue alloc]init];
    }
    return _downloadQueue;
}

+ (instancetype)sharedManager
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[self alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self=[super init];
    if (self) {
        // 注册通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    // 注销通知
    // 提问：会执行到吗？不会执行到，但是，写了也没影响！
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)clearMemory
{
    // 1、取消所有下载操作
    [self.downloadQueue cancelAllOperations];
    // 2、清理缓冲池
    [self.operationCache removeAllObjects];
}

- (void)cancelDownloadWithURLString:(NSString *)URLString
{
    // 1、从操作缓冲池中获取到下载操作
    FFWebImageOperation *op=self.operationCache[URLString];
    if (op==nil) {
        return;
    }
    
    // 2、给操作发送 cancel 消息，取消操作
    NSLog(@"取消下载 ---> %@",URLString);
    [op cancel];
    
    // 3、从缓冲池中删除下载操作
    [self.operationCache removeObjectForKey:URLString];
}

- (void)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *))finished
{
    NSAssert(finished!=nil, @"必须传入 finished 回调");
    
    // 1、判断是否有相同的操作
    if (self.operationCache[URLString]!=nil) {
        NSLog(@"正在玩命下载中...稍安勿躁...");
        return;
    }
    
    // 2、检查缓存
    // 如果有缓存，直接返回缓存的图像
    if ([self checkImageCache:URLString]) {
        finished([self.imageCache objectForKey:URLString]);
        return;
    }
    
    // 3、实例化下载操作
    FFWebImageOperation *op=[FFWebImageOperation downloadImageOperationWithURLString:URLString finished:^(UIImage *image) {
        finished(image);
        // 从缓冲池删除操作
        [self.operationCache removeObjectForKey:URLString];
    }];
    
    // 4、添加到缓冲池
    [self.operationCache setObject:op forKey:URLString];
    
    // 5、添加到队列 - 开始下载
    [self.downloadQueue addOperation:op];
}

- (BOOL)checkImageCache:(NSString *)URLString
{
    // 1、检查内存缓存
    if ([self.imageCache objectForKey:URLString]!=nil) {
        NSLog(@"内存缓存");
        return YES;
    }
    
    // 2、检查沙盒缓存
    UIImage *image=[UIImage imageWithContentsOfFile:URLString.appendCachePath];
    if (image!=nil) {
        [self.imageCache setObject:image forKey:URLString];
        NSLog(@"沙盒缓存");
        return YES;
    }
    
    return NO;
}

@end
