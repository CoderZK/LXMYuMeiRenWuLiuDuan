//
//  LxmJieDanPlatVC.m
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmJieDanPlatVC.h"
#import "LxmJieDanPlatSubListVC.h"
#import <TYPagerController.h>
#import <TYTabPagerBar.h>
#import "LxmShaiXuanView.h"
#import "LxmLoginVC.h"

@interface LxmJieDanPlatVC ()<TYTabPagerBarDelegate,TYTabPagerBarDataSource,TYPagerControllerDataSource,TYPagerControllerDelegate>
@property (nonatomic, strong) UIButton *leftButton;//导航栏左侧按钮
@property (nonatomic, strong) UIButton *rightButton;//导航栏右侧按钮

@property (nonatomic, strong) TYTabPagerBar *tabBar;
@property (nonatomic, strong) TYPagerController *pagerController;
@property (nonatomic, strong) NSArray *titleArray;//顶部标题数组

@property (nonatomic, strong) LxmShaiXuanView *selectedView;

@property (nonatomic, strong) UILabel *redLabel1;

@property (nonatomic, strong) UILabel *redLabel2;

@end

@implementation LxmJieDanPlatVC

- (LxmShaiXuanView *)selectedView {
    if (!_selectedView) {
        _selectedView = [LxmShaiXuanView new];
        WeakObj(self);
        _selectedView.sureBlock = ^(NSDictionary *dict) {
            [selfWeak shaixuan:dict];
        };
    }
    return _selectedView;
}

- (UILabel *)redLabel1 {
    if (!_redLabel1) {
        _redLabel1 = [UILabel new];
        _redLabel1.tag = 111;
        _redLabel1.backgroundColor = MainColor;
        _redLabel1.font = [UIFont systemFontOfSize:10];
        _redLabel1.textColor = UIColor.whiteColor;
        _redLabel1.layer.cornerRadius = 8;
        _redLabel1.layer.masksToBounds = YES;
        _redLabel1.textAlignment = NSTextAlignmentCenter;
        _redLabel1.text = @"10";
    }
    return _redLabel1;
}

- (UILabel *)redLabel2 {
    if (!_redLabel2) {
        _redLabel2 = [UILabel new];
        _redLabel2.tag = 222;
        _redLabel2.backgroundColor = MainColor;
        _redLabel2.font = [UIFont systemFontOfSize:10];
        _redLabel2.textColor = UIColor.whiteColor;
        _redLabel2.layer.cornerRadius = 8;
        _redLabel2.layer.masksToBounds = YES;
        _redLabel2.textAlignment = NSTextAlignmentCenter;
        _redLabel2.text = @"12";
    }
    return _redLabel2;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_leftButton addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setImage:[UIImage imageNamed:@"wode"] forState:UIControlStateNormal];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightButton addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setTitle:@"筛选" forState:UIControlStateNormal];
        [_rightButton setTitleColor:CharacterDarkColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _rightButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"接单平台";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];

    
    self.titleArray = @[@"待发货",@"待自提", @"已发货",@"已自提"];
    [self.view addSubview:self.tabBar];
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self.view addSubview:self.pagerController.view];
    [self addChildViewController:self.pagerController];
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(0.5);
        make.height.equalTo(@50);
    }];
    [self.pagerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.view);
        make.top.equalTo(self.tabBar.mas_bottom);
    }];
    [self.tabBar reloadData];
    
    [LxmEventBus registerEvent:@"redNum" block:^(id data) {
        NSNumber *status = data[@"status"];
        if (status.intValue == 2) {
            self.redLabel1.text = [NSString stringWithFormat:@"%@",data[@"count"]];
        } else {
            self.redLabel2.text = [NSString stringWithFormat:@"%@",data[@"count"]];
        }
        [self.tabBar reloadData];
    }];
    
}

