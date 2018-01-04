//
//  MineVideoCell.m
//  RepublicShare
//
//  Created by 王攀登 on 2017/10/13.
//  Copyright © 2017年 王攀登. All rights reserved.
//

#import "MineVideoCell.h"

#import <Masonry.h>
#import <UIImageView+WebCache.h>

#import "MineVideoModel.h"

@implementation MineVideoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self generalUI];
    }
    return self;
}

- (void)generalUI {
    self.videoImgView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.videoImgView];
    
//    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.playButton setImage:[UIImage imageNamed:@"CHPlayer_play"] forState:UIControlStateNormal];
//    self.playButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//    self.playButton.layer.masksToBounds = YES;
//    self.playButton.layer.cornerRadius  = 25;
//    [self.playButton addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.videoImgView addSubview:self.playButton];
    
    // 编辑状态下，附加视图，显示选中效果
    
    self.selectView = [UIView new];
    self.selectView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.videoImgView addSubview:self.selectView];
    
    self.selectImgView = [UIImageView new];
    self.selectImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.selectView addSubview:self.selectImgView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_videoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
//    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(_videoImgView);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
//    }];
    [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.offset(0);
    }];
    [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [_selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(3);
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.right.equalTo(self.selectView.mas_right).offset(-3);
    }];
}

- (void)cellVideoInfoWithDictionary:(MineVideoModel *)model editingMode:(BOOL)isEditing {
    [self.videoImgView sd_setImageWithURL:[NSURL URLWithString:model.video_pic]  placeholderImage:[UIImage imageNamed:@"default"]];
    
    if (isEditing) {
        self.selectView.hidden = NO;
        if (model.isSelected){
            self.selectImgView.image = [UIImage imageNamed:@"photo_check_selected"];
        }else {
            self.selectImgView.image = [UIImage imageNamed:@"photo_check_default"];
        }
    }else {
        self.selectView.hidden = YES;
    }
    
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
