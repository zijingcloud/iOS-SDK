//
//  ZjMeetingManageModule.h
//  ZJRTC
//
//  Created by 李志朋 on 2018/11/30.
//  Copyright © 2018年 zijingcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJRtcEnumerates.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^successBlock)(id response);
typedef void(^failureBlock)(NSError *);

@class ZjMeetingManageModule ;

@protocol ZjMeetingManageModuleDelegate <NSObject>

@optional
- (void)ZJMeetingManage:(ZjMeetingManageModule *)module layoutChange:(NSDictionary *)data;
- (void)ZJMeetingManage:(ZjMeetingManageModule *)module conferenceChange:(NSDictionary *)data;
- (void)ZJMeetingManage:(ZjMeetingManageModule *)module recordAndlive:(NSDictionary *)data;
- (void)ZJMeetingManage:(ZjMeetingManageModule *)module tokenChange:(NSDictionary *)data;
- (void)ZJMeetingManage:(ZjMeetingManageModule *)module qualityChange:(NSDictionary *)data;
- (void)ZJMeetingManage:(ZjMeetingManageModule *)module updateParticipants:(NSArray *)participants ;

@end

@interface ZjMeetingManageModule : NSObject

@property (nonatomic, strong) id <ZjMeetingManageModuleDelegate> delegate ;

+ (instancetype )shareManageModule ;

- (void)lockMeetingSuccess:(successBlock)success
            conferenceLock:(BOOL )lock
                   failure:(failureBlock)failure ;

- (void)muteAllGuestSuccess:(successBlock)success
               muteAllGuest:(BOOL )mute
                    failure:(failureBlock)failure ;

- (void)muteParticipan:(NSDictionary *)participant
               success:(successBlock)success
               failure:(failureBlock)failure ;

- (void)undockParticipant:(NSDictionary *)participant
                  success:(successBlock)success
                  failure:(failureBlock)failure;

- (void)changeNameParticipant:(NSDictionary *)participant
                  withNewName:(NSString *)changedName
                      success:(successBlock)success
                      failure:(failureBlock)failure;

- (void)changeRoleParticipant:(NSDictionary *)participant
                      success:(successBlock)success
                      failure:(failureBlock)failure;

- (void)refusedToParticipant:(NSDictionary *)participant
                     success:(successBlock)success
                     failure:(failureBlock)failure;

- (void)allowParticipant:(NSDictionary *)participant
                 success:(successBlock)success
                 failure:(failureBlock)failure;

- (void)spolightParticipant:(NSDictionary *)participant
                    success:(successBlock)success
                    failure:(failureBlock)failure;

- (void)layoutChangeHost:(NSString *)layout
                   guest:(NSString *)glayout
          conferenceType:(ZJConferenceType )type
                 success:(successBlock)success
                 failure:(failureBlock)failure;

- (void)shareImage:(NSDictionary *)uriInfo
           success:(successBlock)success
           failure:(failureBlock)failure ;

@end

NS_ASSUME_NONNULL_END
