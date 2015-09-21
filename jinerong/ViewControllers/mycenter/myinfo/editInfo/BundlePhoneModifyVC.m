//
//  BundlePhoneModifyVC.m
//  jinerong
//
//  Created by carcool on 7/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "BundlePhoneModifyVC.h"

@interface BundlePhoneModifyVC ()

@end

@implementation BundlePhoneModifyVC
@synthesize time;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"修改绑定手机";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.time=60;
    [self.btn setColor:JER_BLUE];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [MyFounctions setLineViewMoreThin:self.lineView1];
    [self.lineView1 setBackgroundColor:JER_BG_GRAY];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getVerifyCode
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetVerifyCode forKey:SH_LINK];
    [paras_fource setObject:self.textFieldPhone.text forKey:@"mobileNo"];
    [paras_fource setObject:@"4" forKey:@"type"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetVerifyCode;
    [self.SHRequest_ startAsynchronous];
}
-(void)checkVerifyCode
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_ModifyPhone forKey:SH_LINK];
    [paras_fource setObject:self.textFieldPhone.text forKey:@"mobileNo"];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:self.textFieldCode.text forKey:@"verifyCode"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ModifyPhone;
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
                [self updateTime];
            }
        }
        else if ([self.currentRequest isEqualToString:SH_ModifyPhone])
        {
            [self showMessage:@"修改成功"];
            NSMutableDictionary *userDic=(NSMutableDictionary*)[MyFounctions getUserInfo];
            [userDic setObject:self.textFieldPhone.text forKey:@"mobileNo"];
            [MyFounctions saveUserInfo:(NSDictionary*)userDic];
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
#pragma mark -------- event response
-(IBAction)getMyVerificationCode:(id)sender
{
    if (![MyFounctions isValidateMobile:self.textFieldPhone.text])
    {
        [self showMessage:@"请输入正确手机号码"];
        return;
    }
    if([self.labelSendYZM.textColor isEqual:[UIColor grayColor]])
    {
        return;
    }
    [self getVerifyCode];
    
}
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
        [self.labelSendYZM setTextColor:JER_RED];
        [self.labelSendYZM setText:[NSString stringWithFormat:@"重发验证码"]];
        self.time=60;
    }
}

-(IBAction)nextStepBtnPressed:(id)sender
{
    if (![MyFounctions isValidateMobile:self.textFieldPhone.text])
    {
        [self showMessage:@"请输入正确的手机号"];
        return;
    }
    else if ([self.textFieldCode.text isEqualToString:@""])
    {
        [self showMessage:@"请输入验证"];
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
