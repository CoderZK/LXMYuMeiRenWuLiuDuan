//
//  LxmLoginVC.m
//  yumeirenwuliu
//
//  Created by 李晓满 on 2019/8/6.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmLoginVC.h"
#import "LxmLoginView.h"
#import "LxmJieDanPlatVC.h"

@interface LxmLoginVC ()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) LxmTextAndPutinTFView *phoneView;//手机号

@property (nonatomic, strong) LxmTextAndPutinTFView *passwordView;//密码

@property (nonatomic, strong) UIButton *loginButton;//登录按钮

@end

@implementation LxmLoginVC

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.view.bounds.size.height - 1)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (LxmTextAndPutinTFView *)phoneView {
    if (!_phoneView) {
        _phoneView = [[LxmTextAndPutinTFView alloc] init];
        _phoneView.leftLabel.text = @"手机号码";
        _phoneView.rightTF.placeholder = @"请输入手机号";
    }
    return _phoneView;
}

- (LxmTextAndPutinTFView *)passwordView {
    if (!_passwordView) {
        _passwordView = [[LxmTextAndPutinTFView alloc] init];
        _passwordView.leftLabel.text = @"密码";
        _passwordView.rightTF.placeholder = @"请输入密码";
        _passwordView.rightTF.secureTextEntry = YES;
    }
    return _passwordView;
}


- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"deepPink"] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 25;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(1);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [self initHeaderView];
    [self setConstrains];
}


/**
 添加子视图
 */
- (void)initHeaderView {
    [self.headerView addSubview:self.phoneView];
    [self.headerView addSubview:self.passwordView];
    [self.headerView addSubview:self.loginButton];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.headerView);
        make.height.equalTo(@60);
    }];
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom);
        make.leading.trailing.equalTo(self.headerView);
        make.height.equalTo(@60);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordView.mas_bottom).offset(30);
        make.leading.equalTo(self.headerView).offset(20);
        make.trailing.equalTo(self.headerView).offset(-20);
        make.height.equalTo(@50);
    }];
}

/**
 登录
 */
- (void)loginButtonClick {
    [self.headerView endEditing:YES];
    NSString *phone = self.phoneView.rightTF.text;
    NSString *password = self.passwordView.rightTF.text;
    if (![phone isValid]) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空!"];
        return;
    }
    if ([phone isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能输入带有空格的手机号!"];
        return;
    }
//    if (phone.length != 11) {
//        [SVProgressHUD showErrorWithStatus:@"请输入11位的手机号!"];
//        return;
//    }
    if (![password isValid]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码!"];
        return;
    }
    if ([password isContrainsKong]) {
        [SVProgressHUD showErrorWithStatus:@"不能输入带有空格的密码!"];
        return;
    }
    NSDictionary *dict = @{
                           @"username" : phone,
                           @"password" : password,
                           };
    [SVProgressHUD show];
    [LxmNetworking networkingPOST:pc_login parameters:dict returnClass:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] integerValue] == 1000) {
            [LxmTool ShareTool].isLogin = YES;
            [LxmTool ShareTool].session_token = responseObject[@"result"][@"map"][@"token"];
            UIApplication.sharedApplication.delegate.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:[[LxmJieDanPlatVC alloc] init]];
        } else {
            [UIAlertController showAlertWithKey:responseObject[@"key"] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}

@end
