//
//  BundlePhoneLoginVC.m
//  jinerong
//
//  Created by carcool on 7/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "BundlePhoneLoginVC.h"
#import "BundlePhoneModifyVC.h"
@interface BundlePhoneLoginVC ()

@end

@implementation BundlePhoneLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"绑定手机";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn setColor:JER_BLUE];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    
    [self updateViews];
}
-(void)updateViews
{
    self.labelPhone.text=[[MyFounctions getUserInfo] objectForKey:@"mobileNo"];
    self.textFieldPassword.delegate=self;
    [self.textFieldPassword setSecureTextEntry:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======== request delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        if ([self.currentRequest isEqualToString:SH_VerifyPasswordForModifyPhone])
        {
            BundlePhoneModifyVC *vc=[[BundlePhoneModifyVC alloc] init];
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

#pragma mark ------ textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)btnPressed:(id)sender
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_VerifyPasswordForModifyPhone forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:[SHAPI md5:self.textFieldPassword.text] forKey:@"password"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_VerifyPasswordForModifyPhone;
    [self.SHRequest_ startAsynchronous];
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
