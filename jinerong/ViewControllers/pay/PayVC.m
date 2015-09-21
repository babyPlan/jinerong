//
//  PayVC.m
//  jinerong
//
//  Created by carcool on 6/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PayVC.h"
#import "PaySuccessForLicaiVC.h"
#import "PaySuccessForZhongchouVC.h"
@interface PayVC ()

@end

@implementation PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"支付";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];

    [self.btn setColor:JER_RED];
    self.textFieldPayPassword.delegate=self;
    
    [self getMybalence];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getMybalence
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
    NSString *responseString = [request responseString];
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        if ([self.currentRequest isEqualToString:SH_BUY])
        {
            PaySuccessForLicaiVC *vc=[[PaySuccessForLicaiVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([self.currentRequest isEqualToString:SH_UserAccountMoney])
        {
            self.labelBalence.text=[NSString stringWithFormat:@"账户余额 ¥%.2f",[[item objectForKey:@"availableAmt"] floatValue]];
            float realPay=[[self.data objectForKey:@"payAmount"] floatValue]-[[self.data objectForKey:@"packetAmount"] floatValue];
            self.labelPayAmount.text=[NSString stringWithFormat:@"¥%.2f",realPay];
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
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float textfiled_y=[textField convertRect:self.textFieldBG.frame toView:self.view].origin.y;
    if (textfiled_y>Screen_Height-KEYBOARD_HEIGHT)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y;
        [self.view setFrame:CGRectMake(PARENT_X(self.view),PARENT_Y(self.view)+_y , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    }

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.view setFrame:CGRectMake(PARENT_X(self.view),64 , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    return YES;
}
#pragma mark ----- event response
-(IBAction)DoneBtnPressed:(id)sender
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_BUY forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:[self.data objectForKey:@"projNo"] forKey:@"projNo"];
    [paras_fource setObject:[self.data objectForKey:@"payAmount"] forKey:@"payAmount"];
    [paras_fource setObject:[self.data objectForKey:@"packetAmount"] forKey:@"packetAmount"];
    [paras_fource setObject:[SHAPI md5:self.textFieldPayPassword.text] forKey:@"payPassword"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_BUY;
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
