//
//  ZJSDKTypeDefine.h
//  iosRN
//
//  Created by 李志朋 on 2018/1/15.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#ifndef ZJSDKTypeDefine_h
#define ZJSDKTypeDefine_h

typedef NS_ENUM (NSUInteger, ZJSDKCallState){
  ZjCallConnected    =  0,         /** < 视屏通话建立连接成功 > **/
  ZjCallError        =  1,         /** < 视频通话建立过程中出现的错误 > **/
  ZjCallEnd          =  2,         /** < 视频通话结束 > **/
  ZjCallStateMute    =  3,         /** < 视频被静音 >  **/
  ZjCallHappenError  =  4,         /** < 视频通话过程中出现的错误 > **/
  ZjCallObtainUUID   =  5          /** < 第一次获得uuid > **/
};

typedef struct ZJVideoSize {
  NSInteger videoWidth;    /** < 视频分辨率宽 > **/
  NSInteger videoHeight;   /** < 视频分辨率高 > **/
} ZJVideoSize;

/** 参数按< 下载带宽 上传带宽 下载分辨率 上传分辨率 >设置 **/
typedef NS_ENUM(NSInteger, ZJVideoParamState){
  ZJVideoParam_720P = 0, /** < 1280 1280 1280x720 1280x720 > **/
  ZJVideoParam_576P = 1, /** < 1024 1024 1024x576 1024x576 > **/
  ZJVideoParam_448P = 2, /** < 768 768 768x448 768x448 > **/
  ZJVideoParam_VGA  = 3, /** < 640 640 640x360 640x360 > **/
};

typedef void(^ZJVideoSDKCompletionHandler) (NSData *  data,NSURLResponse *  response,NSError *  error);

#endif /* ZJSDKTypeDefine_h */
