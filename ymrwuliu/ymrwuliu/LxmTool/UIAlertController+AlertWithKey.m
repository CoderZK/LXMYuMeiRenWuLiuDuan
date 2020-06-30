//
//  UIAlertController+AlertWithKey.m
//  JawboneUP
//
//  Created by 李晓满 on 2017/11/7.
//  Copyright © 2017年 李晓满. All rights reserved.
//

#import "UIAlertController+AlertWithKey.h"
#import "UIViewController+TopVC.h"
@implementation UIAlertController (AlertWithKey)
+(void)showAlertWithKey:(NSNumber *)num  message:(NSString *)message
{
    int n = [num intValue];
    NSString * msg = nil;
    switch (n)
    {
        case 8781:
            msg = @"手机号已经注册过";
            break;
        case 8782:
            msg = @"手机号未注册过";
            break;
        case 1010:
            msg = @"短信类型不存在";
            break;
        case 1002:
            msg = @"手机格式有误";
            break;
        case 1023:
            msg = @"一分钟内已发过，不能频繁发送";
            break;
        case 1003:
            msg = @"半小时内已经连续获取三次，请稍后在试";
            break;
        default:
            msg = message;
            break;
    }
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    
    [[UIViewController topViewController] presentViewController:alertController animated:YES completion:nil];
    
}

+(void)showAlertWithmessage:(NSString *)message {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    
    [[UIViewController topViewController] presentViewController:alertController animated:YES completion:nil];
}

@end
