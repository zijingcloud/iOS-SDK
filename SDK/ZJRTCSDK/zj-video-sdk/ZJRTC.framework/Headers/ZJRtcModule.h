//
//  ZJRtcModule.h
//  webrtc-iOS-demo
//
//  Created by starcwl on 11/6/18.
//  Copyright © 2018 zijingcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJRtcEnumerates.h"
#import <UIKit/UIKit.h>

@class RTCMediaStream;
@class RTCPeerConnectionFactory;
@class ZJRtcModule;
@class ZJVideoView;
@class Participant;
@class ZJQualityParams ;
@class ZjMeetingManageModule ;

NS_ASSUME_NONNULL_BEGIN
typedef void(^successBlock)(id response);
typedef void(^failureBlock)(NSError *);
@protocol ZJRtcModuleDelegate <NSObject>
@optional
//- (void)ZJRtc:(ZJRtcModule *)module didAddChannelViewController:(ZJVideoView *)view;
// change to
- (void)ZJRtc:(ZJRtcModule *)module didAddChannelViewController:(UIViewController *)view;

- (void)ZJRtc:(ZJRtcModule *)module didDisconnectedWithReason:(NSError *)reason;
- (void)ZJRtc:(ZJRtcModule *)module didAddView:(ZJVideoView *)view uuid:(NSString *)uuid;
- (void)ZJRtc:(ZJRtcModule *)module didRemoveView:(ZJVideoView *)view uuid:(NSString *)uuid;
- (void)ZJRtc:(ZJRtcModule *)module didAddLocalView:(ZJVideoView *)view;
- (void)ZJRtc:(ZJRtcModule *)module didAddParticipant:(Participant *)participant;
- (void)ZJRtc:(ZJRtcModule *)module didUpdateParticipant:(Participant *)participant;
- (void)ZJRtc:(ZJRtcModule *)module didRemoveParticipant:(Participant *)participant;
- (void)ZJRtc:(ZJRtcModule *)module didReceivedMessage:(NSDictionary *)message;
- (void)ZJRtc:(ZJRtcModule *)module didReceivedStageVoice:(NSArray *)voices;

// by add li
- (void)ZJRtc:(ZJRtcModule *)module didLayoutParticipants:(NSArray *)participants;
- (void)ZJRtc:(ZJRtcModule *)module didUpdateImage:(NSString *)imageStr uuid:(NSString *)uuid;
- (void)ZJRtc:(ZJRtcModule *)module didStopImage:(NSString *)imageStr;
- (void)ZJRtc:(ZJRtcModule *)module recordAndlive:(NSDictionary *)data;
- (void)ZJRtc:(ZJRtcModule *)module layoutChange:(NSDictionary *)data ;

@end

@interface ZJRtcModule : NSObject
@property(nonatomic, weak) id <ZJRtcModuleDelegate> delegate;
@property(nonatomic, strong) NSString *apiServer;
@property(nonatomic, assign) NSUInteger bandwidth; //  default: 1024kbps
@property(nonatomic, strong) NSString *oemId; // only shitong;
@property(nonatomic, strong, readonly) NSString *uuid;
@property(nonatomic, strong) NSString *groupId;
@property(nonatomic, strong, readonly) NSMutableDictionary<NSString *, Participant *> *rosterList;
@property(nonatomic, assign) UIDeviceOrientation forceOrientation; // default none

+ (instancetype)sharedInstance;

- (void)loginWithUsername:(NSString *)name
                 password:(NSString *)password
                    phone:(NSString *)phone
                 nickname:(NSString *)nickname
                  success:(successBlock)success
                  failure:(failureBlock)failure ;


- (void)connectChannel:(nonnull NSString *)channel
              password:(NSString *)password
                  name:(nonnull NSString *)name
               success:(void (^)(id))success
               failure:(void (^)(NSError *))failure ;

// only yunshi

- (void)reconnect;

- (void)exitChannelSuccess:(successBlock)success failure:(failureBlock)failure;

- (void)closeChannelSuccess:(successBlock)success failure:(failureBlock)failure;

// iPhone media Control methods
- (void)micEnable:(BOOL)enabled;
- (void)videoEnable:(BOOL)enabled;
- (void)switchCamera;

// Channel control methods
- (void)sendMessage:(NSString *)message success:(successBlock)success failure:(failureBlock)failure;
- (void)inviteDesitination:(NSString *)dest success:(successBlock)success failure:(failureBlock)failure;
- (void)inviteDestination:(NSString *)dest
                 protocol:(NSString *)protocolType
                    alias:(NSString *)name
                     host:(BOOL)isHost
                streaming:(BOOL)isStreaming
                  success:(successBlock)success
                  failure:(failureBlock)failure;

- (void)enableRecordSuccess:(successBlock)success failure:(failureBlock)failure;
- (void)enableLiveSuccess:(successBlock)success failure:(failureBlock)failure;
- (void)disableLiveSuccess:(successBlock)success failure:(failureBlock)failure;
- (void)disableRecordSuccess:(successBlock)success failure:(failureBlock)failure;


// by add li
@property(nonatomic, strong) NSString *role ; // 参会者身份
@property(nonatomic, strong) ZjMeetingManageModule *manageModule ;
@property(nonatomic, strong) NSArray *videoUri ; // 入会界面


- (void)shareImageWith:(NSData *)imageData
                  open:(BOOL )open
                change:(BOOL )change
               success:(successBlock)success
               failure:(failureBlock)failure ;

- (void)openAudioAndVideoQuality:(BOOL )open
               completionHandler:(nullable void (^)(NSDictionary<NSString *, ZJQualityParams *> *stats))completionHandler;

- (void)connectChannel:(nonnull NSString *)channel
              password:(NSString *)password
                  name:(nonnull NSString *)name
               manager:(ZJConnectType )manageType
          videoProfile:(ZJVideoProfile )profile
           multistream:(BOOL )ismultistream
              callName:(NSString *)callName
          oneTimeToken:(NSString *)token
             byAccount:(NSString *)account
               success:(void (^)(id))success
               failure:(void (^)(NSError *))failure ;

- (void)layoutChangeHost:(NSString *)layout
                   guest:(NSString *)glayout
          conferenceType:(ZJConferenceType )type
                 success:(successBlock)success
                 failure:(failureBlock)failure;

- (void)reconnectCall ;

@end

NS_ASSUME_NONNULL_END
