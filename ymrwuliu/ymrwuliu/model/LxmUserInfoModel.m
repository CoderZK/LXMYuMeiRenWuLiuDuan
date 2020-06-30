//
//  LxmUserInfoModel.m
//  yumeiren
//
//  Created by 李晓满 on 2019/7/9.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import "LxmUserInfoModel.h"

@implementation LxmUserInfoModel

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (self.username) {
        [aCoder encodeObject:self.username forKey:@"username"];
    }
    if (self.userHead) {
        [aCoder encodeObject:self.userHead forKey:@"userHead"];
    }
    if (self.chatCode) {
        [aCoder encodeObject:self.chatCode forKey:@"chatCode"];
    }
    if (self.authorPic) {
        [aCoder encodeObject:self.authorPic forKey:@"authorPic"];
    }
    if (self.deposit) {
        [aCoder encodeObject:self.deposit forKey:@"deposit"];
    }
    if (self.realName) {
        [aCoder encodeObject:self.realName forKey:@"realName"];
    }
    if (self.telephone) {
        [aCoder encodeObject:self.telephone forKey:@"telephone"];
    }
    if (self.recoCode) {
        [aCoder encodeObject:self.recoCode forKey:@"recoCode"];
    }
    if (self.roleType) {
        [aCoder encodeObject:self.roleType forKey:@"roleType"];
    }
    if (self.balance) {
        [aCoder encodeObject:self.balance forKey:@"balance"];
    }
    if (self.redBalance) {
        [aCoder encodeObject:self.redBalance forKey:@"redBalance"];
    }
    if (self.id) {
        [aCoder encodeObject:self.id forKey:@"id"];
    }
    if (self.inMoney) {
        [aCoder encodeObject:self.inMoney forKey:@"inMoney"];
    }
    if (self.shopStatus) {
        [aCoder encodeObject:self.shopStatus forKey:@"shopStatus"];
    }
}

//解档
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.userHead = [aDecoder decodeObjectForKey:@"userHead"];
        self.chatCode = [aDecoder decodeObjectForKey:@"chatCode"];
        self.authorPic = [aDecoder decodeObjectForKey:@"authorPic"];
        self.deposit = [aDecoder decodeObjectForKey:@"deposit"];
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
        self.recoCode = [aDecoder decodeObjectForKey:@"recoCode"];
        self.roleType = [aDecoder decodeObjectForKey:@"roleType"];
        self.balance = [aDecoder decodeObjectForKey:@"balance"];
        self.redBalance = [aDecoder decodeObjectForKey:@"redBalance"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.inMoney = [aDecoder decodeObjectForKey:@"inMoney"];
        self.shopStatus = [aDecoder decodeObjectForKey:@"shopStatus"];
    }
    return self;
}

@end
