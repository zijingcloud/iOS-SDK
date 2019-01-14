//
//  ViewController.m
//  Zj-Demo
//
//  Created by 李志朋 on 2019/1/14.
//  Copyright © 2019年 李志朋. All rights reserved.
//

#import "ViewController.h"
#import "ZJRTC.h"

@interface ViewController () <ZJRtcModuleDelegate>

@property (nonatomic, strong) ZJRtcModule *zjrtc;
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) ZJVideoView *localView;

@end

@implementation ViewController

- (BOOL)shouldAutorotate {
    return false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.views = [NSMutableArray new];
    
    self.zjrtc = [ZJRtcModule sharedInstance];
    self.zjrtc.apiServer = @"bss.lalonline.cn";
    self.zjrtc.delegate = self;
    self.zjrtc.bandwidth = 1024;
    self.zjrtc.oemId = @"default";
    self.zjrtc.groupId = @"group.com.zijingcloud.grouptest";
    [self.zjrtc loginWithUsername:@"username" password:@"123456" phone:@"1860001234" nickname:@"nickname" success:^(id response) {
        [self.zjrtc configConnectType:ZJConnectTypeMeeting
         ];
        [self.zjrtc configVideoProfile:ZJVideoProfile480P];
        [self.zjrtc configMultistream:YES];
        [self.zjrtc configLoginAccount:@"test_ios_demo@zijingcloud.com"];
        [self.zjrtc configUseDefultViewController:NO];
        [self.zjrtc configPTPOneTimeToken:@"" andBsskey:@"" andStamp:@""];
        [self.zjrtc connectChannel:@"1061" password:@"123456" name:@"test_ios_demo" success:^(id _Nonnull re) {
            
        } failure:^(NSError * _Nonnull er) {
            
        }];
    } failure:^(NSError *error) {
        
    }];
    self.zjrtc.videoUri = @[@"01FirstSet",@"02StartRecord"];
    [self addButtons];
}

- (void)ZJRtc:(ZJRtcModule *)module didAddChannelViewController:(ZJVideoView *)view {
    
}

- (void)ZJRtc:(ZJRtcModule *)module didDisconnectedWithReason:(NSError *)reason{
    
}
- (void)inviteTest
{
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:10 repeats:NO block:^(NSTimer *timer) {
            [self.zjrtc inviteDesitination:@"lizipeng@zijingclou.com" success:^(id response) {
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
            [self.zjrtc sendMessage:@"hello" success:^(id response) {
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
    [self addQuitZjrtcBtn];
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
    [self.zjrtc reMakeMediaCall];
}

- (void)reEnter{
    [self.zjrtc loginWithUsername:@"username" password:@"123456" phone:@"1860001234" nickname:@"nickname" success:^(id response) {
        [self.zjrtc connectChannel:@"1061" password:@"123456" name:@"ios-native" success:^(id o) {
        } failure:^(NSError *error) {
        }];
    } failure:^(NSError *error) {
    }];
}

- (void)videoEnable{
    static bool enable = false;
    [self.zjrtc videoEnable:enable];
    enable = !enable;
}

- (void)switchCamera{
    [self.zjrtc switchCamera];
}

- (void)audioEnable{
    static bool enable = false;
    [self.zjrtc micEnable:enable];
    enable = !enable;
}

- (void)addQuitZjrtcBtn{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"退出" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = CGPointMake(320,50);
    [button addTarget:self action:@selector(quitZjrtc) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)quitZjrtc{
    for(UIView *view in self.views){
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    [self.localView removeFromSuperview];
    [self.zjrtc exitChannelSuccess:^(id o) {
        NSLog(@"[zjrtc] end session successful");
    } failure:^(NSError *error) {
        NSLog(@"[zjrtc] end session failure");
    }];
}

- (void)ZJRtc:(ZJRtcModule *)module didAddView:(ZJVideoView *)view uuid:(NSString *)uuid {
    static int i = 0;
    i++;
    //    [self.view insertSubview:view atIndex:1];
    [self.view addSubview:view];
    [self.views addObject:view];
    [self relayoutViews];
}

- (void)ZJRtc:(ZJRtcModule *)module didRemoveView:(ZJVideoView *)view uuid:(NSString *)uuid {
    [view removeFromSuperview];
    [self.views removeObject:view];
    [self relayoutViews];
    NSLog(@"uuid %@ removed view=%@", uuid, view);
}

- (void)ZJRtc:(ZJRtcModule *)module didAddLocalView:(ZJVideoView *)view{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    [view setFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    self.localView = view;
    self.localView.objectFit = ZJVideoViewObjectFitCover;
    [self.view insertSubview:view atIndex:0];
}

- (void)relayoutViews{
    int i = 0;
    
    NSLog(@"[layout]: begin");
    for(ZJVideoView *view in self.views){
        CGRect p = CGRectMake(20, 30 +  180 * i, 180, 180);
        view.objectFit = ZJVideoViewObjectFitCover;
        [view setFrame:p];
        NSLog(@"[layout]: view %d: %@", i, NSStringFromCGRect(p));
        i++;
    }
    NSLog(@"[layout]: end");
}

- (void)ZJRtc:(ZJRtcModule *)module didAddParticipant:(Participant *)participant;{
    //   NSLog(@"participant %@", participant);
}
- (void)ZJRtc:(ZJRtcModule *)module didUpdateParticipant:(Participant *)participant;{
    //    NSLog(@"participant %@", participant);
    
}
- (void)ZJRtc:(ZJRtcModule *)module didRemoveParticipant:(Participant *)participant;{
    
    //    NSLog(@"participant %@", participant);
}

- (void)ZJRtc:(ZJRtcModule *)module didReceivedStatistics:(NSArray<ZJMediaStat *> *)mediaStats;{
    //    NSLog(@"[Statistics] %@", mediaStats);
}

@end
