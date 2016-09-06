//
//  FFAppViewCell.m
//  FFWebImage
//
//  Created by 张玲玉 on 16/9/6.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFAppViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebImage.h"

#define kGap 15

@interface FFAppViewCell ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *downloadLabel;

@end

@implementation FFAppViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconView=[[UIImageView alloc]init];
        //_iconView.backgroundColor=[UIColor orangeColor];
        [self addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.left.equalTo(@(kGap));
            make.centerY.equalTo(@(0));
        }];
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont systemFontOfSize:20];
        //_nameLabel.backgroundColor=[UIColor yellowColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(kGap));
            make.left.equalTo(_iconView.mas_right).with.offset(15);
            make.right.equalTo(@(-kGap));
            make.height.equalTo(@(25));
        }];
        
        _downloadLabel=[[UILabel alloc]init];
        _downloadLabel.font=[UIFont systemFontOfSize:16];
        _downloadLabel.textColor=[UIColor grayColor];
        //_downloadLabel.backgroundColor=[UIColor orangeColor];
        [self addSubview:_downloadLabel];
        [_downloadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-kGap));
            make.left.equalTo(_iconView.mas_right).with.offset(15);
            make.right.equalTo(@(-kGap));
            make.height.equalTo(@(17));
        }];
    }
    return self;
}

- (void)setModel:(FFAppModel *)model
{
    self.nameLabel.text = model.name;
    self.downloadLabel.text = model.download;
    [self.iconView setImageWithURLString:model.icon];
}

@end
