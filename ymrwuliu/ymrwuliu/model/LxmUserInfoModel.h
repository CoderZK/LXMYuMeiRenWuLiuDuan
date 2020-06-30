//
//  LxmUserInfoModel.h
//  yumeiren
//
//  Created by 李晓满 on 2019/7/9.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LxmUserInfoModel : NSObject<NSCoding>

@property (nonatomic , strong) NSString *username;//姓名

@property (nonatomic , strong) NSString *userHead;//头像

@property (nonatomic , strong) NSString *chatCode;//微信号

@property (nonatomic , strong) NSString *authorPic;//授权图片

@property (nonatomic , strong) NSString *deposit;// 保证金

@property (nonatomic , strong) NSString *realName;// 真实姓名 用于判断是否已经实名认证

@property (nonatomic , strong) NSString *telephone;//手机号

@property (nonatomic , strong) NSString *recoCode;// 推荐码

@property (nonatomic , strong) NSString *roleType;// 0：无，1：县代，2：市代，3：省代，4：ceo

@property (nonatomic , strong) NSString *balance;// 余额

@property (nonatomic , strong) NSString *redBalance;// 红包余额

@property (nonatomic , strong) NSString *id;// 用户id

@property (nonatomic , strong) NSString *inMoney;// 销售收入

@property (nonatomic , strong) NSString *shopStatus;// 0:未付保证金，1：已付保证金，2：已填信息,4：申请省级中，5：后台通过省长审核待升级 6-可以购买， 7-不可以购买，需要先升级


@end

NS_ASSUME_NONNULL_END
