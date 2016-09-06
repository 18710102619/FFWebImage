//
//  FFWebImageOperation.h
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/5.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFWebImageOperation : NSOperation

///  类方法创建下载操作
+ (instancetype)downloadImageOperationWithURLString:(NSString *)URLString finished:(void (^)(UIImage *image))finished;

@end
