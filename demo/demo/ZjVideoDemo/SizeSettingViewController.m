//
//  SizeSettingViewController.m
//  ZjVideoDemo
//
//  Created by 李志朋 on 2018/3/2.
//  Copyright © 2018年 李志朋. All rights reserved.
//

#import "SizeSettingViewController.h"

@interface SizeSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *nameArr;
@property(nonatomic,strong)NSArray *ptfArr;
@property(nonatomic,strong)NSMutableArray *mptfArr;

@end

@implementation SizeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableV = [[UITableView alloc]initWithFrame:self.view.frame];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    
    self.nameArr = @[@"下载带宽",@"上传带宽",@"下载分辨率宽",@"下载分辨率高",@"上传分辨率宽",@"上传分辨率高"];
    
    self.ptfArr = @[@"576",@"576",@"320",@"240",@"320",@"240"];
    
    self.mptfArr = [NSMutableArray array];
    
    self.navigationItem.title = @"分辨率";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(rightSize)];
}

-(void)rightSize{
    NSMutableArray *marr = [NSMutableArray array];
    for (UITextField *tf in self.mptfArr) {
        [marr addObject:tf.text];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:[marr copy] forKey:@"meetingVideo"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"CELLID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = self.nameArr[indexPath.row];
    UITextField *ptf = [[UITextField alloc]initWithFrame:CGRectMake(150, 5, self.view.frame.size.width-190, 40)];
    ptf.text = self.ptfArr[indexPath.row];
    ptf.borderStyle = UITextBorderStyleRoundedRect;
    [cell addSubview:ptf];
    
    [self.mptfArr insertObject:ptf atIndex:indexPath.row];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
