//
//  FFAppViewController.m
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/6.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFAppViewController.h"
#import "FFAppViewCell.h"

@interface FFAppViewController ()

@property(nonatomic,strong)NSArray *appModels;

@end

@implementation FFAppViewController

- (NSArray *)appModels
{
    if (_appModels==nil) {
        _appModels=[FFAppModel appModels];
    }
    return _appModels;
}

#pragma - mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.appModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"postCell";
    FFAppViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[FFAppViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    FFAppModel *model=self.appModels[indexPath.row];
    cell.model=model;
    return cell;
}

#pragma - mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
