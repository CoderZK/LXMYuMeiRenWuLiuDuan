//
//  LxmJieDanPlatSubListVC.m
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmJieDanPlatSubListVC.h"
#import "LxmMyOrderDetailVC.h"
#import "LxmTianXieDanHaoVC.h"

@interface LxmJieDanPlatSubListVC ()

@property (nonatomic, strong) NSMutableArray <LxmShopCenterOrderModel *>*dataArr;

@end

@implementation LxmJieDanPlatSubListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.dataArr = [NSMutableArray array];
    self.allPageNum = 1;
    self.page = 1;
    [self loadData];
    WeakObj(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        StrongObj(self);
        self.page = 1;
        self.allPageNum = 1;
        [self loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        StrongObj(self);
        [self loadData];
    }];
    [LxmEventBus registerEvent:@"detailBottomAction" block:^(id data) {
        self.page = 1;
        self.allPageNum = 1;
        [self loadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr[section].sub2.count + 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LxmSubBuHuoOrderTopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSubBuHuoOrderTopCell"];
        if (!cell) {
            cell = [[LxmSubBuHuoOrderTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSubBuHuoOrderTopCell"];
        }
        cell.orderModel = self.dataArr[indexPath.section];
        return cell;
    } else if (indexPath.row == 1) {
        LxmShopCenterOrderModel *orderModel = self.dataArr[indexPath.section];
        if (orderModel.postage_type.intValue == 1) {
            if (orderModel.status.intValue == 7 || orderModel.status.intValue == 8) {
                LxmSubOrderChaXunAddressCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSubOrderChaXunAddressCell1"];
                if (!cell) {
                    cell = [[LxmSubOrderChaXunAddressCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSubOrderChaXunAddressCell1"];
                }
                cell.orderModel = self.dataArr[indexPath.section];
                return cell;
            }
        }
        LxmSubOrderChaXunAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSubOrderChaXunAddressCell"];
        if (!cell) {
            cell = [[LxmSubOrderChaXunAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSubOrderChaXunAddressCell"];
        }
        cell.orderModel = self.dataArr[indexPath.section];
        return cell;
    } else if (indexPath.row == 2) {
        LxmNoteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmNoteCell"];
        if (!cell) {
            cell = [[LxmNoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmNoteCell"];
        }
        cell.titleLabel.text = @"备注:";
        cell.detailLabel.text = self.dataArr[indexPath.section].order_info;
        return cell;
    } else if (indexPath.row == self.dataArr[indexPath.section].sub2.count + 5 - 2) {
        LxmSubBuHuoOrderPriceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSubBuHuoOrderPriceCell"];
        if (!cell) {
            cell = [[LxmSubBuHuoOrderPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSubBuHuoOrderPriceCell"];
        }
        cell.orderModel = self.dataArr[indexPath.section];
        return cell;
    } else if (indexPath.row == self.dataArr[indexPath.section].sub2.count + 5 - 1) {
        LxmSubBuHuoOrderButtonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmSubBuHuoOrderButtonCell"];
        if (!cell) {
            cell = [[LxmSubBuHuoOrderButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmSubBuHuoOrderButtonCell"];
        }
        cell.orderModel = self.dataArr[indexPath.section];
        WeakObj(self);
        cell.gotobuhuoBlock = ^(LxmShopCenterOrderModel *orderModel) {
            [selfWeak bottomAction:orderModel];
        };
        return cell;
    } else {
        LxmJieSuanPeiSongGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LxmJieSuanPeiSongGoodsCell"];
        if (!cell) {
            cell = [[LxmJieSuanPeiSongGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LxmJieSuanPeiSongGoodsCell"];
        }
        cell.orderModel = self.dataArr[indexPath.section].sub2[indexPath.row - 3];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmShopCenterOrderModel *orderModel = self.dataArr[indexPath.section];
    if (indexPath.row == 0) {
        return 40;
    } else if (indexPath.row == 1) {
        if (orderModel.postage_type.intValue == 1) {
            if (orderModel.status.intValue == 7 || orderModel.status.intValue == 8) {
                return 60;
            }
            return 0.01;
        }
        return 80;
    } else if (indexPath.row == 2) {
        if (orderModel.order_info.isValid) {
            return orderModel.orderHeight;
        }
        return 0.01;
    } else if (indexPath.row == self.dataArr[indexPath.section].sub2.count + 5 - 2) {
        return 44;
    } else if(indexPath.row == self.dataArr[indexPath.section].sub2.count + 5 - 1) {
        if (orderModel.status.intValue == 2 || orderModel.status.intValue == 3 || orderModel.status.intValue == 7 || orderModel.status.intValue == 8) {
            return 60;
        }
        return 0.001;
    } else {
        return 110;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LxmShopCenterOrderModel *orderModel = self.dataArr[indexPath.section];
    LxmMyOrderDetailVC *vc = [[LxmMyOrderDetailVC alloc] init];
    vc.status = orderModel.status;
    vc.postage_code = orderModel.postage_code;
    vc.orderID = orderModel.id;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 请求数据
 */
- (void)loadData {
    if (self.page <= self.allPageNum) {
        if (self.dataArr.count <= 0) {
            [SVProgressHUD show];
        }
        
        NSMutableDictionary *dict = nil;
        if (self.dict) {
            dict = [[NSMutableDictionary alloc] initWithDictionary:self.dict];
        } else {
            dict = [NSMutableDictionary dictionary];
        }
        dict[@"token"] = SESSION_TOKEN;
        dict[@"pageNum"] =  @(self.page);
        dict[@"pageSize"] = @10;
        dict[@"status"] = self.status;
        dict[@"type"] = @1;
        if (self.status.intValue == 2 || self.status.intValue == 7) {
            dict[@"order_type"] = @1;
        } else if (self.status.intValue == 3 || self.status.intValue == 8){
            dict[@"order_type"] = @2;
        }
        [LxmNetworking networkingPOST:app_order_list parameters:dict returnClass:LxmShopCenterOrderRootModel.class success:^(NSURLSessionDataTask *task, LxmShopCenterOrderRootModel *responseObject) {
            [self endRefrish];
            if (responseObject.key.intValue == 1000) {
                self.allPageNum = responseObject.result.allPageNumber.intValue;
                if (self.status.intValue == 2 || self.status.intValue == 7) {
                    [LxmEventBus sendEvent:@"redNum" data:@{@"status":self.status,@"count":responseObject.result.count}];
                }
                if (self.page == 1) {
                    [self.dataArr removeAllObjects];
                }
                if (self.page <= responseObject.result.allPageNumber.intValue) {
                    [self.dataArr addObjectsFromArray:responseObject.result.list];
                }
                self.page ++;
                [self.tableView reloadData];
            } else {
                [UIAlertController showAlertWithmessage:responseObject.message];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self endRefrish];
        }];
    }
}

/**
 底部操作按钮
 */
- (void)bottomAction:(LxmShopCenterOrderModel *)model {
    if (model.status.integerValue == 2) {//确认发货
        LxmTianXieDanHaoVC *vc = [[LxmTianXieDanHaoVC alloc] initWithTableViewStyle:UITableViewStyleGrouped type:LxmTianXieDanHaoVC_type_tianjia];
        vc.tianxieBlock = ^(NSString *code) {
            [self sureFaHuo:model num:@1 code:code];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if (model.status.integerValue == 3) { //修改单号
        LxmTianXieDanHaoVC *vc = [[LxmTianXieDanHaoVC alloc] initWithTableViewStyle:UITableViewStyleGrouped type:LxmTianXieDanHaoVC_type_xiugai];
        vc.code = model.postage_code;
        vc.tianxieBlock = ^(NSString *code) {
            [self sureFaHuo:model num:@2 code:code];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if (model.status.integerValue == 7) {//确认自提
        [self sureFaHuo:model num:@3 code:nil];
    }
}
/**
 确认发货
 */
- (void)sureFaHuo:(LxmShopCenterOrderModel *)model num:(NSNumber *)num code:(NSString *)code{
    [SVProgressHUD show];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = SESSION_TOKEN;
    dict[@"id"] = model.id;
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
            if (num.intValue == 1) {
                [SVProgressHUD showSuccessWithStatus:@"已填写物流单号"];
            } else if (num.intValue == 2) {
                [SVProgressHUD showSuccessWithStatus:@"已修改物流单号"];
            } else {
                [SVProgressHUD showSuccessWithStatus:@"已确认自提"];
            }
            selfWeak.page = 1;
            selfWeak.allPageNum = 1;
            [selfWeak loadData];
        } else {
            [UIAlertController showAlertWithmessage:responseObject.message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


@end

/**
 补货视图
 */
@interface LxmSubBuHuoOrderTopCell ()

@property (nonatomic, strong) UILabel *orderLabel;//订单号

@property (nonatomic, strong) UILabel *stateLabel;//订单状态

@property (nonatomic, strong) UIView *lineView;//线

@end
@implementation LxmSubBuHuoOrderTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.orderLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.lineView];
        [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.equalTo(self);
            make.height.equalTo(@0.5);
        }];
        [self setData];
    }
    return self;
}

- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [UILabel new];
        _orderLabel.font = [UIFont systemFontOfSize:12];
    }
    return _orderLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _stateLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (void)setData {
    self.stateLabel.textColor = MainColor;
    self.orderLabel.text = @"订单号：801248383905496323";
    self.stateLabel.text = @"待发货";
}

- (void)setOrderModel:(LxmShopCenterOrderModel *)orderModel {
    _orderModel = orderModel;
    self.stateLabel.textColor = MainColor;
    self.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",_orderModel.order_code];
    switch (_orderModel.status.intValue) {
        case 2: {
            self.stateLabel.textColor = MainColor;
            self.stateLabel.text = @"待发货";
        }
            break;
        case 3: {
            self.stateLabel.textColor = MainColor;
            self.stateLabel.text = @"已发货";
        }
            break;
        case 7: {
            self.stateLabel.textColor = CharacterGrayColor;
            self.stateLabel.text = @"待自提";
        }
            break;
        case 8: {
            self.stateLabel.textColor = CharacterGrayColor;
            self.stateLabel.text = @"已自提";
        }
            break;
        default:
            break;
    }
}

@end

//LxmJieSuanPeiSongGoodsCell 商品cell

@interface LxmSubBuHuoOrderPriceCell ()

@property (nonatomic, strong) UIView *lineView;//线

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UIView *lineView1;//线

@end
@implementation LxmSubBuHuoOrderPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.lineView];
        [self addSubview:self.priceLabel];
        [self addSubview:self.lineView1];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.height.equalTo(@0.5);
        }];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
        }];
        [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.bottom.trailing.equalTo(self);
            make.height.equalTo(@0.5);
        }];
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

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"商品总计： " attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"¥238" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:MainColor}];
        [att appendAttributedString:str];
        _priceLabel.attributedText = att;
    }
    return _priceLabel;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [UIView new];
        _lineView1.backgroundColor = BGGrayColor;
    }
    return _lineView1;
}

- (void)setOrderModel:(LxmShopCenterOrderModel *)orderModel {
    _orderModel = orderModel;
    CGFloat f = 0;
    NSInteger d = 0;
    for (LxmShopCenterOrderGoodsModel *m in _orderModel.sub) {
        f += m.proxy_price.floatValue * m.num.integerValue;
        d += m.proxy_price.integerValue * m.num.integerValue;
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"商品总计： " attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:CharacterDarkColor}];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:f == d ? [NSString stringWithFormat:@"¥%ld",d] : [NSString stringWithFormat:@"¥%.2f",f] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:MainColor}];
    [att appendAttributedString:str];
    _priceLabel.attributedText = att;
}

//订单查询 详情
- (void)setShifujineMoney:(NSString *)shifujineMoney {
    _shifujineMoney = shifujineMoney;
    CGFloat f = _shifujineMoney.floatValue;
    NSInteger d = _shifujineMoney.integerValue;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"实付金额： " attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:CharacterDarkColor}];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString: d==f ? [NSString stringWithFormat:@"¥%ld",d] : [NSString stringWithFormat:@"¥%.2f",f] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:MainColor}];
    [att appendAttributedString:str];
    _priceLabel.attributedText = att;
}

@end


@interface LxmSubBuHuoOrderButtonCell ()

@property (nonatomic, strong) UIButton *buhuoButton;

@end
@implementation LxmSubBuHuoOrderButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
        _buhuoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _buhuoButton.layer.cornerRadius = 15;
        _buhuoButton.layer.borderColor = MainColor.CGColor;
        _buhuoButton.layer.borderWidth = 0.5;
        _buhuoButton.layer.masksToBounds = YES;
        [_buhuoButton addTarget:self action:@selector(buhuoclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buhuoButton;
}

- (void)buhuoclick {
    if (self.gotobuhuoBlock) {
        self.gotobuhuoBlock(self.orderModel);
    }
}

- (void)setOrderModel:(LxmShopCenterOrderModel *)orderModel {
    _orderModel = orderModel;
    switch (_orderModel.status.intValue) {
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


/**
 地址
 */
#import "LxmCopyLabel.h"
@interface LxmSubOrderChaXunAddressCell ()

@property (nonatomic, strong) UIImageView *iconImgView;//定位图标

@property (nonatomic, strong) LxmCopyLabel *titleLabel;//姓名 + 电话

@property (nonatomic, strong) LxmCopyLabel *addressLabel;//地址

@property (nonatomic, strong) UIView *lineView;//线

@end
@implementation LxmSubOrderChaXunAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
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
    [self addSubview:self.iconImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.lineView];
}

/**
 设置约束
 */
- (void)setConstrains {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
        make.trailing.lessThanOrEqualTo(self).offset(-15);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
        make.trailing.lessThanOrEqualTo(self).offset(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"local"];
    }
    return _iconImgView;
}

- (LxmCopyLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[LxmCopyLabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (LxmCopyLabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [LxmCopyLabel new];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.textColor = CharacterDarkColor;
    }
    return _addressLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (void)setOrderModel:(LxmShopCenterOrderModel *)orderModel {
    _orderModel = orderModel;
    if (_orderModel.status.intValue == 7 || _orderModel.status.intValue == 8) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ",_orderModel.my_name] attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:_orderModel.my_tel ? _orderModel.my_tel : @"" attributes:@{ NSForegroundColorAttributeName:CharacterLightGrayColor}];
        [att appendAttributedString:str];
        self.titleLabel.attributedText = att;
    } else {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ",_orderModel.username] attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:_orderModel.telephone ? _orderModel.telephone : @"" attributes:@{ NSForegroundColorAttributeName:CharacterLightGrayColor}];
        [att appendAttributedString:str];
        self.titleLabel.attributedText = att;
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",_orderModel.province, _orderModel.city, _orderModel.district, _orderModel.address_detail];
    }
}

@end



/**
 地址
 */
#import "LxmCopyLabel.h"
@interface LxmSubOrderChaXunAddressCell1 ()

@property (nonatomic, strong) UIImageView *iconImgView;//定位图标

@property (nonatomic, strong) LxmCopyLabel *titleLabel;//姓名 + 电话

@property (nonatomic, strong) UIView *lineView;//线

@end
@implementation LxmSubOrderChaXunAddressCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
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
    [self addSubview:self.iconImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
}

/**
 设置约束
 */
- (void)setConstrains {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.width.height.equalTo(@15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self);
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(10);
        make.trailing.lessThanOrEqualTo(self).offset(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
        _iconImgView.image = [UIImage imageNamed:@"local"];
    }
    return _iconImgView;
}

- (LxmCopyLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[LxmCopyLabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = BGGrayColor;
    }
    return _lineView;
}

- (void)setOrderModel:(LxmShopCenterOrderModel *)orderModel {
    _orderModel = orderModel;
    if (_orderModel.status.intValue == 7 || _orderModel.status.intValue == 8) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ",_orderModel.my_name] attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:_orderModel.my_tel ? _orderModel.my_tel : @"" attributes:@{ NSForegroundColorAttributeName:CharacterLightGrayColor}];
        [att appendAttributedString:str];
        self.titleLabel.attributedText = att;
    } else {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ",_orderModel.username] attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:_orderModel.telephone ? _orderModel.telephone : @"" attributes:@{ NSForegroundColorAttributeName:CharacterLightGrayColor}];
        [att appendAttributedString:str];
        self.titleLabel.attributedText = att;
    }
    
}

- (void)setOrderModel1:(LxmShopCenterOrderModel *)orderModel1 {
    _orderModel1 = orderModel1;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@   ",_orderModel1.t_name] attributes:@{NSForegroundColorAttributeName:CharacterDarkColor}];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:_orderModel1.t_tel ? _orderModel1.t_tel : @"" attributes:@{ NSForegroundColorAttributeName:CharacterLightGrayColor}];
    [att appendAttributedString:str];
    self.titleLabel.attributedText = att;
}

@end


/**
 配送商品
 */
@interface LxmJieSuanPeiSongGoodsCell ()

@property (nonatomic, strong) UIImageView *iconImgView;//图片

@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UILabel *moneyLabel;//钱数

@property (nonatomic, strong) UILabel *numLabel;//数量

@property (nonatomic, strong) UIView *selectButton;//选择按钮

@property (nonatomic, strong) UIImageView *selectImgView;//选择背景图

@end
@implementation LxmJieSuanPeiSongGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
        [self setConstrains];
        [self setData];
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
    [self addSubview:self.titleLabel];
    [self addSubview:self.moneyLabel];
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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImgView).offset(10);
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(15);
        make.trailing.lessThanOrEqualTo(self).offset(-15);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImgView).offset(-10);
        make.leading.equalTo(self.iconImgView.mas_trailing).offset(15);
        make.trailing.lessThanOrEqualTo(self.numLabel.mas_leading).offset(-5);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moneyLabel);
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

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:18];
        _moneyLabel.textColor = MainColor;
    }
    return _moneyLabel;
}

