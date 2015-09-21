//
//  ApplyRecordsListVC.m
//  jinerong
//
//  Created by carcool on 6/11/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ApplyRecordsListVC.h"
#import "ApplyRecordCell.h"
#import "ApplyRecordBorrowVC.h"
#import "ApplyRecordZhongchouVC.h"
@interface ApplyRecordsListVC ()

@end

@implementation ApplyRecordsListVC
@synthesize m_aryBorrows,m_aryFunds;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"申请查询";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.indexFlag=0;
    self.m_aryFunds=[NSMutableArray array];
    self.m_aryBorrows=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 40, Screen_Width, Screen_Height-64-40-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    [self getMyFunds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getMyFunds
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetMyFunds forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetMyFunds;
    [self.SHRequest_ startAsynchronous];
}
-(void)getMyBorrows
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetMyBorrows forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetMyBorrows;
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
        if ([self.currentRequest isEqualToString:SH_GetMyFunds])
        {
            [self.m_aryFunds addObjectsFromArray:[item objectForKey:@"applyList"]];
            [self getMyBorrows];
        }
        else if ([self.currentRequest isEqualToString:SH_GetMyBorrows])
        {
            [self.m_aryBorrows addObjectsFromArray:[item objectForKey:@"borrows"]];
            [self.m_tableView reloadData];
        }
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
    if (self.indexFlag==0)
    {
        return self.m_aryBorrows.count;
    }
    else
    {
        return self.m_aryFunds.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplyRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ApplyRecordCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ApplyRecordCell" owner:nil options:nil] objectAtIndex:0];
    }
    if(self.indexFlag==0)
    {
        cell.data=[self.m_aryBorrows objectAtIndex:indexPath.row];
    }
    else if (self.indexFlag==1)
    {
        cell.data=[self.m_aryFunds objectAtIndex:indexPath.row];
    }
    cell.indexFlag=self.indexFlag;
    [cell updateViews];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.indexFlag==0)
    {
        ApplyRecordBorrowVC *vc=[[ApplyRecordBorrowVC alloc] init];
        vc.data=[self.m_aryBorrows objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        ApplyRecordZhongchouVC *vc=[[ApplyRecordZhongchouVC alloc] init];
        vc.data=[self.m_aryFunds objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -------- event response
-(IBAction)licai:(id)sender
{
    self.indexFlag=0;
    [self.label_lc setTextColor:JER_RED];
    [self.label_jk setTextColor:[UIColor darkGrayColor]];
    [self.lineView_l setBackgroundColor:JER_RED];
    [self.lineView_r setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.m_tableView reloadData];
}
-(IBAction)jiekuan:(id)sender
{
    self.indexFlag=1;
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
