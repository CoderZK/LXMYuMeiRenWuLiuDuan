//
//  LxmMyOrderDetailVC.h
//  yumeiren
//
//  Created by 李晓满 on 2019/7/26.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

@interface LxmMyOrderDetailVC : BaseTableViewController

@property (nonatomic, strong) NSString *orderID;/* 订单号 */

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *postage_code;/* 物流单号 */

@end

/**
 数量 商品价格
 */
@interface LxmJieSuanPeiSongInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;//

@property (nonatomic, strong) UILabel *detailLabel;//

@end

/// 结算活动商品cell
@interface LxmAcGoodsCell : UITableViewCell

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) LxmShopCenterAcGoodsModel *detailGoodsModel;

@end


/**
 商品详情 底部操作按钮
 */
@interface LxmOrderDetailBottomView : UIView

@property (nonatomic, strong) LxmShopCenterOrderModel *model;

@property (nonatomic, copy) void(^gotobuhuoBlock)(void);

@end
