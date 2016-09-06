//
//  FFAppModel.h
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/6.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFAppModel : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *download;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)appModels;

@end
