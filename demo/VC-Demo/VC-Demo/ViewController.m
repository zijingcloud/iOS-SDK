//
//  ViewController.m
//  VC-Demo
//
//  Created by 李志朋 on 2019/3/20.
//  Copyright © 2019年 李志朋. All rights reserved.
//

#import "ViewController.h"
#import "VCRTC.h"

@interface ViewController () <VCRtcModuleDelegate>

@property (nonatomic, strong) VCRtcModule *vcrtc;
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) VCVideoView *localView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.views = [NSMutableArray new];
    
    self.vcrtc = [VCRtcModule sharedInstance];
    self.vcrtc.apiServer = @"bss.lalonline.cn";
    self.vcrtc.delegate = self;
    self.vcrtc.bandwidth = 1024;
    self.vcrtc.oemId = @"default";
    self.vcrtc.groupId = @"group.com.zijingcloud.grouptest";
    [self.vcrtc loginWithUsername:@"" password:@"" phone:@"" nickname:@"" success:^(id  _Nonnull response) {
        [self.vcrtc configConnectType:VCConnectTypeMeeting
         ];
        [self.vcrtc configVideoProfile:VCVideoProfile480P];
        [self.vcrtc configMultistream:YES];
        [self.vcrtc configLoginAccount:@"test_ios_demo@zijingcloud.com"];
        [self.vcrtc configPTPOneTimeToken:@"" andBsskey:@"" andStamp:@""];
        [self.vcrtc connectChannel:@"2207" password:@"123456" name:@"test_ios_demo" success:^(id _Nonnull re) {
            
        } failure:^(NSError * _Nonnull er) {
            NSLog(@"--%@",er);
        }];
    } failure:^(NSError * _Nonnull er) {
        
    }];
    [self addButtons];
}

- (void)VCRtc:(VCRtcModule *)module didAddChannelViewController:(VCVideoView *)view {
    
}

- (void)VCRtc:(VCRtcModule *)module didDisconnectedWithReason:(NSError *)reason{
    
}

