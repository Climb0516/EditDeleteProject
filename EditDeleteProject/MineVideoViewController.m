//
//  MineVideoViewController.m
//  RepublicShare
//
//  Created by 王攀登 on 2017/10/13.
//  Copyright © 2017年 王攀登. All rights reserved.
//

#import "MineVideoViewController.h"

#import <SVProgressHUD.h>

#import "MineVideoCell.h"
#import "MineVideoModel.h"
#import "MineVideoDeleteBottomView.h"

#define kScreenWidth     ([UIScreen mainScreen].bounds.size.width)//屏幕宽
#define kScreenHeight    ([UIScreen mainScreen].bounds.size.height)//屏幕高
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kNavBarHeight (kStatusBarHeight + 44) //导航栏高
#define kTabBarHeight (kStatusBarHeight > 20 ? 83 : 49) //Tabbar高
#define kIphoneXBottomSpace (kStatusBarHeight > 20 ? 35 : 0) //没有tabbar时 底部不显示内容高度
#define kRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define kHeightRate (kScreenHeight / 667.0f)
@interface MineVideoViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *dataArray;
@property (nonatomic, strong) MineVideoDeleteBottomView *deleteBtmView;
@property (nonatomic, strong) UIButton *editButton;//编辑按钮
@property (nonatomic, assign) BOOL isEditingMode; // 是否处于编辑模式

@end

@implementation MineVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isEditingMode = NO;
    self.dataArray = [NSMutableArray new];
    [self setNav];
    [self setContentVC];
    [self setDeleteBottomView]; // 编辑删除view
    [self requestData];

}

- (void)setNav {
    self.title = @"我的视频";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.frame = CGRectMake(0, 10, 30, 30);
    [self.editButton setTitleColor:kRGB16(0x333333) forState:UIControlStateNormal];
    [self.editButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.editButton setTitle:@"取消" forState:UIControlStateSelected];
    self.editButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.editButton addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setContentVC {
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight) collectionViewLayout:flowlayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[MineVideoCell class] forCellWithReuseIdentifier:[MineVideoCell reuseIdentifier]];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
}

- (void)setDeleteBottomView {
    self.deleteBtmView = [[MineVideoDeleteBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kTabBarHeight)];
    WEAKSELF
    self.deleteBtmView.deleteBtnActionBlock = ^{
        [weakSelf deleteAction];
    };
    [self.view addSubview:self.deleteBtmView];
}

#pragma  mark - rewrite method

- (void)requestData {
    for (NSInteger i=0; i<10; i++) {
        MineVideoModel *model = [MineVideoModel new];
        model.isSelected = NO;
        [self.dataArray addObject:model];
    }
}

#pragma mark ============= Action ==============

- (void)editBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isEditingMode = sender.selected;
    [self.collectionView reloadData];
    WEAKSELF
    if (_isEditingMode) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = weakSelf.deleteBtmView.frame;
            frame.origin.y = kScreenHeight - kTabBarHeight;
            weakSelf.deleteBtmView.frame = frame;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = weakSelf.deleteBtmView.frame;
            frame.origin.y = kScreenHeight;
            weakSelf.deleteBtmView.frame = frame;
        }];
    }
}



- (void)deleteAction {
    NSInteger i = 0;
    for (MineVideoModel *model in self.dataArray) {
        if (model.isSelected) {
            i++;
        }
    }
    if (i == 0) {
        [SVProgressHUD showErrorWithStatus:@"还没选择内容!"];
    }else {
//        WEAKSELF
//        [AlertViewUntils showWithTitle:@"提示" detail:@"确认删除选中项么？" itemHandler:^(NSInteger index) {
//            if (index == 1) {
                [self deleteVideoClickAction];
//            }
//        }];
    }
}


#pragma mark UICollectionViewDelegate UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-30)/2, 115*kHeightRate);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineVideoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MineVideoCell reuseIdentifier] forIndexPath:indexPath];
    [cell sizeToFit];
    MineVideoModel *model = self.dataArray[indexPath.row];
    [cell cellVideoInfoWithDictionary:model editingMode:self.isEditingMode];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEditingMode) { //可编辑模式下
        [self clickCollectionCell:indexPath];
    }else { //正常情况下
        MineVideoModel *model = self.dataArray[indexPath.row];
        CGFloat playControlHeight = model.video_height*kScreenWidth/model.video_width;
//        if (playControlHeight == 0) {
//            playControlHeight = kPlayPlayControlHeight;
//        }
//        PlayerViewController *playVC = [[PlayerViewController alloc] initWithVideoId:model.videoID videoTitle:model.title videoUrl:model.video_url playViewHeight:playControlHeight sourceType:SourceTypeUser];
//        [self.navigationController pushViewController:playVC animated:YES];
    }
}

- (void)clickCollectionCell:(NSIndexPath *)indexPath {
    MineVideoModel *model = self.dataArray[indexPath.row];
    model.isSelected      = !model.isSelected;
    [self.collectionView reloadData];
}

#pragma mark - UIAlertViewDelegate

- (void)backBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)deleteVideoClickAction {
    NSMutableArray *deleteData = [NSMutableArray array];
    NSString *deleteVid;
    for (MineVideoModel *model in self.dataArray) {
        if (model.isSelected) {
            [deleteData addObject:model];
//            if ([NSString isBlankString:deleteVid]) {
//                deleteVid = [NSString stringWithFormat:@"%@",model.videoID];
//            }else {
//                deleteVid = [NSString stringWithFormat:@"%@,%@",deleteVid,model.videoID];
//            }
        }
    }
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSDictionary *urlParam = [UrlParamManager deleteMyVideoWithVideoString:deleteVid];
//    [NetManager postSignRequestWithUrlParam:urlParam finished:^(id responseObj) {
//        if ([responseObj[@"err_no"] integerValue] == kResOK) {
            // 执行删除操作
            [self.dataArray removeObjectsInArray:deleteData];
            [self.collectionView reloadData];
            [self editBtnClick:self.editButton];
//            MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
//            hud.label.text = @"删除成功！";
//            [hud hideAnimated:YES afterDelay:1.5f];
            [SVProgressHUD showSuccessWithStatus:@"删除成功！"];
//        }else {
//            MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
//            hud.label.text = responseObj[@"err_msg"];
//            [hud hideAnimated:YES afterDelay:1.5f];
//        }
//    } failed:^(NSString *errorMsg) {
//        RSLog(@"error:%@",errorMsg);
//        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
//        hud.label.text = errorMsg;
//        [hud hideAnimated:YES afterDelay:1.5f];
//    }];
}

@end
