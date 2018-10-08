//
//  ZJManager.h
//  ZjVideo
//
//  Created by 李志朋 on 2018/1/4.
//  Copyright © 2018年 Facebook. All rights reserved.
//   V  2.0.1 
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSMutableDictionary+ZJSDKVideo.h"

@protocol ZJVideoManagerDelegate <NSObject>

/**
 *  实现功能 : 退出会议室监听
 */
- (void)zjOutofConference;

/**
 *  实现功能 : 会中音视频的丢包率监听
 *  @param packet : 音视频的上下行丢包率信息
 */
- (void)zjLogPercentageLost:(NSDictionary *)packet;

/**
 *  实现功能 : 通话过程中状态监听
 *  @param state  : 返回通话状态
 *  @param reason : 发生当前状态的原因
 *  @param uuid   : 当前与会者的uuid
 */
- (void)zjCallBackWithState:(ZJSDKCallState )state
               withReason:(NSString *)reason
                 withUUID:(NSString *)uuid;

/**
 *  实现功能 : 呼叫失败返回
 */
- (void)zjCallFalidMessage:(NSString *)reason;

@end

@interface ZJVideoManager : NSObject

@property(nonatomic,weak)id <ZJVideoManagerDelegate> delegate;
@property(nonatomic,strong) UIView *conferenceView;
@property(nonatomic, copy) NSString *cartificateName;
@property(nonatomic, copy) NSString *voipToken;
@property(nonatomic, copy) NSString *apiServer;

/**
 *  实现功能 : 单例
 */
+ (instancetype)shareIntance;

/**
 *  实现功能 : 私有云用户注册Api、Mcu等地址信息
 *  @param apiServer :  私有云Api地址
 *  @retrun : 是否注册成功
 */
- (void)setApiServer:(NSString *)apiServer;

/**
 *  实现功能 : 设置Voip Push Cartificate Name (推送服务证书名称)
 */
- (void)setCartificateName:(NSString *)cartificateName;

/**
 *  实现功能 : 设置app对应设备中的voiptoken
 */
- (void)setVoipToken:(NSString *)voipToken;

/**
 *  注册账号到mcu
 *  @param account           : 注册的用户账号
 *  @param pwd               : 注册的用户密码
 *  @param completionHandler : 注册回调
 */
- (void)registerAccount:(NSString *)account
           withPassword:(NSString *)pwd
      completionHandler:(ZJVideoSDKCompletionHandler)completionHandler;

/**
 *  加入会议
 *  @param conferenceModel  : 加入会议的参数设置（必填参数，密码为空时，可传空字符串）
 *  @param isShow           : 是否显示功能按钮（静音，静画，切换摄像头等）
 *  @param isAuto           : 是否自动跳转到控制器
 */
- (void)connectWithModel:(NSDictionary *)conferenceModel
        showFunctionItem:(BOOL)isShow
      isAutoPrePresentVC:(BOOL)isAuto;

/**
 *  加入会议
 *  @param conferenceModel  : 加入会议的参数设置（必填参数，密码为空时，可传空字符串）
 *  @param params           : 通话质量的参数设置（非必填参数，传空字典类型，使用默认值）
 *  @param isShow           : 是否显示功能按钮（静音，静画，切换摄像头等）
 *  @param isAuto           : 是否自动跳转到控制器
 */
- (void)connectWithModel:(NSDictionary *)conferenceModel
             videoParams:(NSDictionary *)params
        showFunctionItem:(BOOL)isShow
      isAutoPrePresentVC:(BOOL)isAuto;

/**
 *  拒绝当前通话
 *  @param account           : 主叫的用户账号
 *  @param token             : 接口地址
 *  @param completionHandler : 拒接回调
 */
- (void)callRejectWithAccount:(NSString *)account
                    withToken:(NSString *)token
            completionHandler:(ZJVideoSDKCompletionHandler)completionHandler;

/**
 *  实现功能 : 切换本端音频
 *  静音本地，远端收不到本端音频。
 */
- (void)toggleLocalAudio;

/**
 *  实现功能 : 切换本端视频
 *  关闭显示本地视频，但远端仍然能接受到视频。
 */
- (void)toggleLocalVideo;

/**
 *  实现功能 : 开启／关闭本端视频
 *  关闭显示本地视频，且远端不能接受到视频。
 */
- (void)toggleVideo;

/**
 *  实现功能 : 切换摄像头
 */
- (void)toggleCamera;

/**
 *  实现功能 : 退出当前会议室
 */
- (void)outOfCurrentMeeting;

/**
 *  实现功能 : 结束当前会议
 */
- (void)endAllMeeting;

/**
 *  实现功能 : 邀请参会者入会
 *  param account 用户账号
 *  param role 入会身份
 *  param protocol 入会协议
 */

- (void)inviteUserAccount:(NSString *)account
                 withRole:(InviteParticipantRole )role
             withProtocol:(InviteParticipantProtocol )protocol;

/**
 *  Deprecated
 *  加入会议室
 *  @param target        : 会议室的短号或者长地址
 *  @param name          : 入会显示名称
 *  @param pwd           : 入会密码
 *  @param server        : 接口地址
 *  @param input         : 接受速率
 *  @param output        : 发送速率
 *  @param minFps        : 发送帧率
 *  @param expectedFps   : 接受帧率
 *  @param videoSize     : 发送分辨率
 *  @param expectedSize  : 接受分辨率
 *  @param isShow        : 是否显示功能按钮（静音，静画，切换摄像头等）
 *  @param isAuto        : 是否自动跳转到控制器
 */
- (void)connectTarget:(NSString *)target
                 name:(NSString *)name
             password:(NSString *)pwd
            apiServer:(NSString *)server
          bandwidthIn:(NSInteger )input
         bandwidthOut:(NSInteger )output
               minFps:(NSInteger)minFps
          expectedFps:(NSInteger)expectedFps
            videoSize:(struct ZJVideoSize)videoSize
         expectedSize:(struct ZJVideoSize)expectedSize
     showFunctionItem:(BOOL )isShow
   isAutoPrepresentVC:(BOOL )isAuto;

@end


