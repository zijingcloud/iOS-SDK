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


@interface JoinViewController ()<ZJVideoManagerDelegate>{
    VideoViewController *videoVC;
}
@property (weak, nonatomic) IBOutlet UITextField *sipkeyTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UITextField *apiServerTf;
@property (weak, nonatomic) IBOutlet UITextField *displayNameTf;
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
    [self.manager setApiServer:self.apiServerTf.text];
}
- (IBAction)clickJoinDefault:(id)sender {
    struct ZJVideoSize minSize = {[self.minWidth.text integerValue],[self.minHeightTf.text integerValue]};
    struct ZJVideoSize expectedSize = {[self.expectedWidth.text integerValue],[self.expectedHeight.text integerValue]};
    
    NSMutableDictionary *conferenceModel = [NSMutableDictionary dictionary];
    [conferenceModel ZJSDKVideoJoinConferenceWithTarget:self.sipkeyTf.text
                                            displayName:self.displayNameTf.text
                                               password:self.passwordTf.text
                                              videoType:ZJVideoTypeWithVideo];
    
    NSLog(@"入会参数： -- %@",conferenceModel);
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
                  showFunctionItem:YES
                isAutoPrePresentVC:YES];
}

- (IBAction)clickJoinCostum:(id)sender {
    struct ZJVideoSize minSize = {[self.minWidth.text integerValue],[self.minHeightTf.text integerValue]};
    struct ZJVideoSize expectedSize = {[self.expectedWidth.text integerValue],[self.expectedHeight.text integerValue]};
    
    NSMutableDictionary *conferenceModel = [NSMutableDictionary dictionary];
    [conferenceModel ZJSDKVideoJoinConferenceWithTarget:self.sipkeyTf.text
                                            displayName:self.displayNameTf.text
                                               password:self.passwordTf.text];
    NSLog(@"入会参数： -- %@",conferenceModel);
    
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
                  showFunctionItem:YES
                isAutoPrePresentVC:NO];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [self.manager.conferenceView addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    videoVC = [[VideoViewController alloc]init];
    [videoVC.view addSubview:self.manager.conferenceView];
    
    
    [self presentViewController:videoVC animated:NO completion:nil];
}

- (void)click{
    
}

-(void)zjOutofConference{
    
}

-(void)zjCallFalidMessage:(NSString *)reason{
    
}

-(void)zjLogPercentageLost:(NSDictionary *)packet{
    
}

-(void)zjCallBackWithState:(ZJSDKCallState)state
                withReason:(NSString *)reason
                  withUUID:(NSString *)uuid{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
