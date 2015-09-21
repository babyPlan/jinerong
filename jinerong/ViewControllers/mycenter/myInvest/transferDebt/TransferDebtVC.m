//
//  TransferDebtVC.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TransferDebtVC.h"
#import "TransferDebtCell0.h"
#import "TransferDebtCell1.h"
@interface TransferDebtVC ()

@end

@implementation TransferDebtVC
@synthesize transferFlag;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.transferFlag=0;
    self.title=@"详细信息";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTableView];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    
    [self getMyInvestDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getMyInvestDetail
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_MyInvestDetail forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:self.transferID forKey:@"transId"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_MyInvestDetail;
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
        if ([self.currentRequest isEqualToString:SH_MyInvestDetail])
        {
            self.project=item;
//            self.investing=[item objectForKey:@"investing"];
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
    if (transferFlag==0) {
        return 1;
    }
    else{
        return 2;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        TransferDebtCell0 *cell=[[[NSBundle mainBundle] loadNibNamed:@"TransferDebtCell0" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        if (self.transferFlag==0)
        {
            cell.m_switch.on=NO;
        }
        else
        {
            cell.m_switch.on=YES;
        }
        cell.data=self.project;
        cell.status=self.status;
        [cell updateViews];
        return cell;
    }
    else
    {
        TransferDebtCell1 *cell=[[[NSBundle mainBundle] loadNibNamed:@"TransferDebtCell1" owner:nil options:nil] objectAtIndex:0];
         cell.delegate=self;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=220;
    }
    else
    {
        height=330;
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
