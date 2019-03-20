#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VCRtcErrorCode){
    VCRtcErrorCodeAudioRequestFailure = 1,
    VCRtcErrorCodeVideoRequestFailure = 2,
    VCRtcErrorCodeCheckJoinRequestFailure = 3,
    VCRtcErrorCodeDisconnect ,
    VCRtcErrorCodeSystemNotIdle ,
};

typedef NS_ENUM(NSUInteger, VCSystemState) {
    VCSystemStateIdle,
    VCSystemStateConnected
};

typedef NS_ENUM(NSUInteger, VCCallState) {
    VCCallStateIdle,
    VCCallStateConnected
};

typedef NS_ENUM(NSInteger, VCVideoProfile){
    VCVideoProfileNone = 0,
    VCVideoProfile480P,
    VCVideoProfile720P,
    VCVideoProfile360P,
    VCVideoProfile180P,
};

// by add li
typedef NS_ENUM(NSInteger, VCConnectType) {
    VCConnectTypeMeeting,
    VCConnectTypeUser,
    VCConnectTypeOnlyManager,
    VCConnectTypeHideMe
};

typedef NS_ENUM(NSUInteger, VCConferenceType) {
    VCConferenceTypeMeeting,
    VCConferenceTypeVmr
};
