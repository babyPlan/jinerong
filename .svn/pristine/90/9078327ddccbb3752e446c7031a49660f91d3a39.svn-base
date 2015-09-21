//
//  MyMoneyVC.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyMoneyVC.h"
#import "TransactionRecordsVC.h"
#import "AutoBidVC.h"
#import "RechargeVC.h"
#import "GetCashVC.h"
@interface MyMoneyVC ()

@end

@implementation MyMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的资金";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [self.lineView1 setBackgroundColor:JER_BG_GRAY];
    [self.lineView2 setBackgroundColor:JER_BG_GRAY];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [MyFounctions setLineViewMoreThin:self.lineView1];
    [MyFounctions setLineViewMoreThin:self.lineView2];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_UserAccountMoney forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_UserAccountMoney;
    [self.SHRequest_ startAsynchronous];
}
#pragma mark ======== request delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.refreshHeader endRefreshing];
    [self.refreshFooter endRefreshing];
    NSString *responseString = [request responseString];
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        if ([self.currentRequest isEqualToString:SH_UserAccountMoney])
        {
            self.labelAvailable.text=[item objectForKey:@"availableAmt"];
            self.labeltotalEarn.text=[item objectForKey:@"totalIncome"];
            self.labelYesterday.text=[item objectForKey:@"todayIncome"];
        }
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark ------ event response
-(IBAction)ButtonPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)//recharge
    {
        RechargeVC *vc=[[RechargeVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==1)//get cash
    {
        GetCashVC *vc=[[GetCashVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==2)//p2p auto bid
    {
        AutoBidVC *vc=[[AutoBidVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==3)//transaction records
    {
        TransactionRecordsVC *vc=[[TransactionRecordsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
