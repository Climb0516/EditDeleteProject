//
//  ViewController.m
//  EditDeleteProject
//
//  Created by 王攀登 on 2018/1/3.
//  Copyright © 2018年 王攀登. All rights reserved.
//

#import "ViewController.h"

#import <Masonry.h>

#import "MineVideoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *editButton = [UIButton new];
    [editButton setTitle:@"编辑删除" forState:UIControlStateNormal];
    [editButton setBackgroundColor:[UIColor redColor]];
    [editButton addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)editBtnClick {
    MineVideoViewController *videoVC = [MineVideoViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:videoVC];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
