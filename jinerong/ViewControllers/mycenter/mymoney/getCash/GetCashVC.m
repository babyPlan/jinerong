//
//  GetCashVC.m
//  jinerong
//
//  Created by carcool on 6/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "GetCashVC.h"
#import "GetCashCellAddBank.h"
#import "GetCashCellBank.h"
#import "GetCashCellDown.h"
#import "GetCashCellNoBank.h"
#import "BindBankCardVC.h"
#import "GetCashVerifyCodeVC.h"
@interface GetCashVC ()

@end

@implementation GetCashVC
@synthesize haveBank,m_aryBanks,m_dicGetCashPre;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"提现";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.haveBank=0;
    self.m_aryBanks=[NSMutableArray array];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getPreData];
}
-(void)getPreData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetCashPreData forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetCashPreData;
    [self.SHRequest_ startAsynchronous];
}
-(void)getCash
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetCash forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetCash;
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
        if ([self.currentRequest isEqualToString:SH_GetCashPreData])
        {
            self.m_dicGetCashPre=item;
            [self.m_aryBanks removeAllObjects];
            if(![[item objectForKey:@"bindBankCard"] isEqual:[NSNull null]])
            {
                [self.m_aryBanks addObject:[item objectForKey:@"bindBankCard"]];
            }
            if (self.m_aryBanks.count>0)
            {
                self.haveBank=1;
            }
            else
            {
                self.haveBank=0;
            }
            [self.m_tableView reloadData];
        }
        else if ([self.currentRequest isEqualToString:SH_GetCash])
        {
           
        }
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (haveBank==0)
    {
        return 2;
    }
    else
    {
        return 1+self.m_aryBanks.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.haveBank==0)
    {
        if (indexPath.row==0)
        {
            GetCashCellNoBank *cell=[[[NSBundle mainBundle] loadNibNamed:@"GetCashCellNoBank" owner:nil options:nil] objectAtIndex:0];
            return cell;
        }
        else
        {
            GetCashCellDown *cell=[[[NSBundle mainBundle] loadNibNamed:@"GetCashCellDown" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
            cell.labelAvailable.text=[NSString stringWithFormat:@"%@元",[self.m_dicGetCashPre objectForKey:@"availableWithdrawAmt"]];
            return cell;
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            GetCashCellBank *cell=[[[NSBundle mainBundle] loadNibNamed:@"GetCashCellBank" owner:nil options:nil] objectAtIndex:0];
            cell.data=[self.m_aryBanks objectAtIndex:0];
            [cell updateView];
            return cell;
        }
        else
        {
            GetCashCellDown *cell=[[[NSBundle mainBundle] loadNibNamed:@"GetCashCellDown" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
            cell.labelAvailable.text=[NSString stringWithFormat:@"%@元",[self.m_dicGetCashPre objectForKey:@"availableWithdrawAmt"]];
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (self.haveBank==0)
    {
        if (indexPath.row==0)
        {
            height=60;
        }
        else
        {
            height=230;
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            height=60;
        }
        else
        {
            height=230;
        }
    }

    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        BindBankCardVC *vc=[[BindBankCardVC alloc] init];
        if ([[self.m_dicGetCashPre objectForKey:@"bindBankCard"] isEqual:[NSNull null]]||![[self.m_dicGetCashPre objectForKey:@"bindBankCard"] objectForKey:@"bankAccount"]||[[[self.m_dicGetCashPre objectForKey:@"bindBankCard"] objectForKey:@"bankAccount"] isEqualToString:@""])
        {
            vc.oldBankCardID=@"";
        }
        else
        {
            vc.oldBankCardID=[[self.m_dicGetCashPre objectForKey:@"bindBankCard"] objectForKey:@"bankAccount"];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ----- event response
-(void)getCashBtnPressed:(NSString*)money
{
    if ([[self.m_dicGetCashPre objectForKey:@"isRealName"] integerValue]!=1)
    {
        [self showMessage:@"请先实名认证"];
        return;
    }
    else if ([money floatValue]>[[self.m_dicGetCashPre objectForKey:@"availableWithdrawAmt"] floatValue])
    {
        [self showMessage:@"不能超过余额"];
        return;
    }
    else if (self.m_aryBanks.count<1)
    {
        [self showMessage:@"请先绑定银行卡"];
        return;
    }
    else
    {
        GetCashVerifyCodeVC *vc=[[GetCashVerifyCodeVC alloc] init];
        vc.data=self.m_dicGetCashPre;
        vc.moneyNum=money;
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
