//
//  EditInfoVC.m
//  jinerong
//
//  Created by carcool on 6/12/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "EditInfoVC.h"

@interface EditInfoVC ()

@end

@implementation EditInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"编辑";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setColor:JER_RED];
    self.textField1.delegate=self;
    self.textField2.delegate=self;
    
    [self updateViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateViews
{
    switch (self.editFlag)
    {
        case 0:
            self.title=@"修改昵称";
            self.textField1.placeholder=@"请输入昵称";
            break;
        case 1:
            self.title=@"身份认证";
            self.textField1.placeholder=@"请输入身份号码";
            break;
        case 2:
            self.title=@"手机绑定";
            self.textField1.placeholder=@"请输入手机号码";
            break;
        case 3:
            self.title=@"修改登录密码";
            self.textField1.placeholder=@"请输入旧的登录密码";
            self.textBG2.hidden=NO;
            self.textField2.hidden=NO;
            break;
        case 4:
            self.title=@"修改支付密码";
            self.textField1.placeholder=@"请输入旧的支付密码";
            self.textBG2.hidden=NO;
            self.textField2.hidden=NO;
            break;
        default:
            break;
    }
}
//request
-(void)loginPassword
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_ModifyLoginPassword forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:[SHAPI md5:self.textField1.text] forKey:@"oldPwd"];
    [paras_fource setObject:[SHAPI md5:self.textField2.text] forKey:@"newPwd"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ModifyLoginPassword;
    [self.SHRequest_ startAsynchronous];
}
-(void)payPassword
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_ModifyPayPassword forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:[SHAPI md5:self.textField1.text] forKey:@"oldPwd"];
    [paras_fource setObject:[SHAPI md5:self.textField2.text] forKey:@"newPwd"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ModifyPayPassword;
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
        if ([self.currentRequest isEqualToString:SH_ProductListByType])//product
        {
        }
        else if ([self.currentRequest isEqualToString:SH_ModifyLoginPassword])
        {
            [self showMessage:@"修改成功"];
        }
        else if ([self.currentRequest isEqualToString:SH_ModifyPayPassword])
        {
            [self showMessage:@"修改成功"];
        }
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark --------- textfield delegate
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
-(IBAction)doneBtn:(id)sender
{
    if(self.editFlag==0)
    {
    }
    else if (self.editFlag==3)//modify login password
    {
        [self loginPassword];
    }
    else if (self.editFlag==4)
    {
        [self payPassword];
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
