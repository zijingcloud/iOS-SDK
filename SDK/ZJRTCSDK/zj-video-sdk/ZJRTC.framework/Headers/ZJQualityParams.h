//
//  ZJQualityParams.h
//  ZJRTC
//
//  Created by 李志朋 on 2018/12/7.
//  Copyright © 2018年 zijingcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJQualityParams : NSObject

@property (nonatomic, assign ) float packets_sent ;
@property (nonatomic, assign ) float packet_lost ;
@property (nonatomic, assign ) float percentage_lost ;
@property (nonatomic, assign ) NSInteger bitrate ;
@property (nonatomic, assign ) NSInteger frame_rate ;
@property (nonatomic, strong ) NSString *resolution ;
@property (nonatomic, strong ) NSString *codec ;
@property (nonatomic, strong ) NSString *ssrc ;
@property (nonatomic, assign ) double timeStamp ;
@property (nonatomic, assign ) double bytes_sent ;
@property (nonatomic, strong ) NSString *echo_level ;

@end

NS_ASSUME_NONNULL_END
