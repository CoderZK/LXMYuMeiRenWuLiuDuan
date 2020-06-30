//
//  LxmURLDefine.h
//  shenbian
//
//  Created by 李晓满 on 2018/11/12.
//  Copyright © 2018年 李晓满. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ISLOGIN [LxmTool ShareTool].isLogin
#define TOKEN [LxmTool ShareTool].session_token

#define Base_URL @"http://app.hkymr.com:8989"
//#define Base_URL @"https://app.hkymr.com"
#define Base_RESOURSE_URL @"https://vedio.hkymr.com"

/**
 单张图片上传 或视频上传
 */
#define  Base_upload_img_URL  Base_URL"/app/seven_app_file_up"
/**
 多张图片上传
 */
#define  Base_upload_multi_img_URL  Base_URL"/app/multi_seven_app_file_up"


@interface LxmURLDefine : NSObject
/**
 登录
 */
#define  pc_login  Base_URL"/manager/pc_login"
/**
 退出登录
 */
#define  logout  Base_URL"/manager/logout"
/**
 订单列表
 */
#define  app_order_list  Base_URL"/manager/user/pc/app_order_list"
/**
 订单详情
 */
#define  good_order_detail  Base_URL"/manager/user/pc/good_order_detail"
/**
 确认发货、修改物流单号、确认自提
 */
#define  app_send_good  Base_URL"/manager/user/pc/app_send_good"
/**
 物流详情
 */
#define  way_detail  Base_URL"/manager/user/pc/way_detail"

/**
 获取图片地址
 */
+(NSString *)getPicImgWthPicStr:(NSString *)pic;

@end

