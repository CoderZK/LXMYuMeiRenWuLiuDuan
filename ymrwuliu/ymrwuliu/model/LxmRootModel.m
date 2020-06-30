//
//  LxmRootModel.m
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmRootModel.h"

@implementation LxmRootModel

@end

@implementation LxmBaseModel

@end

/**
 商家中心 订单列表
 */

@implementation LxmShopCenterOrderGoodsModel

@end

@implementation LxmShopCenterOrderModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"sub" : @"LxmShopCenterOrderGoodsModel",
             @"sends":@"LxmShopCenterAcGoodsModel"
    };
}

- (CGFloat)orderHeight {
    if (_orderHeight == 0) {
        _orderHeight = [self.order_info getSizeWithMaxSize:CGSizeMake(ScreenW - 45 - 40, 9999) withFontSize:13].height + 30;
    }
    return _orderHeight;
}

- (NSArray<LxmShopCenterOrderGoodsModel *> *)sub2 {
    if (_sub2.count == 0) {
        if (self.sub.count > 2) {
            _sub2 = [self.sub subarrayWithRange:NSMakeRange(0, 2)];
        } else {
            _sub2 = self.sub;
        }
    }
    return _sub2;
}



@end

@implementation LxmShopCenterOrderListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"LxmShopCenterOrderModel"};
}

@end

@implementation LxmShopCenterOrderRootModel

@end


/**
 订单详情
 */
@implementation LxmShopCenterOrderDetailModel

@end

@implementation LxmShopCenterOrderDetailRootModel

@end

/**
 物流详情
 */
@implementation LxmWuLiuInfoListModel

@synthesize cellH = _cellH;
@synthesize detailH = _detailH;

- (CGFloat)detailH {
    if (_detailH == 0) {
        CGFloat h = [self.context getSizeWithMaxSize:CGSizeMake(ScreenW - 75, 9999) withFontSize:14].height;
        _detailH = 15 + 20 + 10 + h + 15;
    }
    return _detailH;
}

- (CGFloat)cellH {
    if (_cellH == 0) {
        if (self.context.isValid) {
            CGFloat h = [self.context getSizeWithMaxSize:CGSizeMake(ScreenW - 51, 9999) withFontSize:12].height;
            _cellH = 10 + h + 5 + 10 + 5;
        } else {
            _cellH = 7.5;
        }
    }
    return _cellH;
}

@end

@implementation LxmWuLiuInfoStateModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"LxmWuLiuInfoListModel"};
}

@end

@implementation LxmWuLiuInfoMapModel

@end

@implementation LxmWuLiuInfoResultModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : @"LxmWuLiuInfoStateModel"};
}

@end

@implementation LxmWuLiuInfoRootModel

@end

@implementation LxmShopCenterAcGoodsModel

@end
