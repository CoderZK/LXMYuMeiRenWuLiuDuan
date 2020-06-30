//
//  LxmTianXieDanHaoVC.m
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmTianXieDanHaoVC.h"
#import "LxmLoginView.h"
#import "SNYQRCodeVC.h"

@interface LxmTianXieDanHaoVC ()<SNYQRCodeVCDelegate>

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) LxmTextAndPutinTFView *danhaoView;//物流单号

@property (nonatomic, strong) UIButton *submitButton;//确认提交按钮

@property (nonatomic, assign) LxmTianXieDanHaoVC_type type;

@property (nonatomic, strong) UIButton *saomianButton;//扫描物流单号

@property (nonatomic, strong) UIView *lineView;//线

@end

@implementation LxmTianXieDanHaoVC

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style type:(LxmTianXieDanHaoVC_type)type {
    self = [super initWithTableViewStyle:style];
    if (self) {
        self.type = type;
    }
    return self;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (UIButton *)saomianButton {
    if (!_saomianButton) {
        _saomianButton = [UIButton new];
        [_saomianButton setImage:[UIImage imageNamed:@"saomiao"] forState:UIControlStateNormal];
        [_saomianButton addTarget:self action:@selector(saomianClick) forControlEvents:UIControlEventTouchUpInside];
        [_saomianButton setImageEdgeInsets:UIEdgeInsetsMake(20, 35, 20, 15)];
    }
    return _saomianButton;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.view.bounds.size.height - 1)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (LxmTextAndPutinTFView *)danhaoView {
    if (!_danhaoView) {
        _danhaoView = [[LxmTextAndPutinTFView alloc] init];
        _danhaoView.leftLabel.text = @"物流单号";
        _danhaoView.rightTF.textAlignment = NSTextAlignmentRight;
        _danhaoView.rightTF.placeholder = @"输入或扫描输入";
        _danhaoView.lineView.hidden = YES;
    }
    return _danhaoView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] init];
        [_submitButton setTitle:@"确认提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_submitButton setBackgroundImage:[UIImage imageNamed:@"deepPink"] forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 5;
        _submitButton.layer.masksToBounds = YES;
        [_submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.type == LxmTianXieDanHaoVC_type_tianjia ? @"填写单号" : @"修改单号";
    
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(1);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [self initHeaderView];
    [self setConstrains];
    if (self.type == LxmTianXieDanHaoVC_type_xiugai) {
        _danhaoView.rightTF.text = self.code;
    }
}

/**
 添加子视图
 */
- (void)initHeaderView {
    [self.headerView addSubview:self.danhaoView];
    [self.headerView addSubview:self.submitButton];
    [self.headerView addSubview:self.saomianButton];
    [self.headerView addSubview:self.lineView];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.danhaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.headerView);
        make.height.equalTo(@60);
        make.trailing.equalTo(self.headerView).offset(-70);
    }];
    [self.saomianButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.equalTo(self.headerView);
        make.height.equalTo(@60);
        make.width.equalTo(@70);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.danhaoView.mas_bottom).offset(30);
        make.leading.equalTo(self.headerView).offset(20);
        make.trailing.equalTo(self.headerView).offset(-20);
        make.height.equalTo(@44);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.headerView);
        make.bottom.equalTo(self.danhaoView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
}

- (void)submitButtonClick {
    if (!self.danhaoView.rightTF.text.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请输入或扫描输入物流单号!"];
        return;
    }
    if (self.tianxieBlock) {
        self.tianxieBlock(self.danhaoView.rightTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 扫描物流单号
 */
- (void)saomianClick {
    SNYQRCodeVC * vc = [[SNYQRCodeVC alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SNYQRCodeVCDelegate

- (void)SNYQRCodeVC:(SNYQRCodeVC *)vc scanResult:(NSString *)str {
    [vc.navigationController popViewControllerAnimated:YES];
    WeakObj(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        selfWeak.danhaoView.rightTF.text = str;
    });
}


@end