- (TYTabPagerBar *)tabBar {
    if (!_tabBar) {
        _tabBar = [[TYTabPagerBar alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        TYTabPagerBarLayout *layout = [[TYTabPagerBarLayout alloc] initWithPagerTabBar:_tabBar];
        layout.normalTextFont = [UIFont systemFontOfSize:17];
        layout.adjustContentCellsCenter = YES; // 居中
        layout.normalTextColor = CharacterDarkColor;
        layout.selectedTextColor = UIColor.blackColor;
        layout.progressHeight = 2;
        layout.progressRadius = 1;
        layout.progressWidth = 40;
        layout.progressColor = MainColor;
        layout.cellEdging = 0;
        layout.cellSpacing = 0;
        layout.cellWidth = floor(ScreenW/4.0);
        layout.barStyle = TYPagerBarStyleProgressElasticView;
        layout.animateDuration = 0.25;
        layout.progressVerEdging = 8;
        _tabBar.backgroundColor = [UIColor whiteColor];
        _tabBar.layout = layout;
        _tabBar.delegate = self;
        _tabBar.dataSource = self;
        [_tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    }
    return _tabBar;
}

- (TYPagerController *)pagerController {
    if (!_pagerController) {
        TYPagerController *pagerController = [[TYPagerController alloc]init];
        pagerController.layout.prefetchItemCount = 1;
        //pagerController.layout.autoMemoryCache = NO;
        // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能
        pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
        pagerController.dataSource = self;
        pagerController.delegate = self;
        _pagerController = pagerController;
    }
    return _pagerController;
}

- (NSInteger)numberOfItemsInPagerTabBar {
    return self.titleArray.count;
}

- (NSInteger)numberOfControllersInPagerController {
    return self.titleArray.count;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    LxmJieDanPlatSubListVC *vc = [[LxmJieDanPlatSubListVC alloc]init];
    //2：待发货，3：已发货，7：待自提
    if (index == 0) {
        vc.status = @2;
    } else if (index == 1) {
        vc.status = @7;
    } else if (index == 2) {
        vc.status = @3;
    } else {
        vc.status = @8;
    }
    return vc;
}

#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    return 100;
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
    LxmJieDanPlatSubListVC *vc = (LxmJieDanPlatSubListVC *)[self.pagerController controllerForIndex:self.pagerController.curIndex];;
    vc.page = 1;
    vc.allPageNum = 1;
    vc.dict = nil;
    [vc loadData];
}


#pragma mark - TYPagerControllerDelegate

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    if (index == 0) {
        UILabel *label = (UILabel *)[cell viewWithTag:111];
        if (label) {
            [label removeFromSuperview];
        }
        [cell addSubview:self.redLabel1];
        self.redLabel1.hidden = self.redLabel1.text.intValue == 0;
        CGFloat w = [self.redLabel1.text getSizeWithMaxSize:CGSizeMake(200, 15) withFontSize:10].width;
        w = w > 16 ? (w + 10) : 16;
        [self.redLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).offset(10);
            make.leading.equalTo(cell.mas_centerX).offset(23);
            make.width.equalTo(@(w));
            make.height.equalTo(@16);
        }];
    } else if (index == 1){
        UILabel *label = (UILabel *)[cell viewWithTag:222];
        if (label) {
            [label removeFromSuperview];
        }
        [cell addSubview:self.redLabel2];
        self.redLabel2.hidden = self.redLabel2.text.intValue == 0;
        CGFloat w = [self.redLabel2.text getSizeWithMaxSize:CGSizeMake(200, 15) withFontSize:10].width;
        w = w > 16 ? (w + 10) : 16;
        [self.redLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).offset(8);
            make.leading.equalTo(cell.mas_centerX).offset(23);
            make.width.equalTo(@(w));
            make.height.equalTo(@16);
        }];
    }
    cell.titleLabel.text = self.titleArray[index];
    return cell;
}

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
    LxmJieDanPlatSubListVC *vc = (LxmJieDanPlatSubListVC *)[self.pagerController controllerForIndex:self.pagerController.curIndex];;
    vc.page = 1;
    vc.allPageNum = 1;
    vc.dict = nil;
    [vc loadData];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)navButtonClick:(UIButton *)btn {
    if (btn == _leftButton) {//退出登录
        WeakObj(self);
        UIAlertController * alertView = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [selfWeak loginOut];
        }]];
        [self presentViewController:alertView animated:YES completion:nil];
    } else {//查询订单
        [self.selectedView showAtView:self.view];
    }
}

/**
 筛选
 */
- (void)shaixuan:(NSDictionary *)dict {
    [self.selectedView dismiss];
    LxmJieDanPlatSubListVC *vc = (LxmJieDanPlatSubListVC *)[self.pagerController controllerForIndex:self.pagerController.curIndex];;
    vc.page = 1;
    vc.allPageNum = 1;
    vc.dict = dict;
    [vc loadData];
}

- (void)loginOut {
    [SVProgressHUD show];
    [LxmNetworking networkingPOST:logout parameters:@{@"token":SESSION_TOKEN} returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.integerValue == 1000) {
            [SVProgressHUD showSuccessWithStatus:@"已退出登录"];
            [LxmTool ShareTool].isLogin = NO;
            [LxmTool ShareTool].session_token = nil;
        UIApplication.sharedApplication.delegate.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:[[LxmLoginVC alloc] init]];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
