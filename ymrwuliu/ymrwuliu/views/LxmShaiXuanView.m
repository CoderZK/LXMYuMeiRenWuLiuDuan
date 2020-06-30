
//
//  LxmShaiXuanView.m
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmShaiXuanView.h"
#import "LxmDataPickerView.h"

@interface LxmShaiXuanView ()<LxmDataPickerViewDelegate>

@property (nonatomic, strong) UIView *putinView;//

@property (nonatomic, strong) LxmShaiXuanItemView *orderNumView;//订单号

@property (nonatomic, strong) LxmShaiXuanItemView *timeView;//时间

@property (nonatomic, strong) LxmShaiXuanItemView *nameView;//收货人姓名

@property (nonatomic, strong) LxmShaiXuanItemView *addressView;//收货地址

@property (nonatomic, strong) UIButton *sureButton;//确定

@property (nonatomic, strong) LxmDataPickerView *startDataPicker;//开始时间

@property (nonatomic, strong) LxmDataPickerView *endDataPicker;//结束时间

@property (nonatomic, strong) NSDate *stratDate;

@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, strong) NSString *stratTime;

@property (nonatomic, strong) NSString *endTime;

@end

@implementation LxmShaiXuanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.putinView];
        [self initPutinView];
        [self setConstrains];
        [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/**
 添加视图
 */
- (void)initPutinView {
    [self.putinView addSubview:self.orderNumView];
    [self.putinView addSubview:self.timeView];
    [self.putinView addSubview:self.nameView];
    [self.putinView addSubview:self.addressView];
    [self.putinView addSubview:self.sureButton];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.orderNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.putinView);
        make.height.equalTo(@85);
    }];
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNumView.mas_bottom);
        make.leading.trailing.equalTo(self.putinView);
        make.height.equalTo(@85);
    }];
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeView.mas_bottom);
        make.leading.trailing.equalTo(self.putinView);
        make.height.equalTo(@85);
    }];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameView.mas_bottom);
        make.leading.trailing.equalTo(self.putinView);
        make.height.equalTo(@85);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressView.mas_bottom).offset(20);
        make.leading.equalTo(self.putinView).offset(15);
        make.trailing.equalTo(self.putinView).offset(-15);
        make.height.equalTo(@44);
    }];
}

- (LxmShaiXuanItemView *)orderNumView {
    if (!_orderNumView) {
        _orderNumView = [LxmShaiXuanItemView new];
        _orderNumView.titleLabel.text = @"订单号";
    }
    return _orderNumView;
}

