//
//  MineVideoModel.m
//  RepublicShare
//
//  Created by 王攀登 on 2017/10/13.
//  Copyright © 2017年 王攀登. All rights reserved.
//

#import "MineVideoModel.h"

@implementation MineVideoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Description"   :@"description",
             @"videoID"       :@"id"
             };
}
@end
