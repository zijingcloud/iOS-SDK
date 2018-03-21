//
//  ApnsInfor.m
//  ZjVideoDemo
//
//  Created by 李志朋 on 2018/2/28.
//  Copyright © 2018年 李志朋. All rights reserved.
//

#import "ApnsInfor.h"

static ApnsInfor *_data;
@implementation ApnsInfor

+(instancetype)shareApnsInfor{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _data = [self alloc];
    });
    return _data;
}

-(NSString *)token{
    if (!_token) {
        _token = [NSString string];
    }
    return _token;
}




@end