- (LxmShaiXuanItemView *)timeView {
    if (!_timeView) {
        _timeView = [LxmShaiXuanItemView new];
        _timeView.titleLabel.text = @"时间";
        _timeView.textTF.placeholder = @"请选择";
        _timeView.textTF.userInteractionEnabled = NO;
        [_timeView addTarget:self action:@selector(timeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeView;
}

- (LxmShaiXuanItemView *)nameView {
    if (!_nameView) {
        _nameView = [LxmShaiXuanItemView new];
        _nameView.titleLabel.text = @"姓名";
    }
    return _nameView;
}

- (LxmShaiXuanItemView *)addressView {
    if (!_addressView) {
        _addressView = [LxmShaiXuanItemView new];
        _addressView.titleLabel.text = @"地址";
    }
    return _addressView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[UIImage imageNamed:@"deepPink"] forState:UIControlStateNormal];
        _sureButton.layer.cornerRadius = 22;
        _sureButton.layer.masksToBounds = YES;
        [_sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}


- (void)btnClick {
    [self dismiss];
}

- (UIView *)putinView {
    if (!_putinView) {
        _putinView = [UIView new];
        _putinView.backgroundColor = [UIColor whiteColor];
    }
    return _putinView;
}

- (void)showAtView:(UIView *)view {
    self.frame = view.bounds;
    self.backgroundColor = UIColor.clearColor;
    CGFloat height = 85*4 + 20 + 44 + 30;
    self.putinView.frame = CGRectMake(0, -height, self.frame.size.width, height);
    
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
        CGRect rect = self.putinView.frame;
        rect.origin.y = 0;
        self.putinView.frame =  rect;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = UIColor.clearColor;
        CGRect rect = self.putinView.frame;
        rect.origin.y = -rect.size.height;
        self.putinView.frame =  rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)timeClick {
    [self endEditing:YES];
    self.startDataPicker = [LxmDataPickerView pickerView];
    self.startDataPicker.titleLabel.text = @"服务开始时间";
    self.startDataPicker.delegate = self;
    [self.startDataPicker show];
}

-(void)LxmDataPickerView:(LxmDataPickerView *)view currentData:(NSDate *)date {
    if (view == self.startDataPicker) {
        self.stratDate = date;
        [view dismiss];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        self.stratTime = [dateFormatter stringFromDate:date];
        self.endDataPicker = [LxmDataPickerView pickerView];
        self.endDataPicker.titleLabel.text = @"服务结束时间";
        self.endDataPicker.delegate = self;
        [self.endDataPicker show];
    }
    if (view == self.endDataPicker) {
        self.endDate = date;
        int bijiao = [NSString compareOneDay:self.stratDate withAnotherDay:self.endDate];
        if (bijiao == 1) {
            [SVProgressHUD showErrorWithStatus:@"结束时间小于开始时间!"];
            return;
        } else {
            [view dismiss];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//设置输出的格式
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            
            self.endTime = [dateFormatter stringFromDate:date];
            self.timeView.textTF.text = [NSString stringWithFormat:@"%@~%@",self.stratTime,self.endTime];
        }
    }
}

/**
 确定
 */
- (void)sureButtonClick {
    NSString *orderCode = self.orderNumView.textTF.text;
    NSString *name = self.nameView.textTF.text;
    NSString *address = self.addressView.textTF.text;
    NSInteger stratInterval = [[NSNumber numberWithDouble:[self.stratDate timeIntervalSince1970]] integerValue];
    NSInteger endInterval = [[NSNumber numberWithDouble:[self.endDate timeIntervalSince1970]] integerValue];
    
    if (!orderCode.isValid && !self.stratTime.isValid && !name.isValid && !address.isValid) {
        [SVProgressHUD showErrorWithStatus:@"请填写至少一个筛选项!"];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (orderCode.isValid) {
        dict[@"orderCode"] = orderCode;
    }
    if (self.stratTime.isValid) {
        dict[@"startTime"] = @(stratInterval*1000);
        dict[@"endTime"] = @(endInterval*1000);
    }
    if (name.isValid) {
        dict[@"username"] = name;
    }
    if (address.isValid) {
       dict[@"address"] = address;
    }
    if (self.sureBlock) {
        self.sureBlock(dict);
    }
}

@end

/**
 各个筛选item
 */
@interface LxmShaiXuanItemView ()

@end
@implementation LxmShaiXuanItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        [self setConstrains];
    }
    return self;
}

/**
 添加视图
 */
- (void)initSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.textTF];
}

/**
 设置约束
 */
- (void)setConstrains {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.leading.equalTo(self).offset(15);
        make.height.equalTo(@20);
    }];
    [self.textTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.height.equalTo(@35);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textColor = UIColor.blackColor;
    }
    return _titleLabel;
}

- (UITextField *)textTF {
    if (!_textTF) {
        _textTF = [[UITextField alloc] init];
        _textTF.layer.borderWidth = 0.5;
        _textTF.layer.borderColor = LineColor.CGColor;
        _textTF.layer.cornerRadius = 3;
        _textTF.layer.masksToBounds = YES;
        _textTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 15, 15)];
        _textTF.leftViewMode = UITextFieldViewModeAlways;
        _textTF.placeholder = @"请输入";
        _textTF.backgroundColor = BGGrayColor;
        _textTF.font = [UIFont systemFontOfSize:13];
    }
    return _textTF;
}

@end
