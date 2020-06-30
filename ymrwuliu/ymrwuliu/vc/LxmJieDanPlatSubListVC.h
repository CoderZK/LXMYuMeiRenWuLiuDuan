//
//  LxmJieDanPlatSubListVC.h
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

@interface LxmJieDanPlatSubListVC : BaseTableViewController

@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) NSNumber *status;//

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger allPageNum;

- (void)loadData;

@end

/**
 补货视图
 */
@interface LxmSubBuHuoOrderTopCell : UITableViewCell

@property (nonatomic, strong) LxmShopCenterOrderModel *orderModel;//商家中心 发货订单

@end

@interface LxmSubBuHuoOrderPriceCell : UITableViewCell

@property (nonatomic, strong) LxmShopCenterOrderModel *orderModel;//商家中心 发货订单
@property (nonatomic, strong) NSString *shifujineMoney;//订单查询 详情

@end

@interface LxmSubBuHuoOrderButtonCell : UITableViewCell

@property (nonatomic, strong) LxmShopCenterOrderModel *orderModel;//商家中心 发货订单

@property (nonatomic, copy) void(^gotobuhuoBlock)(LxmShopCenterOrderModel *orderModel);

@end


/**
 地址
 */
@interface LxmSubOrderChaXunAddressCell : UITableViewCell

@property (nonatomic, strong) LxmShopCenterOrderModel *orderModel;//商家中心 发货订单

@end

@interface LxmSubOrderChaXunAddressCell1 : UITableViewCell

@property (nonatomic, strong) LxmShopCenterOrderModel *orderModel;//商家中心 发货订单

@property (nonatomic, strong) LxmShopCenterOrderModel *orderModel1;//商家中心 发货订单


@end

/**
 配送商品
 */
@interface LxmJieSuanPeiSongGoodsCell : UITableViewCell

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) LxmShopCenterOrderGoodsModel *orderDetailGoodsModel;//订单查询 详情

@property (nonatomic, copy) void(^seletBlock)(LxmShopCenterOrderGoodsModel *orderDetailGoodsModel);

@property (nonatomic, strong) LxmShopCenterOrderGoodsModel *orderModel;//商家中心 发货订单

@end


@interface LxmNoteCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;//

@property (nonatomic, strong) UILabel *detailLabel;//

@end
