//
//  BaseTableViewController.m
//  ShareGo
//
//  Created by 李晓满 on 16/4/7.
//  Copyright © 2016年 李晓满. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseNavigationController.h"


@interface BaseTableViewController ()
{
    UITableViewStyle _tableViewStyle;
    UILabel *_noneLabel;
}
@end
@implementation BaseTableViewController

-(instancetype)initWithTableViewStyle:(UITableViewStyle)style
{
    if (self=[super init])
    {
        _tableViewStyle = style;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseTableView];
}

- (void)showNoneDataLabel {
    _noneLabel.hidden = NO;
}

- (void)hideNoneDataLabel {
    _noneLabel.hidden = YES;
}
-(void)initBaseTableView
{
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
    _tableView.autoresizingMask  =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}


//- (void)shareWeChatTitle:(NSString *)title content:(NSString *)content pic:(NSString *)pic url:(NSString *)url ok:(void(^)(void))okBlock error:(void(^)(void))errorBlock{
//    
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    messageObject.title = title?title:@"";
//    messageObject.text = content?content:@"";
//    //创建图片内容对象
//    NSString *urlKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:pic]];
//    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlKey];
//    if (!image) {
//        image = [UIImage imageNamed:@"1024"];
//    }
//    UMShareWebpageObject * obj = [UMShareWebpageObject shareObjectWithTitle:messageObject.title descr:messageObject.text thumImage:image];
//    obj.webpageUrl = url;
//    messageObject.shareObject = obj;
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//
//        if (error) {
//            if (errorBlock) {
//                errorBlock();
//            }
//        }else{
//            if (okBlock) {
//                okBlock();
//            }
//        }
//    }];
//    
//}
//- (void)shareWXPYQTitle:(NSString *)title content:(NSString *)content pic:(NSString *)pic url:(NSString *)url ok:(void(^)(void))okBlock error:(void(^)(void))errorBlock{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    messageObject.title = title?title:@"";
//    messageObject.text = content?content:@"";
//    //创建图片内容对象
//    NSString *urlKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:pic]];
//    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlKey];
//    if (!image) {
//        image = [UIImage imageNamed:@"1024"];
//    }
//    UMShareWebpageObject * obj = [UMShareWebpageObject shareObjectWithTitle:messageObject.title descr:messageObject.text thumImage:image];
//    obj.webpageUrl = url;
//    messageObject.shareObject = obj;
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            if (errorBlock) {
//                errorBlock();
//            }
//        }else{
//            if (okBlock) {
//                okBlock();
//            }
//        }
//    }];
//}


//- (void)gotoLogin {
//    BaseNavigationController * nav  = [[BaseNavigationController alloc] initWithRootViewController:[[LxmLoginVC alloc] init]];
//    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
//}


- (void)endRefrish {
    [SVProgressHUD dismiss];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
