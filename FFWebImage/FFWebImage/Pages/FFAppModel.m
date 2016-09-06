//
//  FFAppModel.m
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/6.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFAppModel.h"

@implementation FFAppModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    id model=[[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

+ (NSMutableArray *)appModels
{
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"app" withExtension:@"plist"];
    NSArray *array=[NSArray arrayWithContentsOfURL:url];
    NSMutableArray *models=[NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [models addObject:[self modelWithDict:obj]];
    }];
    return models;
}

@end
