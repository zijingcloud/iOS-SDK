//
//  ApnsInfor.h
//  ZjVideoDemo
//
//  Created by 李志朋 on 2018/2/28.
//  Copyright © 2018年 李志朋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApnsInfor : NSObject

@property(nonatomic,strong)NSString *token;

+(instancetype)shareApnsInfor;



@end