- (void)setData {
    self.titleLabel.text = @"高端魅力修护套装";
    self.moneyLabel.text = @"¥198";
    self.numLabel.text = @"X2";
}

- (void)setOrderModel:(LxmShopCenterOrderGoodsModel *)orderModel {
    _orderModel = orderModel;
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_orderModel.list_pic] placeholderImage:[UIImage imageNamed:@"tupian"]];
    _titleLabel.text = _orderModel.good_name;
    CGFloat f = _orderModel.good_price.floatValue;
    NSInteger d = _orderModel.good_price.integerValue;
    
    CGFloat f1 = _orderModel.proxy_price.floatValue;
    NSInteger d1 = _orderModel.proxy_price.integerValue;
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:f1==d1 ? [NSString stringWithFormat:@"¥%ld ",d1] : [NSString stringWithFormat:@"¥%.2f ",f1] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:MainColor}];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:f==d ? [NSString stringWithFormat:@"¥%ld ",d] : [NSString stringWithFormat:@"¥%.2f ",f] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:CharacterLightGrayColor,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    [att appendAttributedString:str];
    _moneyLabel.attributedText = att;
    _moneyLabel.attributedText = att;
    _numLabel.text = [NSString stringWithFormat:@"X%@", _orderModel.num];
}


/**
 订单查询 订单详情 商品信息
 */
