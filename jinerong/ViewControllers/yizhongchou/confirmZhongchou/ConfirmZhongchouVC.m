//
//  ConfirmZhongchouVC.m
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ConfirmZhongchouVC.h"
#import "ConfirmZCCell.h"
#import "RechargeWebVC.h"
@interface ConfirmZhongchouVC ()

@end

@implementation ConfirmZhongchouVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"众筹确认";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateViews
{
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
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
        if ([self.currentRequest isEqualToString:SH_SurpportZhongchou])
        {
            RechargeWebVC *vc=[[RechargeWebVC alloc] init];
            vc.zhongchouSuccessData=self.m_detailData;
            vc.dic=(NSMutableDictionary*)item;
            vc.typeIndex=@"0";
            
            vc.data=self.supportData;
            [vc updateView];
            vc.title=@"支持众筹";
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

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConfirmZCCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"ConfirmZCCell" owner:nil options:nil] objectAtIndex:0];
    cell.delegate=self;
    cell.data=self.data;
    cell.supportData=self.supportData;
    [cell updateViews];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
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
#pragma mark ------- event response
-(void)supportZhongchouName:(NSString*)name Money:(NSString*)amount Phone:(NSString*)phone Address:(NSString*)address
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_SurpportZhongchou forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:[self.supportData objectForKey:@"crowdfundingId"] forKey:@"crowdFundingId"];
    [paras_fource setObject:[self.supportData objectForKey:@"id"] forKey:@"supportAmtId"];
    [paras_fource setObject:name forKey:@"deliverInfo.receiver"];
    [paras_fource setObject:phone forKey:@"deliverInfo.phoneNum"];
    [paras_fource setObject:address forKey:@"deliverInfo.receiveAddr"];
    
    self.m_detailData=[NSDictionary dictionaryWithDictionary:paras_fource];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_SurpportZhongchou;
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
