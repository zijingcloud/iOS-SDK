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
  ZjCallHappenError  =  4          /** < 视频通话过程中出现的错误 > **/
};

typedef struct ZJVideoSize {
  NSInteger videoWidth;    /** < 视频分辨率宽 > **/
  NSInteger videoHeight;   /** < 视频分辨率高 > **/
} ZJVideoSize;

#define ZJ_VIDEO_SIZE_720P (ZJVideoSize) {1280,720}
#define ZJ_VIDEO_SIZE_576P (ZJVideoSize) {1024,576}
#define ZJ_VIDEO_SIZE_448P (ZJVideoSize) {768,448}
#define ZJ_VIDEO_SIZE_VGA  (ZJVideoSize) {640,360}


#define MS_VIDEO_SIZE_ASSIGN(vsize,name) \
      vsize=MS_VIDEO_SIZE_##name

typedef void(^ZJVideoSDKCompletionHandler) (NSData *  data,NSURLResponse *  response,NSError *  error);

#endif /* ZJSDKTypeDefine_h */