- (void)setOrderDetailGoodsModel:(LxmShopCenterOrderGoodsModel *)orderDetailGoodsModel {
    _orderDetailGoodsModel = orderDetailGoodsModel;
    _selectImgView.image = [UIImage imageNamed:_orderDetailGoodsModel.isSelected ? @"xuanzhong_y" : @"xuanzhong_n"];
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_orderDetailGoodsModel.list_pic] placeholderImage:[UIImage imageNamed:@"tupian"]];
    _titleLabel.text = _orderDetailGoodsModel.good_name;
    
    CGFloat f = _orderDetailGoodsModel.good_price.floatValue;
    NSInteger d = _orderDetailGoodsModel.good_price.integerValue;
    
    CGFloat f1 = _orderDetailGoodsModel.proxy_price.floatValue;
    NSInteger d1 = _orderDetailGoodsModel.proxy_price.integerValue;
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:f1==d1 ? [NSString stringWithFormat:@"¥%ld ",d1] : [NSString stringWithFormat:@"¥%.2f ",f1] attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:MainColor}];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:f==d ? [NSString stringWithFormat:@"¥%ld ",d] : [NSString stringWithFormat:@"¥%.2f ",f] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:CharacterLightGrayColor,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    [att appendAttributedString:str];
    _moneyLabel.attributedText = att;
    _numLabel.text = [NSString stringWithFormat:@"X%@", _orderDetailGoodsModel.num];
    
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

@interface LxmNoteCell ()

@property (nonatomic, strong) UIView *lineView;

@end
@implementation LxmNoteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
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
        make.leading.top.equalTo(self).offset(15);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-15);
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(15);
        make.top.equalTo(self).offset(15);
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
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentRight;
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

