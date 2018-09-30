//
//  NSMutableDictionary+ZJSDKVideo.h
//  ZjVideo
//
//  Created by 李志朋 on 2018/1/15.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJSDKTypeDefine.h"

@interface NSMutableDictionary (ZJSDKVideo)


/**
 *  加入会议的时候需要的参数  快速入会 （必须赋值的参数）
 *  @param target      : 入会长地址／短号
 *  @param displayName : 入会显示名称
 *  @param pwd         : 入会密码，对应身份输入相应的的密码
 */
- (void)ZJSDKVideoJoinConferenceWithTarget:(NSString *)target
                               displayName:(NSString *)displayName
                                  password:(NSString *)pwd;

/**
 *  加入会议的时候需要的参数 可改变入会方式 （必须赋值的参数）
 *  @param target      : 入会长地址／短号
 *  @param displayName : 入会显示名称
 *  @param pwd         : 入会密码，对应身份输入相应的的密码
 *  @param videoType   : 入会方式
 */
- (void)ZJSDKVideoJoinConferenceWithTarget:(NSString *)target
                               displayName:(NSString *)displayName
                                  password:(NSString *)pwd
                                 videoType:(ZJVideoType )type;


/**
 *  接受被邀请时/被呼叫时，加入会议/接通点对点需要的参数（必须赋值的参数）
 *  @param target      : 入会长地址／短号
 *  @param displayName : 入会显示名称
 *  @param token       : 入会token，一般入会token为访客
 *  @param timestamp   : 入会时间验证
 *  @param secretKey   : 入会安全验证
 */
- (void)ZJSDKVideoJoinConferenceWithTarget:(NSString *)target
                              displayName:(NSString *)displayName
                                     token:(NSString *)token
                                 timestamp:(NSString *)timestamp
                                 secretKey:(NSString *)secretKey;



/**
 *  会中通话音视频参数（可选赋值的参数）
 *  @param state       :  预先设置的标准参数状态
 */
- (void)ZJSDKZJSDKVideoParamState:(ZJVideoParamState)state;

/**
 *  会中通话音视频参数（可选赋值的参数）
 *  @param minBandWidth       :  上传速率
 *  @param expectedBandWidth  :  下载速率
 *  @param minFps             :  上传帧率
 *  @param expectedFps        :  下载帧率
 *  @param videoSize          :  上传分辨率
 *  @param expectedSize       :  下载分辨率
 */
- (void)ZJSDKVideoParamWithMinBandWidth:(NSInteger )minBandWidth
                      expectedBandwidth:(NSInteger )expectedBandWidth
                                 minFps:(NSInteger )minFps
                            expectedFps:(NSInteger )expectedFps
                              videoSize:(struct ZJVideoSize )videoSize
                           expectedSize:(struct ZJVideoSize )expectedSize;


@end
