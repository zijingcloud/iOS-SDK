//
//  Participant.h
//  VCRTC
//
//  Created by starcwl on 11/19/18.
//  Copyright © 2018 zijingcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Participant : NSObject
@property (nonatomic, strong) NSString *callDirection;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, assign) BOOL isMuted;
@property (nonatomic, assign) BOOL isAudioOnlyCall;
@property (nonatomic, assign) BOOL isVideoCall;
@property (nonatomic, assign) BOOL isVmuted;
@property (nonatomic, strong) NSString *localAlias;
@property (nonatomic, strong) NSString *overlayText;
@property (nonatomic, strong) NSString *protocolType;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSString *uri;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *vendor;
// for zipeng
@property (nonatomic, strong) NSString *ssrc;
@property (nonatomic, strong) NSString *serviceType;
@property (nonatomic, assign) int spotlight;
@property (nonatomic, assign) BOOL isChair;
@property (nonatomic, assign) BOOL isWaiting;
@property (nonatomic, assign) BOOL isConnecting;
@property (nonatomic, assign) BOOL isSpeaking;
@property (nonatomic, assign) int vad;
@property (nonatomic, strong) NSString *cStickUuid ;


- (instancetype)initWithData:(NSDictionary *)data;

- (Participant *)updateWithData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
