//
//  RTViewController.h
//  ZjVideoDemo
//
//  Created by 李志朋 on 2018/1/30.
//  Copyright © 2018年 李志朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTViewController : UITabBarController



-(void)inCommingCall:(NSDictionary *)dict;
-(void)rejectedCall:(NSDictionary *)dict;
@end