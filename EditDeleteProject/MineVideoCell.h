//
//  MineVideoCell.h
//  RepublicShare
//
//  Created by 王攀登 on 2017/10/13.
//  Copyright © 2017年 王攀登. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MineVideoModel;
@interface MineVideoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *videoImgView;
@property (nonatomic, strong) UIButton    *playButton;
@property (nonatomic, strong) UIView      *selectView;
@property (nonatomic, strong) UIImageView *selectImgView; //选中 未选中img

/**
 *  载入cell 数据
 *  @param dict      cell 数据源
 *  @param isEditing 是否处于编辑模式
 */
- (void)cellVideoInfoWithDictionary:(MineVideoModel *)model editingMode:(BOOL)isEditing;


+ (NSString *)reuseIdentifier;

@end
