//
//  PTPViewController.m
//  ZjVideoDemo
//
//  Created by 李志朋 on 2018/1/31.
//  Copyright © 2018年 李志朋. All rights reserved.
//

#import "PTPViewController.h"
#import "ZJVideoManager.h"
#import "AppDelegate.h"

NSString *const INCOMMINGCALL = @"INCOMMINGCALL";
NSString *const REJECTEDCALL = @"REJECTEDCALL";

@interface PTPViewController ()<ZJVideoManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *aliasTf;
@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
@property (weak, nonatomic) IBOutlet UITextField *mcuServerTf;
@property (weak, nonatomic) IBOutlet UILabel *reStauteLab;
@property (weak, nonatomic) IBOutlet UILabel *InCommingLab;
@property (weak, nonatomic) IBOutlet UIButton *acBtn;
@property (weak, nonatomic) IBOutlet UIButton *huBtn;
@property (nonatomic, strong) ZJVideoManager *manager;
@property (nonatomic, strong) NSDictionary *incommingDict;

@end

@implementation PTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [ZJVideoManager shareIntance];
    self.manager.delegate = self;
    [self.manager setCartificateName:@"zijingcloud"];
    [self.manager setApiServer:@"vapi.myvmr.cn"];
    self.incommingDict = [NSDictionary dictionary];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(inCommingCall:)
                                                name:INCOMMINGCALL
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(rejectedCall:)
                                                name:REJECTEDCALL
                                              object:nil];
}

-(void)inCommingCall:(NSNotification *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.InCommingLab.backgroundColor = [UIColor greenColor];
        self.incommingDict = sender.object;
    });
}

-(void)rejectedCall:(NSDictionary *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.InCommingLab.backgroundColor = [UIColor redColor];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)reClick:(id)sender {
    AppDelegate *app =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.manager setVoipToken:app.voipToken];
    
    [self.manager registerAccount:self.aliasTf.text
                     withPassword:self.passwordTf.text
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([dict[@"status"] isEqualToString:@"success"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.reStauteLab.backgroundColor = [UIColor greenColor];
            });
        }
    }];
}
- (IBAction)acClick:(id)sender {
    struct ZJVideoSize minSize = {640,480};
    struct ZJVideoSize expectedSize = {640,480};
    
    NSMutableDictionary *conferenceModel = [NSMutableDictionary dictionary];
    [conferenceModel ZJSDKVideoJoinConferenceWithTarget:self.incommingDict[@"conference_alias"]
                                            displayName:@"ios - test"
                                                  token:self.incommingDict[@"token"] timestamp:@"" secretKey:@""];
    
    NSLog(@"入会参数： -- %@",conferenceModel);
    NSMutableDictionary *videoParams = [NSMutableDictionary dictionary];
    
    [videoParams ZJSDKVideoParamWithMinBandWidth:576
                               expectedBandwidth:576
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
- (IBAction)huClick:(id)sender {
    [self.manager callRejectWithAccount:self.incommingDict[@"conference_alias"] withToken:self.incommingDict[@"token"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([dict[@"status"] isEqualToString:@"success"]) {
            NSLog(@"拒接来电");
        }
    }];
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

@end
