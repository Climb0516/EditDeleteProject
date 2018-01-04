//
//  MineVideoModel.h
//  RepublicShare
//
//  Created by 王攀登 on 2017/10/13.
//  Copyright © 2017年 王攀登. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineVideoModel : NSObject

@property (nonatomic, copy) NSString *videoID;//视频id
@property (nonatomic, copy) NSString *uid;    //用户id
@property (nonatomic, copy) NSString *username;//用户姓名
@property (nonatomic, copy) NSString *thumb;  //用户头像URL
@property (nonatomic, copy) NSString *video_url; //视频URL
@property (nonatomic, copy) NSString *video_pic;//视频截图URL
@property (nonatomic, copy) NSString *title;  //视频标题
@property (nonatomic, assign) NSInteger video_width;  //视频宽
@property (nonatomic, assign) NSInteger video_height; //视频高
@property (nonatomic, copy) NSString *create_time; //视频发布时间
@property (nonatomic, copy) NSString *keywords;   //视频关键词
@property (nonatomic, copy) NSString *Description;//视频描述
@property (nonatomic, assign) NSInteger num_top;  //顶次数
@property (nonatomic, assign) NSInteger num_tread;//踩次数
@property (nonatomic, assign) NSInteger num_show; //播放次数

@property (nonatomic, assign) BOOL isSelected; // 编辑时用

@end
