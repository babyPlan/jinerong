//
//  ResetPasswordVC.m
//  jinerong
//
//  Created by carcool on 6/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ResetPasswordVC.h"

@interface ResetPasswordVC ()

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"重置登录密码";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn setColor:JER_BLUE];
    self.textFieldPassword.delegate=self;
    self.textFieldResetPassword.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)forgetPassword
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_ForgetPassword forKey:SH_LINK];
    [paras_fource setObject:self.phone forKey:@"mobileNo"];
    [paras_fource setObject:[SHAPI md5:self.textFieldPassword.text] forKey:@"password"];
    [paras_fource setObject:self.verifyCode forKey:@"verifyCode"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ForgetPassword;
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
        if ([self.currentRequest isEqualToString:SH_ForgetPassword])
        {
            [self showMessage:@"修改密码成功"];
            [self performSelector:@selector(popToRootVC) withObject:nil afterDelay:1.5];
        }
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)popToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
    
#pragma mark ------ event response
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ------- event response
-(IBAction)btnPressed:(id)sender
{
    if (![self.textFieldPassword.text isEqualToString:@""]&&[self.textFieldPassword.text isEqualToString:self.textFieldResetPassword.text])
    {
        [self forgetPassword];
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
