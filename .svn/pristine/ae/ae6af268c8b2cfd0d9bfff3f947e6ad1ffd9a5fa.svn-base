//
//  GetCashSuccessVC.m
//  jinerong
//
//  Created by carcool on 6/23/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "GetCashSuccessVC.h"

@interface GetCashSuccessVC ()

@end

@implementation GetCashSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"确认提现";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
//    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
//    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"完成"];
    [self.rightNaviBtn addTarget:self action:@selector(popToRootVC) forControlEvents:UIControlEventTouchUpInside];
    [self.btnGetcash setColor:[UIColor clearColor]];
    [self.btnGetcash.layer setBorderWidth:1.0];
    [self.btnGetcash.layer setBorderColor:[JER_BLUE CGColor]];
    [self.btnTransactionRecords setColor:[UIColor clearColor]];
    [self.btnTransactionRecords.layer setBorderWidth:1.0];
    [self.btnTransactionRecords.layer setBorderColor:[JER_BLUE CGColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)popToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)getCash:(id)sender
{
    [self popToRootVC];
}
-(IBAction)transactionRecords:(id)sender
{
    [self popToRootVC];
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
