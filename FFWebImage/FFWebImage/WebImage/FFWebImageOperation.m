//
//  FFWebImageOperation.m
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/5.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFWebImageOperation.h"
#import "NSString+Path.h"

@interface FFWebImageOperation ()

/// 下载图像的 URL
@property(nonatomic,copy)NSString *URLString;
/// 定义完成回调，注意不要使用 completionBlock;
@property(nonatomic,copy)void(^finishedBlock)(UIImage *image);

@end

@implementation FFWebImageOperation

///  类方法创建下载操作
+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *image))finished
{
    FFWebImageOperation *op=[[self alloc]init];
    op.URLString=URLString;
    op.finishedBlock=finished;
    return op;
}

- (void)main
{
    @autoreleasepool {
        NSAssert(self.finishedBlock != nil, @"没有传递 finished 回调");
        NSLog(@"正在下载 %@",self.URLString);
        
        NSURL *url=[NSURL URLWithString:self.URLString];
        NSData *data=[NSData dataWithContentsOfURL:url];
        
        if (self.isCancelled) {
            NSLog(@"%@ 被取消",self.URLString);
            return;
        }
        
        // 将数据保存至沙盒
        if (data!=nil) {
            [data writeToFile:self.URLString.appendCachePath atomically:YES];
            NSLog(@"%@",self.URLString.appendCachePath);
        }
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.finishedBlock([UIImage imageWithData:data]);
        }];
    }
}

@end
