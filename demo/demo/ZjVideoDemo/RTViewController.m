//
//  RTViewController.m
//  ZjVideoDemo
//
//  Created by 李志朋 on 2018/1/30.
//  Copyright © 2018年 李志朋. All rights reserved.
//

#import "RTViewController.h"
#import "JoinViewController.h"
#import "PTPViewController.h"


@interface RTViewController ()

@end

@implementation RTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JoinViewController *vc1 = [[JoinViewController alloc]init];
    [self addChildCustomVc:vc1 withTitle:@"主叫"];
    
    PTPViewController *vc2 = [[PTPViewController alloc]init];
    [self addChildCustomVc:vc2 withTitle:@"被叫"];
    
}

-(void)inCommingCall:(NSDictionary *)dict{
    [[NSNotificationCenter defaultCenter]postNotificationName:INCOMMINGCALL object:dict[@"data"]];
}

-(void)rejectedCall:(NSDictionary *)dict{
    [[NSNotificationCenter defaultCenter]postNotificationName:REJECTEDCALL object:dict[@"data"]];
}

-(void)addChildCustomVc:(UIViewController *)childVc withTitle:(NSString *)title{
    childVc.title = title;
    UINavigationController *ngc = [[UINavigationController alloc]initWithRootViewController:childVc];

    [self addChildViewController:ngc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
