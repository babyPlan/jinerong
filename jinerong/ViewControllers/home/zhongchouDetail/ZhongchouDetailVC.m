//
//  ZhongchouDetailVC.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ZhongchouDetailVC.h"
#import "ZCCell0.h"
#import "ZCCell1.h"
#import "ZCRewardCell.h"
#import "ZCNoRewardCell.h"
#import "ConfirmZhongchouVC.h"
#import "ZhongchouShowDetailVCViewController.h"
@interface ZhongchouDetailVC ()

@end

@implementation ZhongchouDetailVC
@synthesize data,m_arySupports;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"众筹详情";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.m_arySupports=[NSMutableArray array];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_ZhongchouDetail forKey:SH_LINK];
    [paras_fource setObject:self.crowdFundingId forKey:@"crowdFundingId"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ZhongchouDetail;
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
        if ([self.currentRequest isEqualToString:SH_ZhongchouDetail])
        {
            self.data=item;
            [self.m_arySupports addObjectsFromArray:[self.data objectForKey:@"supportAmtList"]];
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
    if (self.m_arySupports.count>0)
    {
        NSLog(@"count:%ld",(unsigned long)self.m_arySupports.count);
        return 2+self.m_arySupports.count;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        ZCCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"ZCCell0"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ZCCell0" owner:nil options:nil] objectAtIndex:0];
            cell.picUrl=[[self.data objectForKey:@"cfRecord"] objectForKey:@"crowdfundingPicBig"];
            [cell updateViews];
        }
        return cell;
    }
    else if (indexPath.row==1)
    {
        ZCCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"ZCCell1"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ZCCell1" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
            cell.data=[self.data objectForKey:@"cfRecord"];
            [cell updateViews];
        }
        return cell;
    }
    else
    {
        NSLog(@"atindex:%@",self.m_arySupports);
        if ([[[self.m_arySupports objectAtIndex:indexPath.row-2] objectForKey:@"supportAmt"] floatValue]>0)
        {
            NSLog(@"zhongchouDetail:%@",[self.data objectForKey:@"nopaySupportNum"]);
            ZCRewardCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZCRewardCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"ZCRewardCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.indexSupport=indexPath.row-2;
            cell.data=[self.m_arySupports objectAtIndex:indexPath.row-2];
            cell.status=[[self.data objectForKey:@"cfRecord"]objectForKey:@"statusDesc"];
            [cell updateViews];
            return cell;
        }
        else
        {
            ZCNoRewardCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZCNoRewardCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"ZCNoRewardCell" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.indexSupport=indexPath.row-2;
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=190;
    }
    else if (indexPath.row==1)
    {
        height=220;
    }
    else
    {
        if ([[[self.m_arySupports objectAtIndex:indexPath.row-2] objectForKey:@"supportAmt"] floatValue]>0)
        {
//            height=210;
            float textHeight=[MyFounctions calculateLabelHeightWithString:[[self.m_arySupports objectAtIndex:indexPath.row-2] objectForKey:@"supportDesc"] Width:280 font:[UIFont systemFontOfSize:14.0]];
            height=10+87+textHeight+10+21+10;
        }
        else
        {
            height=130;
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
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark -------- event response
-(void)supportTheZhongchou:(NSInteger)index
{
    ConfirmZhongchouVC *vc=[[ConfirmZhongchouVC alloc] init];
    vc.data=self.data;
    vc.supportData=[self.m_arySupports objectAtIndex:index];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)checkZhongchouDetail{
    ZhongchouShowDetailVCViewController *vc =[[ZhongchouShowDetailVCViewController alloc]init];
    vc.data=self.data;
    vc.supportData=[self.m_arySupports objectAtIndex:0];
    vc.crowdFundingId=self.crowdFundingId;
    [vc updateData];
    [self.navigationController pushViewController:vc animated:YES];
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
