//
//  LxmMyOrderDetailVC.m
//  yumeiren
//
//  Created by 李晓满 on 2019/7/26.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmMyOrderDetailVC.h"
#import "LxmJieDanPlatSubListVC.h"
#import "LxmWuLiuInfoVC.h"

@interface LxmMyOrderDetailWuLiuCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImgView;//图标

@property (nonatomic, strong) UILabel *stateLabel;//待发货 已发货 已完成

@property (nonatomic, strong) UILabel *detailLabel;//物流信息

@property (nonatomic, strong) UILabel *timeLabel;//时间

@property (nonatomic, strong) UIImageView *accImgView;//箭头

@property (nonatomic, strong) LxmWuLiuInfoStateModel *model;

@end
@implementation LxmMyOrderDetailWuLiuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:182/255.0 blue:191/255.0 alpha:1];
        [self initSubViews];
        [self setConstrains];
    }
    return self;
}

/**
 添加视图
 */
- (void)initSubViews {
    [self addSubview:self.iconImgView];
    [self addSubview:self.stateLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.accImgView];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self).offset(15);
        make.width.height.equalTo(@20);
    }];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
        make.centerY.equalTo(self.iconImgView);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stateLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.stateLabel);
        make.trailing.lessThanOrEqualTo(self.accImgView.mas_leading);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.stateLabel);
    }];
    [self.accImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@15);
    }];
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
    }
    return _iconImgView;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.font = [UIFont systemFontOfSize:13];
        _stateLabel.textColor = CharacterDarkColor;
    }
    return _stateLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = CharacterDarkColor;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = CharacterDarkColor;
        _timeLabel.hidden = YES;
    }
    return _timeLabel;
}

- (UIImageView *)accImgView {
    if (!_accImgView) {
        _accImgView = [UIImageView new];
    }
    return _accImgView;
}

- (void)setModel:(LxmWuLiuInfoStateModel *)model {
    _model = model;
    self.stateLabel.text = _model.title;
    
    NSString *detail = _model.list.firstObject.context;
    if (detail.isValid) {
        self.detailLabel.text = _model.list.firstObject.context;
    } else {
        self.detailLabel.text = @"物流信息:暂无物流信息";
    }
    
    if ([_model.title isEqualToString:@"已签收"]) {
        _iconImgView.image = [UIImage imageNamed:@"ico_yishouhuo"];
    } else {
        _iconImgView.image = [UIImage imageNamed:@"fahuocar"];
    }
}

@end


#import "LxmTianXieDanHaoVC.h"
@interface LxmMyOrderDetailVC ()

@property (nonatomic, strong) LxmOrderDetailBottomView *bottomView;//底部操作按钮

@property (nonatomic, strong) LxmShopCenterOrderDetailModel *detailModel;

@property (nonatomic, assign) CGFloat lingshiTotalPrice;/* 商品零售总价 */

@property (nonatomic, assign) CGFloat shangpinTotalPrice;/* 商品总价 */

@property (nonatomic, assign) NSInteger count;//商品件数

@property (nonatomic, strong) LxmWuLiuInfoRootModel *rootModel;/* 快递信息什么的 */

@property (nonatomic, strong) NSArray <LxmWuLiuInfoStateModel *>*dataArr;

@end

@implementation LxmMyOrderDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:241/255.0 green:182/255.0 blue:191/255.0 alpha:1]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:UIColor.whiteColor];
}

- (LxmOrderDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[LxmOrderDetailBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        WeakObj(self);
        _bottomView.gotobuhuoBlock = ^{
            [selfWeak bottomButtonAction];
        };
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initSubviews];
    [self loadDetailData];
    if (self.postage_code.isValid) {
        [self loadWuLiuInfo];
    }
}

/**
 初始化子视图
 */