- (void)inviteTest
{
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:10 repeats:NO block:^(NSTimer *timer) {
            [self.vcrtc inviteDesitination:@"lizipeng@zijingclou.com" success:^(id response) {
                NSLog(@"response %@", response);
            } failure:^(NSError *error) {
                NSLog(@"error %@", error);
            }];
            
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)sendMessage{
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
            [self.vcrtc sendMessage:@"hello" success:^(id response) {
                NSLog(@"response %@",response);
            } failure:^(NSError *error) {
                NSLog(@"error %@", [error localizedDescription]);
            }];
            
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)addButtons{
    [self addQuitVCrtcBtn];
    UIButton *bAudio = [UIButton buttonWithType:UIButtonTypeSystem];
    [bAudio setTitle:@"静音" forState:UIControlStateNormal];
    [bAudio sizeToFit];
    bAudio.center = CGPointMake(320, 90);
    [self.view addSubview:bAudio];
    [bAudio addTarget:self
               action:@selector(audioEnable)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bVideo = [UIButton buttonWithType:UIButtonTypeSystem];
    [bVideo setTitle:@"静画" forState:UIControlStateNormal];
    [bVideo sizeToFit];
    bVideo.center = CGPointMake(320, 140);
    [self.view addSubview:bVideo];
    [bVideo addTarget:self
               action:@selector(videoEnable)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bCamera = [UIButton buttonWithType:UIButtonTypeSystem];
    [bCamera setTitle:@"切换摄像头" forState:UIControlStateNormal];
    [bCamera sizeToFit];
    bCamera.center = CGPointMake(320, 190);
    [self.view addSubview:bCamera];
    [bCamera addTarget:self
                action:@selector(switchCamera)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *bEnter = [UIButton buttonWithType:UIButtonTypeSystem];
    [bEnter setTitle:@"再入会" forState:UIControlStateNormal];
    [bEnter sizeToFit];
    bEnter.center = CGPointMake(320, 240);
    [self.view addSubview:bEnter];
    [bEnter addTarget:self
               action:@selector(reEnter)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bReconnect = [UIButton buttonWithType:UIButtonTypeSystem];
    [bReconnect setTitle:@"在线重连" forState:UIControlStateNormal];
    [bReconnect sizeToFit];
    bReconnect.center = CGPointMake(320, 290);
    [self.view addSubview:bReconnect];
    [bReconnect addTarget:self
                   action:@selector(reconnect)
         forControlEvents:UIControlEventTouchUpInside];
}

- (void)reconnect{
    [self.vcrtc reMakeMediaCall];
}

- (void)reEnter{
    [self.vcrtc loginWithUsername:@"username" password:@"123456" phone:@"1860001234" nickname:@"nickname" success:^(id response) {
        [self.vcrtc connectChannel:@"1061" password:@"123456" name:@"ios-native" success:^(id o) {
        } failure:^(NSError *error) {
        }];
    } failure:^(NSError *error) {
    }];
}

- (void)videoEnable{
    static bool enable = false;
    [self.vcrtc videoEnable:enable];
    enable = !enable;
}

- (void)switchCamera{
    [self.vcrtc switchCamera];
}

- (void)audioEnable{
    static bool enable = false;
    [self.vcrtc micEnable:enable];
    enable = !enable;
}

- (void)addQuitVCrtcBtn{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"退出" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(320,50);
    [button addTarget:self action:@selector(quitVCrtc) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)quitVCrtc{
    for(UIView *view in self.views){
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    [self.localView removeFromSuperview];
    [self.vcrtc exitChannelSuccess:^(id o) {
        NSLog(@"[VCrtc] end session successful");
    } failure:^(NSError *error) {
        NSLog(@"[VCrtc] end session failure");
    }];
}

- (void)VCRtc:(VCRtcModule *)module didAddView:(VCVideoView *)view uuid:(NSString *)uuid {
    static int i = 0;
    i++;
    //    [self.view insertSubview:view atIndex:1];
    [self.view addSubview:view];
    [self.views addObject:view];
    [self relayoutViews];
}

- (void)VCRtc:(VCRtcModule *)module didRemoveView:(VCVideoView *)view uuid:(NSString *)uuid {
    [view removeFromSuperview];
    [self.views removeObject:view];
    [self relayoutViews];
    NSLog(@"uuid %@ removed view=%@", uuid, view);
}

- (void)VCRtc:(VCRtcModule *)module didAddLocalView:(VCVideoView *)view{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    [view setFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    self.localView = view;
    self.localView.objectFit = VCVideoViewObjectFitCover;
    [self.view insertSubview:view atIndex:0];
}

- (void)relayoutViews{
    int i = 0;
    
    NSLog(@"[layout]: begin");
    for(VCVideoView *view in self.views){
        CGRect p = CGRectMake(20, 30 +  180 * i, 180, 180);
        view.objectFit = VCVideoViewObjectFitCover;
        [view setFrame:p];
        NSLog(@"[layout]: view %d: %@", i, NSStringFromCGRect(p));
        i++;
    }
    NSLog(@"[layout]: end");
}

- (void)VCRtc:(VCRtcModule *)module didAddParticipant:(Participant *)participant;{
    //   NSLog(@"participant %@", participant);
}
- (void)VCRtc:(VCRtcModule *)module didUpdateParticipant:(Participant *)participant;{
    //    NSLog(@"participant %@", participant);
    
}
- (void)VCRtc:(VCRtcModule *)module didRemoveParticipant:(Participant *)participant;{
    
    //    NSLog(@"participant %@", participant);
}

- (void)VCRtc:(VCRtcModule *)module didReceivedStatistics:(NSArray<VCMediaStat *> *)mediaStats;{
    //    NSLog(@"[Statistics] %@", mediaStats);
}
@end
