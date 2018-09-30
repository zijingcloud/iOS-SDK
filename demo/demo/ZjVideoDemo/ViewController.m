//
//  ViewController.m
//  ZjVideoDemo
//
//  Created by 李志朋 on 2017/8/31.
//  Copyright © 2017年 李志朋. All rights reserved.
//

#import "ViewController.h"
#import "ZJVideoManager.h"
#import "VideoViewController.h"

@interface ViewController ()<ZJVideoManagerDelegate> {
    VideoViewController *videoVC;
}
@property (weak, nonatomic) IBOutlet UITextField *API;
@property (weak, nonatomic) IBOutlet UITextField *DisplayName;
@property (weak, nonatomic) IBOutlet UITextField *NumberTf;
@property (weak, nonatomic) IBOutlet UITextField *PwdTf;
@property (weak, nonatomic) IBOutlet UITextField *inputTf;
@property (weak, nonatomic) IBOutlet UITextField *outputTf;
@property (weak, nonatomic) IBOutlet UITextField *minWidthTf;
@property (weak, nonatomic) IBOutlet UITextField *minHeightTf;
@property (weak, nonatomic) IBOutlet UITextField *exWidthTf;
@property (weak, nonatomic) IBOutlet UITextField *exHeightTf;
@property (nonatomic, strong) ZJVideoManager *manager;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)JoinConference:(id)sender {
    struct ZJVideoSize minSize = {[self.minWidthTf.text integerValue],[self.minHeightTf.text integerValue]};
    struct ZJVideoSize expectedSize = {[self.exWidthTf.text integerValue],[self.exHeightTf.text integerValue]};
    self.manager = [ZJVideoManager shareIntance];
    self.manager.delegate = self;
    [self.manager setApiServer:@"vapi.myvmr.cn"];
    NSMutableDictionary *conferenceModel = [NSMutableDictionary dictionary];
    [conferenceModel ZJSDKVideoJoinConferenceWithTarget:self.NumberTf.text
                                            displayName:self.DisplayName.text
                                               password:self.PwdTf.text];
    
    NSLog(@"入会参数： -- %@",conferenceModel);
    NSMutableDictionary *videoParams = [NSMutableDictionary dictionary];
    
    [videoParams ZJSDKVideoParamWithMinBandWidth:[self.inputTf.text integerValue]
                               expectedBandwidth:[self.outputTf.text integerValue]
                                          minFps:20
                                     expectedFps:20
                                       videoSize:minSize
                                    expectedSize:expectedSize];
    NSLog(@"视频参数： -- %@",videoParams);
    
    [self.manager connectWithModel:conferenceModel
                       videoParams:videoParams
                  showFunctionItem:YES
                isAutoPrePresentVC:YES];
    
//    [self.manager connectTarget:self.NumberTf.text
//                         name:self.DisplayName.text
//                     password:self.PwdTf.text
//                    apiServer:self.API.text
//                  bandwidthIn:[self.inputTf.text integerValue]
//                 bandwidthOut:[self.outputTf.text integerValue]
//                       minFps:20
//                  expectedFps:20
//                    videoSize:minSize
//                 expectedSize:expectedSize
//             showFunctionItem:YES
//           isAutoPrepresentVC:YES];
}

- (IBAction)JoinWithCustom:(id)sender {
    struct ZJVideoSize minSize = {[self.minWidthTf.text integerValue],[self.minHeightTf.text integerValue]};
    struct ZJVideoSize expectedSize = {[self.exWidthTf.text integerValue],[self.exHeightTf.text integerValue]};
    self.manager = [ZJVideoManager shareIntance];
    self.manager.delegate = self;
    
    NSMutableDictionary *conferenceModel = [NSMutableDictionary dictionary];
    [conferenceModel ZJSDKVideoJoinConferenceWithTarget:self.NumberTf.text
                                            displayName:self.DisplayName.text
                                               password:self.PwdTf.text];
    NSLog(@"入会参数： -- %@",conferenceModel);
    NSMutableDictionary *videoParams = [NSMutableDictionary dictionary];
    
    [videoParams ZJSDKVideoParamWithMinBandWidth:[self.inputTf.text integerValue]
                               expectedBandwidth:[self.outputTf.text integerValue]
                                          minFps:20
                                     expectedFps:20
                                       videoSize:minSize
                                    expectedSize:expectedSize];
    NSLog(@"视频参数： -- %@",videoParams);
    
    [self.manager connectWithModel:conferenceModel
                       videoParams:videoParams
                  showFunctionItem:YES
                isAutoPrePresentVC:NO];
    
//    [self.manager connectTarget:self.NumberTf.text
//                          name:self.DisplayName.text
//                      password:self.PwdTf.text
//                     apiServer:self.API.text
//                   bandwidthIn:[self.inputTf.text integerValue]
//                  bandwidthOut:[self.outputTf.text integerValue]
//                        minFps:20
//                   expectedFps:20
//                     videoSize:minSize
//                  expectedSize:expectedSize
//              showFunctionItem:YES
//            isAutoPrepresentVC:NO];
  
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [self.manager.conferenceView addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    videoVC = [[VideoViewController alloc]init];
    videoVC.view = self.manager.conferenceView;
    
    [self presentViewController:videoVC animated:NO completion:nil];
}

-(void)click{
    [self.manager endAllMeeting];
}


-(void)EndedMeeting:(NSNotification *)sender{
    // 监听退出会议室
    if (videoVC != nil) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [videoVC dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

-(void)zjLogPercentageLost:(NSDictionary *)packet{
    NSDictionary *objectInfor = packet;
    NSLog(@"接受audio丢包率:%@,接受video丢包率:%@,发送audio丢包率:%@,发送video丢包率:%@",objectInfor[@"incomingAudioPL"],objectInfor[@"incomingAudioPL"],objectInfor[@"outgoingVideoPL"],objectInfor[@"outgoingVideoPL"]);
}

-(void)zjCallBackWithState:(ZJSDKCallState)state withReason:(NSString *)reason withUUID:(NSString *)uuid{
    [self CallBackCurrentCallState:state withReason:reason withUUID:uuid];
}

-(void)CallBackCurrentCallState:(ZJSDKCallState)state withReason:(NSString *)reason withUUID:(NSString *)uuid{
    NSLog(@"监听到当前状态为:%lu,发生此状态的原因:%@,参会者的uuid:%@",state,reason,uuid);
}

-(void)zjOutofConference{
    // 监听退出会议室
    if (videoVC != nil) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [videoVC dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

-(void)zjCallFalidMessage:(NSString *)reason{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
