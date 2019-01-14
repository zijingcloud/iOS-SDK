#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZjRtcErrorCode){
    ZjRtcErrorCodeAudioRequestFailure = 1,
    ZjRtcErrorCodeVideoRequestFailure = 2,
    ZjRtcErrorCodeCheckJoinRequestFailure = 3,
    ZjRtcErrorCodeDisconnect ,
    ZjRtcErrorCodeSystemNotIdle ,
};

typedef NS_ENUM(NSUInteger, ZJSystemState) {
    ZJSystemStateIdle,
    ZJSystemStateConnected
};

typedef NS_ENUM(NSUInteger, ZJCallState) {
    ZJCallStateIdle,
    ZJCallStateConnected
};

typedef NS_ENUM(NSInteger, ZJVideoProfile){
    ZJVideoProfileNone = 0,
    ZJVideoProfile480P,
    ZJVideoProfile720P,
    ZJVideoProfile360P,
    ZJVideoProfile180P,
};

// by add li
typedef NS_ENUM(NSInteger, ZJConnectType) {
    ZJConnectTypeMeeting,
    ZJConnectTypeUser,
    ZJConnectTypeOnlyManager,
    ZJConnectTypeHideMe
};

typedef NS_ENUM(NSUInteger, ZJConferenceType) {
    ZJConferenceTypeMeeting,
    ZJConferenceTypeVmr
};
