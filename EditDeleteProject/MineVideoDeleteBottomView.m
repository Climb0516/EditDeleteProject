//
//  MineVideoDeleteBottomView.m
//  RepublicShare
//
//  Created by 王攀登 on 2017/10/13.
//  Copyright © 2017年 王攀登. All rights reserved.
//

#import "MineVideoDeleteBottomView.h"

#import <Masonry.h>

#import "RSCustomButton.h"

@interface MineVideoDeleteBottomView ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation MineVideoDeleteBottomView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
        horizontalLine.backgroundColor = [UIColor grayColor];
        [self addSubview:horizontalLine];
        
        RSCustomButton *deleteButton = [RSCustomButton new];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [deleteButton setImage:[UIImage imageNamed:@"mine_set_delete"] forState:UIControlStateNormal];
        [deleteButton setImagePosition:LXMImagePositionTop spacing:5.0f];
        [deleteButton addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(8.0f);
            make.centerX.equalTo(self.mas_centerX);
            make.left.offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.height.mas_equalTo(40.0f);
        }];
    }
    return self;
}

- (void)deleteBtnAction {
    if (self.deleteBtnActionBlock) {
        self.deleteBtnActionBlock();
    }
}

@end
