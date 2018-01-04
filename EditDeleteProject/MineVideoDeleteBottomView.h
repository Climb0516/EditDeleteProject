//
//  MineVideoDeleteBottomView.h
//  RepublicShare
//
//  Created by 王攀登 on 2017/10/13.
//  Copyright © 2017年 王攀登. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BottomViewStyle){
    BottomViewStyleDefaulet,
    BottomViewStyleOnlySave
};
@interface MineVideoDeleteBottomView : UIView


@property (nonatomic, assign) BottomViewStyle mode;                 // (编辑模式下，两种类型，能否保存网络菜单)
@property (nonatomic, copy) void (^deleteBtnActionBlock)(void);

@end
