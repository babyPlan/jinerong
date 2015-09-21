//
//  MyInvestVC.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyInvestVC.h"
#import "MyLicaiCell.h"
#import "MyZhongchouCell.h"
#import "TransferDebtVC.h"
@interface MyInvestVC ()

@end

@implementation MyInvestVC
@synthesize licaiOrZhongchou,m_aryInvestings,m_aryMySupport;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的投资";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryInvestings=[NSMutableArray array];
    self.m_aryMySupport=[NSMutableArray array];
    self.licaiOrZhongchou=0;
    [self addTableView];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self.m_tableView setFrame:CGRectMake(0, 40, Screen_Width, Screen_Height-64-49-40)];

    [self getMyInvestings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getMyInvestings
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_MyInvestList forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_MyInvestList;
    [self.SHRequest_ startAsynchronous];
}
-(void)getMySupport
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_MySupportList forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_MySupportList;
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
        if ([self.currentRequest isEqualToString:SH_MyInvestList])
        {
            self.m_aryInvestings=[item objectForKey:@"investings"];
            [self getMySupport];
        }
        else if ([self.currentRequest isEqualToString:SH_MySupportList])
        {
            self.m_aryMySupport=[item objectForKey:@"supports"];
        }
        [self.m_tableView reloadData];
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.licaiOrZhongchou==0)
    {
        return self.m_aryInvestings.count;
    }
    else
    {
        return self.m_aryMySupport.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (licaiOrZhongchou==0)
    {
        MyLicaiCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyLicaiCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MyLicaiCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=[self.m_aryInvestings objectAtIndex:indexPath.row];
        [cell updateViews];
        return cell;
    }
    else
    {
        MyZhongchouCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyZhongchouCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"MyZhongchouCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=[self.m_aryMySupport objectAtIndex:indexPath.row];
        [cell updateViews];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (licaiOrZhongchou==0)
    {
        return 60;
    }
    else
    {
        return 110;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.licaiOrZhongchou==0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TransferDebtVC *vc=[[TransferDebtVC alloc] init];
        vc.transferID=[[self.m_aryInvestings objectAtIndex:indexPath.row] objectForKey:@"transId"];
        vc.status=[[self.m_aryInvestings objectAtIndex:indexPath.row] objectForKey:@"status"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -------- event response
-(IBAction)licai:(id)sender
{
    self.licaiOrZhongchou=0;
    [self.label_lc setTextColor:JER_RED];
    [self.label_jk setTextColor:[UIColor darkGrayColor]];
    [self.lineView_l setBackgroundColor:JER_RED];
    [self.lineView_r setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.m_tableView reloadData];
}
-(IBAction)zhongchou:(id)sender
{
    self.licaiOrZhongchou=1;
    [self.label_lc setTextColor:[UIColor darkGrayColor]];
    [self.label_jk setTextColor:JER_RED];
    [self.lineView_l setBackgroundColor:[UIColor lightGrayColor]];
    [self.lineView_r setBackgroundColor:JER_RED];
    
    [self.m_tableView reloadData];
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
