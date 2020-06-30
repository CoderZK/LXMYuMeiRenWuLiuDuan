//
//  LxmShaiXuanView.h
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxmShaiXuanView : UIControl

- (void)showAtView:(UIView *)view;

- (void)dismiss;

@property (nonatomic, copy) void(^sureBlock)(NSDictionary *dict);

@end


/**
 各个筛选item
 */
@interface LxmShaiXuanItemView : UIControl

@property (nonatomic, strong) UILabel *titleLabel;//标题

@property (nonatomic, strong) UITextField *textTF;//输入框

@end
