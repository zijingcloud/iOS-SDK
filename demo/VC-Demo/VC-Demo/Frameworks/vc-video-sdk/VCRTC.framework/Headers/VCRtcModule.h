//
//  VCRtcModule.h
//  webrtc-iOS-demo
//
//  Created by starcwl on 11/6/18.
//  Copyright © 2018 zijingcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCRtcEnumerates.h"
#import <UIKit/UIKit.h>

@class RTCMediaStream;
@class RTCPeerConnectionFactory;
@class VCRtcModule;
@class VCVideoView;
@class Participant;
@class VCMediaStat;

NS_ASSUME_NONNULL_BEGIN
typedef void(^successBlock)(id response);
typedef void(^failureBlock)(NSError *);
@protocol VCRtcModuleDelegate <NSObject>
@optional
// change to
- (void)VCRtc:(VCRtcModule *)module didAddChannelViewController:(UIViewController *)view;

- (void)VCRtc:(VCRtcModule *)module didDisconnectedWithReason:(NSError *)reason;
- (void)VCRtc:(VCRtcModule *)module didAddView:(VCVideoView *)view uuid:(NSString *)uuid;
- (void)VCRtc:(VCRtcModule *)module didRemoveView:(VCVideoView *)view uuid:(NSString *)uuid;
- (void)VCRtc:(VCRtcModule *)module didAddLocalView:(VCVideoView *)view;
- (void)VCRtc:(VCRtcModule *)module didAddParticipant:(Participant *)participant;
- (void)VCRtc:(VCRtcModule *)module didUpdateParticipant:(Participant *)participant;
- (void)VCRtc:(VCRtcModule *)module didRemoveParticipant:(Participant *)participant;
- (void)VCRtc:(VCRtcModule *)module didReceivedMessage:(NSDictionary *)message;
- (void)VCRtc:(VCRtcModule *)module didReceivedStageVoice:(NSArray *)voices;
- (void)VCRtc:(VCRtcModule *)module didReceivedStatistics:(NSArray<VCMediaStat *> *)mediaStats;

// by add li
- (void)VCRtc:(VCRtcModule *)module didLayoutParticipants:(NSArray *)participants;
- (void)VCRtc:(VCRtcModule *)module didStartImage:(NSString *)shareUuid;
- (void)VCRtc:(VCRtcModule *)module didUpdateImage:(NSString *)imageStr uuid:(NSString *)uuid;
- (void)VCRtc:(VCRtcModule *)module didUpdateVideo:(NSString *)imageStr uuid:(NSString *)uuid;
- (void)VCRtc:(VCRtcModule *)module didStopImage:(NSString *)imageStr;
- (void)VCRtc:(VCRtcModule *)module didUpdateRecordAndlive:(NSDictionary *)data;
- (void)VCRtc:(VCRtcModule *)module didUpdateLayout:(NSDictionary *)data ;
- (void)VCRtc:(VCRtcModule *)module didUpdateConferenceStatus:(NSDictionary *)data;
- (void)VCRtc:(VCRtcModule *)module didUpdateParticipants:(NSArray *)participants;

@end

@interface VCRtcModule : NSObject
@property(nonatomic, weak) id <VCRtcModuleDelegate> delegate;
@property(nonatomic, strong) NSString *apiServer;
@property(nonatomic, strong) NSString *groupId;
@property(nonatomic, assign) NSUInteger bandwidth; //  default: 1024kbps
@property(nonatomic, strong, readonly) NSString *uuid;
@property(nonatomic, strong, readonly) NSMutableDictionary<NSString *, Participant *> *rosterList;
@property(nonatomic, strong) NSString *oemId; // only shitong;
@property(nonatomic, assign) UIDeviceOrientation forceOrientation; // default none;
+ (instancetype)sharedInstance;

- (void)uploadLoggerWithName:(NSString *)name URLString:(NSString *)URLString;

- (void)enableStatistics:(BOOL)enable;

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
- (void)reconnect ;
- (void)reMakeMediaCall ;

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
@property(nonatomic, strong, readonly) NSString *role ; // 参会者身份
@property (nonatomic, assign, readonly) BOOL isSupportLive ;
@property (nonatomic, assign, readonly) BOOL isSupportRecord ;

// Config Before Connect
- (void)configConnectType:(VCConnectType )connectType ;
- (void)configVideoProfile:(VCVideoProfile )profile ;
- (void)configMultistream:(BOOL )multistream ;
- (void)configSelectMute:(BOOL )mute ;
- (void)configLoginAccount:(NSString *)account ;
- (void)configPrivateCloudPlatform:(BOOL )isPrivateCloud;
- (void)configPTPOneTimeToken:(NSString *)token andBsskey:(NSString *)bsskey andStamp:(NSString *)timeStamp ;

// Control Meeting metheds
- (void)lockMeeting:(BOOL )lock success:(successBlock)success failure:(failureBlock)failure ;
- (void)muteAllGuest:(BOOL )mute success:(successBlock)success failure:(failureBlock)failure ;
- (void)shareImageData:(NSData *)imageData open:(BOOL )open change:(BOOL )change success:(successBlock)success failure:(failureBlock)failure ;
- (void)updateLayoutHost:(NSString *)layout guest:(NSString *)glayout conferenceType:(VCConferenceType )type success:(successBlock)success failure:(failureBlock)failure ;

// Control Participant metheds
- (void)muteParticipant:(NSDictionary *)participant success:(successBlock)success failure:(failureBlock)failure ;
- (void)removeParticipant:(NSDictionary *)participant success:(successBlock)success failure:(failureBlock)failure;
- (void)changeNameParticipant:(NSDictionary *)participant withNewName:(NSString *)changedName success:(successBlock)success failure:(failureBlock)failure;
- (void)changeRoleParticipant:(NSDictionary *)participant success:(successBlock)success failure:(failureBlock)failure;
- (void)refusedToParticipant:(NSDictionary *)participant success:(successBlock)success failure:(failureBlock)failure;
- (void)allowParticipant:(NSDictionary *)participant success:(successBlock)success failure:(failureBlock)failure;
- (void)spolightParticipant:(NSDictionary *)participant success:(successBlock)success failure:(failureBlock)failure;
- (void)stickParticipant:(NSString *)participant onStick:(BOOL )stick success:(successBlock)success failure:(failureBlock)failure ;
- (void)stopRecordScreen ;

- (void)resetClayout:(NSString *)clayout ;
- (void)onlyAudioEnable:(BOOL)enabled  ;

@end

NS_ASSUME_NONNULL_END
