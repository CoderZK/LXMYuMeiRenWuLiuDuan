//
//  LxmRootModel.h
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LxmRootModel : NSObject

@end

@interface LxmBaseModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) NSString *result;/**结果*/

@end

/**
 商家中心 订单列表
 */

@interface LxmShopCenterOrderGoodsModel : NSObject

@property (nonatomic, strong) NSString *good_price;/* 商品价格 */

@property (nonatomic, strong) NSString *good_name;/* 商品名称 */

@property (nonatomic, strong) NSString *list_pic;/* 商品图片 */

@property (nonatomic, strong) NSString *num;/* 商品数量 */

@property (nonatomic, strong) NSString *proxy_price;/* 商品代理价 */

@property (nonatomic, assign) BOOL isSelected;//是否选中

@end

@interface LxmShopCenterAcGoodsModel : NSObject
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *good_pic;
@property (nonatomic, strong) NSString *good_name;

@property (nonatomic, assign) BOOL isSelected;//是否选中
@end

@interface LxmShopCenterOrderModel : NSObject

@property (nonatomic, strong) NSString *order_code;/* 订单号 */

@property (nonatomic, strong) NSString *id;/* 订单id */

@property (nonatomic, strong) NSString *status;/* 1：待支付，2：待发货，3：待补货，4：已完成，5：已取消 */

@property (nonatomic, strong) NSString *total_money;/* 订单金额 */

@property (nonatomic, strong) NSString *province;/* 省 */

@property (nonatomic, strong) NSString *postage_type;/* 1：自提，2：快递 */

@property (nonatomic, strong) NSString *city;/* 市 */

@property (nonatomic, strong) NSString *district;/* 区 */

@property (nonatomic, strong) NSString *address_detail;/* 详情地址 */

@property (nonatomic, strong) NSString *username;/* 收货人姓名 */

@property (nonatomic, strong) NSString *my_name;/* 收货人姓名 */

@property (nonatomic, strong) NSString *telephone;/* 收货人手机号 */

@property (nonatomic, strong) NSString *my_tel;/* 收货人手机号 */

@property (nonatomic, strong) NSString *t_tel;/* 收货人姓名 */

@property (nonatomic, strong) NSString *t_name;/* 收货人姓名 */

@property (nonatomic, strong) NSArray  <LxmShopCenterOrderGoodsModel *>*sub;/* 商品列表 */

@property (nonatomic, strong) NSArray  <LxmShopCenterOrderGoodsModel *>*sub2;/* 商品列表 */

@property (nonatomic, strong) NSArray  <LxmShopCenterAcGoodsModel *>*sends;/* 商品列表 */

@property (nonatomic, strong) NSString *create_time;/* 下单时间 */

@property (nonatomic, strong) NSString * postage_status; /* 1：免邮，2：不免 */

@property (nonatomic, strong) NSString *address_id;/* 下单地址id */

@property (nonatomic, strong) NSString *user_id;/* 用户id */

@property (nonatomic, strong) NSString *order_type;/*  1-发货订单，2-批发销售，3-批发采购  */

@property (nonatomic, strong) NSString *order_info;/* 备注 */

@property (nonatomic, assign) CGFloat orderHeight;/* 备注高度 */

@property (nonatomic, strong) NSString *postage_code;/* 物流单号 */


@end


@interface LxmShopCenterOrderListModel : NSObject

@property (nonatomic, strong) NSString *allPageNumber;/**总页数*/

@property (nonatomic, strong) NSString *count;/**总数*/

@property (nonatomic, strong) NSArray  <LxmShopCenterOrderModel *>*list;/* 订单列表 */

@end


@interface LxmShopCenterOrderRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmShopCenterOrderListModel *result;/**结果*/

@end

/**
 订单详情
 */
@interface LxmShopCenterOrderDetailModel : NSObject

@property (nonatomic, strong) NSString *allPageNumber;/**总页数*/

@property (nonatomic, strong) NSString *count;/**总数*/

@property (nonatomic, strong) LxmShopCenterOrderModel *map;/* 订单信息 */

@end

@interface LxmShopCenterOrderDetailRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmShopCenterOrderDetailModel *result;/**结果*/

@end


/**
 物流详情
 */
@interface LxmWuLiuInfoListModel : NSObject

@property (nonatomic, strong) NSString *create_time;/**时间*/

@property (nonatomic, strong) NSString *context;/**描述*/

@property (nonatomic, strong) NSString *year;/** 年 */

@property (nonatomic, strong) NSString *diff;/** 时间 */

@property (nonatomic, strong) NSString *day;/** 月日 */

@property (nonatomic, strong) NSString *time;/** 时间 */

@property (nonatomic, assign) CGFloat detailH;

@property (nonatomic, assign) CGFloat cellH;

@end

@interface LxmWuLiuInfoStateModel : NSObject

@property (nonatomic, strong) NSString *title;/** 标题 */

@property (nonatomic, strong) NSArray  <LxmWuLiuInfoListModel *>*list;/* 订单列表 */

@end


@interface LxmWuLiuInfoMapModel : NSObject

@property (nonatomic, strong) NSString *orderCode;/**订单号*/

@property (nonatomic, strong) NSString *company;/**物流公司*/

@property (nonatomic, strong) NSString *status;/**1：待支付，2：待发货，3：待确认收货,4:待补货，5：已完成，6：已取消*/

@end

@interface LxmWuLiuInfoResultModel : NSObject

@property (nonatomic, strong) NSArray  <LxmWuLiuInfoStateModel *>*list;/* 物流列表 */

@property (nonatomic, strong) LxmWuLiuInfoMapModel *map;/* 订单信息 */

@end


@interface LxmWuLiuInfoRootModel : NSObject

@property (nonatomic, strong) NSString *key;/**总页数*/

@property (nonatomic, strong) NSString *message;/**总数*/

@property (nonatomic, strong) LxmWuLiuInfoResultModel *result;/**结果*/

@end
