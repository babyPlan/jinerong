//
//  GetCashVerifyCodeVC.m
//  jinerong
//
//  Created by carcool on 6/23/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "GetCashVerifyCodeVC.h"
#import "GetCashSuccessVC.h"
@interface GetCashVerifyCodeVC ()

@end

@implementation GetCashVerifyCodeVC
@synthesize time;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"确认提现";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setColor:JER_RED];
    self.time=60;
    [self.labelSendYZM.layer setBorderWidth:0];
    [self.labelSendYZM.layer setBorderColor:[JER_BLUE CGColor]];
    [self.labelSendYZM setBackgroundColor:JER_RED];
    [self.btn setColor:[UIColor grayColor]];
    self.textFieldCode.delegate=self;
    
    [self getVerifyCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateViews
{
    self.labelName.text=[[MyFounctions getUserInfo] objectForKey:@"realName"];
    self.labelBank.text=[NSString stringWithFormat:@"%@(尾号%ld)",[[self.data objectForKey:@"bindBankCard"] objectForKey:@"bankName"],(long)[[[self.data objectForKey:@"bindBankCard"] objectForKey:@"bankAccountLast"] integerValue]];
    self.labelGetMoney.text=self.moneyNum;
    self.labelBalance.text=[NSString stringWithFormat:@"%.2f",[[self.data objectForKey:@"availableWithdrawAmt"] floatValue]-[self.moneyNum floatValue]];
}
-(void)getVerifyCode
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetVerifyCode forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"mobileNo"] forKey:@"mobileNo"];
    [paras_fource setObject:@"3" forKey:@"type"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetVerifyCode;
    [self.SHRequest_ startAsynchronous];
}
-(void)checkVerifyCode
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_CheckVerifyCode forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"mobileNo"] forKey:@"mobileNo"];
    [paras_fource setObject:@"3" forKey:@"type"];
    [paras_fource setObject:self.textFieldCode.text forKey:@"verifyCode"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_CheckVerifyCode;
    [self.SHRequest_ startAsynchronous];
}
#pragma mark ======== request delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        if ([self.currentRequest isEqualToString:SH_GetVerifyCode])
        {
            [self.btn setColor:JER_BLUE];
            if ([self.labelSendYZM.backgroundColor isEqual:JER_RED])
            {
                [self showMessage:@"验证码已发送"];
                [self.labelSendYZM setTextColor:[UIColor grayColor]];
                [self.labelSendYZM setBackgroundColor:[UIColor whiteColor]];
                [self.labelSendYZM.layer setBorderWidth:1.0];
                [self updateTime];
            }
        }
        else if ([self.currentRequest isEqualToString:SH_CheckVerifyCode])
        {
            NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
            [paras_fource setObject:SH_GetCash forKey:SH_LINK];
            [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
            [paras_fource setObject:self.moneyNum forKey:@"withdrawAmt"];
            [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"mobileNo"] forKey:@"mobileNo"];
            [paras_fource setObject:self.textFieldCode.text forKey:@"verifyCode"];
            [paras_fource setObject:[[self.data objectForKey:@"bindBankCard"] objectForKey:@"bankAccount"] forKey:@"bankCardId"];
            self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
            [self.SHRequest_ setDelegate:self];
            self.currentRequest=SH_GetCash;
            [self.SHRequest_ startAsynchronous];
        }
        else if ([self.currentRequest isEqualToString:SH_GetCash])
        {
            GetCashSuccessVC *vc=[[GetCashSuccessVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
#pragma mark ----- textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ----- event response
-(void)updateTime
{
    if (time>0)
    {
        [self.labelSendYZM setText:[NSString stringWithFormat:@"重发(%ld)",(long)time]];
        time--;
        [self performSelector:@selector(updateTime) withObject:nil afterDelay:1.0];
    }
    else
    {
        [self.labelSendYZM setTextColor:[UIColor whiteColor]];
        [self.labelSendYZM setBackgroundColor:JER_RED];
        [self.labelSendYZM.layer setBorderWidth:0];
        [self.labelSendYZM setText:[NSString stringWithFormat:@"重发验证码"]];
        self.time=60;
    }
}
-(IBAction)getMyVerificationCode:(id)sender
{
    [self getVerifyCode];
}
-(IBAction)nextStepBtnPressed:(id)sender
{
    if ([self.textFieldCode.text isEqualToString:@""])
    {
        [self showMessage:@"请输入验证码"];
        return;
    }
    [self checkVerifyCode];
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
