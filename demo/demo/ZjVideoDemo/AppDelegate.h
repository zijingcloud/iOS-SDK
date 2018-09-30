//
//  AppDelegate.h
//  ZjVideoDemo
//
//  Created by 李志朋 on 2017/8/31.
//  Copyright © 2017年 李志朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) NSString *voipToken;
- (void)saveContext;


@end

