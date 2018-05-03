//
//  JoinViewController.m
//  ZjVideoDemo
//
//  Created by 李志朋 on 2018/1/30.
//  Copyright © 2018年 李志朋. All rights reserved.
//

#import "JoinViewController.h"
#import "ZJVideoManager.h"
#import "VideoViewController.h"
#import "SizeSettingViewController.h"


@interface JoinViewController ()<ZJVideoManagerDelegate>{
    VideoViewController *videoVC;
}
@property (weak, nonatomic) IBOutlet UITextField *sipkeyTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UITextField *apiServerTf;
@property (weak, nonatomic) IBOutlet UITextField *displayNameTf;
@property (weak, nonatomic) IBOutlet UISwitch *isVideo;
@property (weak, nonatomic) IBOutlet UITextField *inBandTf;
@property (weak, nonatomic) IBOutlet UITextField *outBandtf;
@property (weak, nonatomic) IBOutlet UITextField *minWidth;
@property (weak, nonatomic) IBOutlet UITextField *minHeightTf;
@property (weak, nonatomic) IBOutlet UITextField *expectedWidth;
@property (weak, nonatomic) IBOutlet UITextField *expectedHeight;
@property (nonatomic, strong) ZJVideoManager *manager;

@end

@implementation JoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [ZJVideoManager shareIntance];
    self.manager.delegate = self;
    
//    self.navigationItem.title = @"呼叫";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分辨率" style:UIBarButtonItemStyleDone target:self action:@selector(clickRight)];
    
}

-(void)clickRight{
    SizeSettingViewController *vc = [[SizeSettingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_sipkeyTf resignFirstResponder];
    [_passwordTf resignFirstResponder];
    [_apiServerTf resignFirstResponder];
    [_displayNameTf resignFirstResponder];
}

//通过提供的方式入会
- (IBAction)clickJoinDefault:(id)sender {
    
    
    NSMutableDictionary *conferenceModel = [NSMutableDictionary dictionary];
    [conferenceModel ZJSDKVideoJoinConferenceWithTarget:self.sipkeyTf.text
                                            displayName:self.displayNameTf.text
                                               password:self.passwordTf.text
                                              videoType:self.isVideo.on ? ZJVideoTypeWithHideMe:
                                                  ZJVideoTypeWithVideo];
    NSLog(@"入会参数： -- %@",conferenceModel);
    
    NSMutableDictionary *videoParams = [NSMutableDictionary dictionary];
    struct ZJVideoSize minSize = {[self.minWidth.text integerValue],[self.minHeightTf.text integerValue]};
    struct ZJVideoSize expectedSize = {[self.expectedWidth.text integerValue],[self.expectedHeight.text integerValue]};
    
    [self.manager setApiServer:self.apiServerTf.text];
    
    [videoParams ZJSDKVideoParamWithMinBandWidth:[self.inBandTf.text integerValue]
                               expectedBandwidth:[self.outBandtf.text integerValue]
                                          minFps:20
                                     expectedFps:20
                                       videoSize:minSize
                                    expectedSize:expectedSize];
    NSLog(@"视频参数： -- %@",videoParams);
    
    [self.manager connectWithModel:conferenceModel
                       videoParams:videoParams
                  showFunctionItem:YES
                isAutoPrePresentVC:YES];
}


//通过自定义的方式入会
- (IBAction)clickJoinCostum:(id)sender {
    struct ZJVideoSize minSize = {[self.minWidth.text integerValue],[self.minHeightTf.text integerValue]};
    struct ZJVideoSize expectedSize = {[self.expectedWidth.text integerValue],[self.expectedHeight.text integerValue]};
    
    [self.manager setApiServer:self.apiServerTf.text];
    
    NSMutableDictionary *conferenceModel = [NSMutableDictionary dictionary];
    [conferenceModel ZJSDKVideoJoinConferenceWithTarget:self.sipkeyTf.text
                                            displayName:self.displayNameTf.text
                                               password:self.passwordTf.text
                                            videoType:self.isVideo.isOn == YES ? ZJVideoTypeWithHideMe : ZJVideoTypeWithVideo];
    
    NSMutableDictionary *videoParams = [NSMutableDictionary dictionary];
    [videoParams ZJSDKVideoParamWithMinBandWidth:[self.inBandTf.text integerValue]
                               expectedBandwidth:[self.outBandtf.text integerValue]
                                          minFps:20
                                     expectedFps:20
                                       videoSize:minSize
                                    expectedSize:expectedSize];
    NSLog(@"视频参数： -- %@",videoParams);
    
    [self.manager connectWithModel:conferenceModel
                       videoParams:videoParams
                  showFunctionItem:NO
                isAutoPrePresentVC:YES];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [testBtn setTitle:@"点击测试接口" forState:UIControlStateNormal];
    testBtn.frame = CGRectMake(0 , 0, 100, 40);
    testBtn.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    [self.manager.conferenceView addSubview:testBtn];
    [testBtn addTarget:self action:@selector(clickTest) forControlEvents:UIControlEventTouchUpInside];
    
//    videoVC = [[VideoViewController alloc]init];
//    videoVC.view = self.manager.conferenceView;
    
//    [self presentViewCont roller:videoVC animated:NO completion:nil];
}

- (void)clickTest{
    //退出当前会议
    [self.manager outOfCurrentMeeting];
    //结束会议，断开所有与会者
//    [self.manager endAllMeeting];
    //切换静音（远端收不到本端音频，但本端依然收到音频）
//    [self.manager toggleLocalAudio];
    //切换静画（远端收不到本端视频）
//    [self.manager toggleVideo];
    //切换本地静画（远端能够收到本端视频）
//    [self.manager toggleCamera];
}

#pragma mark - ZJVideoManagerDelegate 的方法

-(void)zjOutofConference{
    // 监听退出会议室
    if (videoVC != nil) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [videoVC dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

-(void)zjCallFalidMessage:(NSString *)reason{
//    NSLog(@"发生配置错误，错误的原因是:%@",reason);
}

-(void)zjLogPercentageLost:(NSDictionary *)packet{
    NSDictionary *objectInfor = packet;
    NSLog(@"接受audio丢包率:%@,接受video丢包率:%@,发送audio丢包率:%@,发送video丢包率:%@",objectInfor[@"incomingAudioPL"],
          objectInfor[@"incomingAudioPL"],
          objectInfor[@"outgoingVideoPL"],
          objectInfor[@"outgoingVideoPL"]);
}

-(void)zjCallBackWithState:(ZJSDKCallState)state
                withReason:(NSString *)reason
                  withUUID:(NSString *)uuid{
//    NSLog(@"监听到当前状态为:%lu,发生此状态的原因:%@,参会者的uuid:%@",state,reason,uuid);
}

@end
