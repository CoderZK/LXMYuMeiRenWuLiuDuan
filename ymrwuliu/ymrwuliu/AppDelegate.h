//
//  AppDelegate.h
//  ymrwuliu
//
//  Created by 李晓满 on 2019/8/7.
//  Copyright © 2019 李晓满. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

