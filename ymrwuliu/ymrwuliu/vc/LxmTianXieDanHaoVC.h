//
//  LxmTianXieDanHaoVC.h
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger,LxmTianXieDanHaoVC_type) {
    LxmTianXieDanHaoVC_type_tianjia,
    LxmTianXieDanHaoVC_type_xiugai
};

@interface LxmTianXieDanHaoVC : BaseTableViewController

@property (nonatomic, strong) NSString *code;

@property (nonatomic, copy) void(^tianxieBlock)(NSString *code);

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style type:(LxmTianXieDanHaoVC_type)type;

@end