- (void)initSubviews {
    [self.view addSubview:self.bottomView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.view);
        make.height.equalTo(@(TableViewBottomSpace + 60));
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return self.detailModel.map.sub.count + self.detailModel.map.sends.count;
    }else if (section == 2) {
        return 6;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LxmMyOrderDetailWuLiuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmMyOrderDetailWuLiuCell"];
            if (!cell) {
                cell = [[LxmMyOrderDetailWuLiuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmMyOrderDetailWuLiuCell"];
            }
            if (self.dataArr.count >= 1) {
               cell.model = self.dataArr.firstObject;
            }
            return cell;
        } else {
            LxmShopCenterOrderModel *model = self.detailModel.map;
            if (model.status.intValue == 7 || model.status.intValue == 8) {
                LxmSubOrderChaXunAddressCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSubOrderChaXunAddressCell1"];
                if (!cell) {
                    cell = [[LxmSubOrderChaXunAddressCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSubOrderChaXunAddressCell1"];
                }
                cell.orderModel1 = self.detailModel.map;
                return cell;
            }
            LxmSubOrderChaXunAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSubOrderChaXunAddressCell"];
            if (!cell) {
                cell = [[LxmSubOrderChaXunAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSubOrderChaXunAddressCell"];
            }
            cell.orderModel = self.detailModel.map;
            return cell;
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row >= self.detailModel.map.sub.count) {
            LxmAcGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmAcGoodsCell"];
            if (!cell) {
                cell = [[LxmAcGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmAcGoodsCell"];
            }
            cell.status = self.detailModel.map.status;
            cell.detailGoodsModel = self.detailModel.map.sends[indexPath.row - self.detailModel.map.sub.count];
            return cell;
        } else {
        LxmJieSuanPeiSongGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmJieSuanPeiSongGoodsCell"];
        if (!cell) {
            cell = [[LxmJieSuanPeiSongGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmJieSuanPeiSongGoodsCell"];
        }
        cell.status = self.detailModel.map.status;
        cell.orderDetailGoodsModel = self.detailModel.map.sub[indexPath.row];
        return cell;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            LxmNoteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmNoteCell"];
            if (!cell) {
                cell = [[LxmNoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmNoteCell"];
            }
            cell.titleLabel.text = @"备注";
            cell.detailLabel.text = self.detailModel.map.order_info;
            return cell;
        } else if (indexPath.row == 5) {
            LxmSubBuHuoOrderPriceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSubBuHuoOrderPriceCell"];
            if (!cell) {
                cell = [[LxmSubBuHuoOrderPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSubBuHuoOrderPriceCell"];
            }
            cell.shifujineMoney = [NSString stringWithFormat:@"%lf",self.shangpinTotalPrice];
            return cell;
        }
        LxmJieSuanPeiSongInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmJieSuanPeiSongInfoCell"];
        if (!cell) {
            cell = [[LxmJieSuanPeiSongInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmJieSuanPeiSongInfoCell"];
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"商品件数";
            cell.detailLabel.textColor = CharacterDarkColor;
            cell.detailLabel.text = [NSString stringWithFormat:@"%ld件",self.count];
        } else if (indexPath.row == 2){
            cell.titleLabel.text = @"商品零售价";
            cell.detailLabel.textColor = CharacterDarkColor;
            CGFloat f = self.lingshiTotalPrice;
            NSInteger d = self.lingshiTotalPrice;
            cell.detailLabel.text = f == d ? [NSString stringWithFormat:@"¥%ld",d] : [NSString stringWithFormat:@"¥%.2f",f];
        } else if (indexPath.row == 3){
            cell.titleLabel.text = @"商品总额";
            cell.detailLabel.textColor = MainColor;
            CGFloat f = self.shangpinTotalPrice;
            NSInteger d = self.shangpinTotalPrice;
            cell.detailLabel.text = f == d ? [NSString stringWithFormat:@"¥%ld",d] : [NSString stringWithFormat:@"¥%.2f",f];
        } else if (indexPath.row == 4){
            cell.titleLabel.text = @"运费";
            cell.detailLabel.textColor = MainColor;
            cell.detailLabel.text = @"货到付款";
        }
        return cell;
    } else {
        LxmJieSuanPeiSongInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmJieSuanPeiSongInfoCell"];
        if (!cell) {
            cell = [[LxmJieSuanPeiSongInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmJieSuanPeiSongInfoCell"];
        }
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"订单编号";
            cell.detailLabel.text = self.detailModel.map.order_code;
        } else {
            cell.titleLabel.text = @"下单时间";
            if (self.detailModel.map.create_time.length > 10) {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",[[self.detailModel.map.create_time substringToIndex:10] getIntervalToZHXLongTime]];
            } else {
                cell.detailLabel.text = [NSString stringWithFormat:@"%@",[self.detailModel.map.create_time getIntervalToZHXLongTime]];
            }
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (!self.postage_code.isValid) {
                return 0.01;
            }
            if (self.dataArr.count >= 1) {
                return 80;
            }
            return 0.01;
        } else {
            if (self.detailModel.map.postage_type.intValue == 1) {
                       if (self.detailModel.map.status.intValue == 7 || self.detailModel.map.status.intValue == 8) {
                           return 60;
                       }
                       return 0.001;
                   }
                   return 80;
        }
       
    } else if (indexPath.section == 1) {
        return 120;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        if (self.detailModel.map.order_info.isValid) {
            return self.detailModel.map.orderHeight > 50 ? self.detailModel.map.orderHeight : 50;
        }
        return 0.01;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0.01;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//物流详情
            LxmWuLiuInfoVC *vc = [[LxmWuLiuInfoVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            vc.rootModel = self.rootModel;
            vc.dataArr = self.dataArr;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row >= self.detailModel.map.sub.count) {
            LxmShopCenterAcGoodsModel *orderDetailGoodsModel = self.detailModel.map.sends[indexPath.row - self.detailModel.map.sub.count];
            orderDetailGoodsModel.isSelected = !orderDetailGoodsModel.isSelected;
            LxmAcGoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.backgroundColor = orderDetailGoodsModel.isSelected ? BGGrayColor : UIColor.whiteColor;
            [self.tableView reloadData];
        } else {
            if (self.detailModel.map.status.intValue == 2) {
                LxmShopCenterOrderGoodsModel *orderDetailGoodsModel = self.detailModel.map.sub[indexPath.row];
                orderDetailGoodsModel.isSelected = !orderDetailGoodsModel.isSelected;
                LxmJieSuanPeiSongGoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.backgroundColor = orderDetailGoodsModel.isSelected ? BGGrayColor : UIColor.whiteColor;
                [self.tableView reloadData];
            }
        }
    }
}

/**
 底部操作按钮
 */
- (void)bottomButtonAction {
    NSInteger status = self.detailModel.map.status.intValue;
    if (status == 2) {//确认发货
        NSInteger count = 0;
        for (LxmShopCenterOrderGoodsModel *m in self.detailModel.map.sub) {
            if (m.isSelected) {
                count++;
            }
        }
        if (count == self.detailModel.map.sub.count) {
            LxmTianXieDanHaoVC *vc = [[LxmTianXieDanHaoVC alloc] initWithTableViewStyle:UITableViewStyleGrouped type:LxmTianXieDanHaoVC_type_tianjia];
            vc.tianxieBlock = ^(NSString *code) {
                [self sureClick:@1 code:code];
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"还有未选择的商品,请全部点选后发货!"];
            return;
        }
        
    } else if (status == 3) {//填写物流单号
        LxmTianXieDanHaoVC *vc = [[LxmTianXieDanHaoVC alloc] initWithTableViewStyle:UITableViewStyleGrouped type:LxmTianXieDanHaoVC_type_xiugai];
        vc.code = self.detailModel.map.postage_code;
        vc.tianxieBlock = ^(NSString *code) {
            [self sureClick:@2 code:code];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if (status == 7) {//确认自提
         [self sureClick:@3 code:nil];
    }
}


/**
 订单详情
 */
- (void)loadDetailData {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:good_order_detail parameters:@{@"token":SESSION_TOKEN,@"id":self.orderID} returnClass:LxmShopCenterOrderDetailRootModel.class success:^(NSURLSessionDataTask *task, LxmShopCenterOrderDetailRootModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.integerValue == 1000) {
            selfWeak.detailModel = responseObject.result;
            selfWeak.lingshiTotalPrice = 0;
            selfWeak.shangpinTotalPrice = 0;
            for (LxmShopCenterOrderGoodsModel *goods in selfWeak.detailModel.map.sub) {
                selfWeak.count += goods.num.intValue;
                selfWeak.lingshiTotalPrice += goods.good_price.floatValue * goods.num.intValue;
                selfWeak.shangpinTotalPrice += goods.proxy_price.floatValue * goods.num.intValue;
            }
            selfWeak.bottomView.model = selfWeak.detailModel.map;
            NSInteger status = selfWeak.detailModel.map.status.intValue;
            if (status == 2 || status == 3 || status == 7 || status == 8) {
                [selfWeak.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(TableViewBottomSpace + 60));
                }];
            } else {
                [selfWeak.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@0);
                }];
            }
            [selfWeak.view layoutIfNeeded];
            [selfWeak.tableView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

/**
 1 确认收货 2 修改物流单号 3 确认自提
 */
- (void)sureClick:(NSNumber *)num code:(NSString *)code {
    [SVProgressHUD show];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = SESSION_TOKEN;
    dict[@"id"] = self.detailModel.map.id;
    if (num.intValue == 1) {
        dict[@"type"] = @1;
        dict[@"postageCode"] = code;
    } else if (num.intValue == 2) {
        dict[@"type"] = @2;
        dict[@"postageCode"] = code;
    } else {
        dict[@"type"] = @1;
    }
    WeakObj(self);
    [LxmNetworking networkingPOST:app_send_good parameters:dict returnClass:LxmBaseModel.class success:^(NSURLSessionDataTask *task, LxmBaseModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.intValue == 1000) {
            [LxmEventBus sendEvent:@"detailBottomAction" data:nil];
            if (num.intValue == 1) {
                [SVProgressHUD showSuccessWithStatus:@"已填写物流单号"];
            } else if (num.intValue == 2) {
                [SVProgressHUD showSuccessWithStatus:@"已修改物流单号"];
            } else {
                [SVProgressHUD showSuccessWithStatus:@"已确认自提"];
            }
            [selfWeak loadDetailData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

/**
 获取物流信息
 数组逆序
 //NSArray *strRevArray = [[strArr reverseObjectEnumerator] allObjects];
 */
- (void)loadWuLiuInfo {
    [SVProgressHUD show];
    WeakObj(self);
    [LxmNetworking networkingPOST:way_detail parameters:@{@"token":SESSION_TOKEN,@"id":self.orderID} returnClass:LxmWuLiuInfoRootModel.class success:^(NSURLSessionDataTask *task, LxmWuLiuInfoRootModel *responseObject) {
        [SVProgressHUD dismiss];
        if (responseObject.key.integerValue == 1000) {
            selfWeak.rootModel = responseObject;
            for (LxmWuLiuInfoStateModel *model in selfWeak.rootModel.result.list) {
               if (model.list) {
                   model.list = model.list;
               } else {
                   model.list = @[[LxmWuLiuInfoListModel new]];
               }
            }
            selfWeak.dataArr = [[selfWeak.rootModel.result.list reverseObjectEnumerator] allObjects];
            [selfWeak.tableView reloadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


@end


/**
 数量 商品价格
 */
@interface LxmJieSuanPeiSongInfoCell ()

@property (nonatomic, strong) UIView *lineView;

@end
@implementation LxmJieSuanPeiSongInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    [self addSubview:self.detailLabel];
    [self addSubview:self.lineView];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.centerY.equalTo(self);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self);
        make.height.equalTo(@1);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = CharacterDarkColor;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:13];
        _detailLabel.textColor = CharacterDarkColor;
    }
    return _detailLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

@end

/**
 商品详情 底部操作按钮
 */
@interface LxmOrderDetailBottomView ()

@property (nonatomic, strong) UIButton *buhuoButton;

@end

@implementation LxmOrderDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        [self addSubview:self.buhuoButton];
        [self.buhuoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
            make.height.equalTo(@30);
            make.width.equalTo(@80);
        }];
    }
    return self;
}

- (UIButton *)buhuoButton {
    if (!_buhuoButton) {
        _buhuoButton = [UIButton new];
        [_buhuoButton setTitle:@"去补货" forState:UIControlStateNormal];
        [_buhuoButton setTitleColor:MainColor forState:UIControlStateNormal];
        _buhuoButton.layer.borderColor = MainColor.CGColor;
        
        _buhuoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _buhuoButton.layer.cornerRadius = 15;
        _buhuoButton.layer.borderWidth = 0.5;
        _buhuoButton.layer.masksToBounds = YES;
        [_buhuoButton addTarget:self action:@selector(buhuoclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buhuoButton;
}

- (void)buhuoclick {
    if (self.gotobuhuoBlock) {
        self.gotobuhuoBlock();
    }
}

- (void)setModel:(LxmShopCenterOrderModel *)model {
    _model = model;
    switch (_model.status.intValue) {
        case 2: {//待发货
            [_buhuoButton setTitle:@"确认发货" forState:UIControlStateNormal];
            [_buhuoButton setTitleColor:MainColor forState:UIControlStateNormal];
            _buhuoButton.layer.borderColor = MainColor.CGColor;
        }
            break;
        case 3: {//已发货
            [_buhuoButton setTitle:@"修改单号" forState:UIControlStateNormal];
            [_buhuoButton setTitleColor:MainColor forState:UIControlStateNormal];
            _buhuoButton.layer.borderColor = MainColor.CGColor;
        }
            break;
        case 7: {//待自提
            [_buhuoButton setTitle:@"确认自提" forState:UIControlStateNormal];
            [_buhuoButton setTitleColor:MainColor forState:UIControlStateNormal];
            _buhuoButton.layer.borderColor = MainColor.CGColor;
        }
            break;
        case 8: {//已自提
            [_buhuoButton setTitle:@"已自提" forState:UIControlStateNormal];
            [_buhuoButton setTitleColor:MainColor forState:UIControlStateNormal];
            _buhuoButton.layer.borderColor = MainColor.CGColor;
        }
            break;
        default:
            break;
    }
}

@end

@interface LxmAcGoodsCell ()
@property (nonatomic, strong) UIImageView *iconImgView;//图片
@property (nonatomic, strong) UIButton *zIconImgView;//图片
@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UILabel *numLabel;//数量

@property (nonatomic, strong) UIView *selectButton;//选择按钮

@property (nonatomic, strong) UIImageView *selectImgView;//选择背景图

@end

@implementation LxmAcGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        [self setConstrains];
    }
    return self;
}

/**
 添加视图
 */
- (void)initSubviews {
    [self addSubview:self.selectButton];
    [self.selectButton addSubview:self.selectImgView];
    
    [self addSubview:self.iconImgView];
    [self.iconImgView addSubview:self.zIconImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.numLabel];
}

/**
 添加约束
 */
- (void)setConstrains {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@80);
    }];
    [self.zIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.iconImgView).offset(10);
        make.width.height.equalTo(@30);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImgView).offset(10);
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(15);
        make.trailing.lessThanOrEqualTo(self).offset(-15);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self).offset(-15);
    }];
    [self.numLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];  //设置水平方向抗压缩优先级高 水平方向可以正常显示
}

- (UIView *)selectButton {
    if (!_selectButton) {
        _selectButton = [[UIView alloc] init];
    }
    return _selectButton;
}

- (UIImageView *)selectImgView {
    if (!_selectImgView) {
        _selectImgView = [[UIImageView alloc] init];
    }
    return _selectImgView;
}


- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
    }
    return _iconImgView;
}
- (UIButton *)zIconImgView {
    if (!_zIconImgView) {
        _zIconImgView = [[UIButton alloc] init];
        [_zIconImgView setTitle:@"赠" forState:UIControlStateNormal];
        _zIconImgView.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _zIconImgView.backgroundColor = MainColor;
        _zIconImgView.userInteractionEnabled = NO;
        _zIconImgView.layer.cornerRadius = 15;
        _zIconImgView.layer.masksToBounds = YES;
    }
    return _zIconImgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = CharacterDarkColor;
    }
    return _titleLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.font = [UIFont systemFontOfSize:13];
        _numLabel.textColor = CharacterGrayColor;
    }
    return _numLabel;
}

- (void)setDetailGoodsModel:(LxmShopCenterAcGoodsModel *)detailGoodsModel {
    _detailGoodsModel = detailGoodsModel;
    _selectImgView.image = [UIImage imageNamed:_detailGoodsModel.isSelected ? @"xuanzhong_y" : @"xuanzhong_n"];
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_detailGoodsModel.good_pic]];
    _titleLabel.text = _detailGoodsModel.good_name;
    _numLabel.text = [NSString stringWithFormat:@"x%ld", _detailGoodsModel.num.integerValue];
    
    if (_status.intValue == 2) {
        self.selectButton.hidden = NO;
        self.selectImgView.hidden = NO;
        [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.bottom.equalTo(self);
            make.width.equalTo(@50);
        }];
        [self.selectImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.selectButton);
            make.width.height.equalTo(@20);
        }];
        [self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.selectButton.mas_trailing);
            make.top.equalTo(self).offset(15);
            make.width.height.equalTo(@80);
        }];
    } else {
        self.selectButton.hidden = YES;
        self.selectImgView.hidden = YES;
        [self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@80);
        }];
    }
    
}

@end
