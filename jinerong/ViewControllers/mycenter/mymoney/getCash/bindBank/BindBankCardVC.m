//
//  BindBankCardVC.m
//  jinerong
//
//  Created by carcool on 6/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "BindBankCardVC.h"
#import "BankListVC.h"
@interface BindBankCardVC ()

@end

@implementation BindBankCardVC
@synthesize m_dicBank;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"绑定银行卡";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [self.btn setColor:JER_RED];
    self.textFieldCardID.delegate=self;
    self.textFieldUserName.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)bindBankCard
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_BindBankCard forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:self.oldBankCardID forKey:@"bankCardId"];//the old bank card
    [paras_fource setObject:self.textFieldUserName.text forKey:@"bankAccountName"];
    [paras_fource setObject:self.textFieldCardID.text forKey:@"bankAccount"];
    [paras_fource setObject:@"bankCode" forKey:@"bankCode"];
    [paras_fource setObject:[self.m_dicBank objectForKey:@"bankName"] forKey:@"bankName"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_BindBankCard;
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
        if ([self.currentRequest isEqualToString:SH_BindBankCard])
        {
            [self popSelfViewContriller];
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
#pragma mark ------ event response
-(IBAction)selectBank:(id)sender
{
    BankListVC *vc=[[BankListVC alloc] init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)bindBtnPressed:(id)sender
{
    if ([self.textFieldCardID.text isEqualToString:@""])
    {
        [self showMessage:@"请输入银行卡号"];
    }
    else if ([self.textFieldUserName.text isEqualToString:@""])
    {
        [self showMessage:@"请输入银行卡开户名"];
    }
    else if (![self.m_dicBank objectForKey:@"bankCode"])
    {
        [self showMessage:@"请选择银行"];
    }
    else if ([self.textFieldCardID.text length]<16||[self.textFieldCardID.text length]>22)
    {
        [self showMessage:@"请输入正确的银行卡号"];
    }
    else
    {
        [self bindBankCard];
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
