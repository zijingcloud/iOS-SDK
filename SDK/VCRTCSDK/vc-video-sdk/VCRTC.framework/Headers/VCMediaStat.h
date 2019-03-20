//
//  VCMediaStat.h
//  VCRTC
//
//  Created by starcwl on 12/17/18.
//  Copyright © 2018 zijingcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTCLegacyStatsReport;

NS_ASSUME_NONNULL_BEGIN

@interface VCMediaStat : NSObject <NSCoding, NSCopying>
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *mediaType;
@property (nonatomic, strong) NSString *direction;
@property (nonatomic, strong) NSString *codec;
@property (nonatomic, assign) NSInteger bitrate; // unit: kbps
@property (nonatomic, assign) NSInteger packets;
@property (nonatomic, assign) NSInteger packetsLost;
@property (nonatomic, assign) unsigned long ssrc;
@property (nonatomic, strong) NSString *resolution; // width x height
@property (nonatomic, assign) NSInteger frameRate;
@property (nonatomic, assign) double timestamp; // unit: milliseconds since 1970;
@property (nonatomic, assign) double percentageLost; // 100%

- (NSString *)description;
@end

NS_ASSUME_NONNULL_END
