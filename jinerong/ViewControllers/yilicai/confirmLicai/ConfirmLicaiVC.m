//
//  ConfirmLicaiVC.m
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ConfirmLicaiVC.h"
#import "ConfirmLCCell.h"
#import "PayVC.h"
#import "RechargeWebVC.h"
@interface ConfirmLicaiVC ()

@end

@implementation ConfirmLicaiVC
@synthesize pickerView,doneBtn,shieldView,bidMoney,confirmcell;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"确认投标";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryRedpackets=[NSMutableArray array];
    self.packetType=@"";
    self.packetAmt=@"";
    self.bidMoney=@"";
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_PRODETAILS forKey:SH_LINK];
    [paras_fource setObject:self.projNo forKey:@"projNo"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_PRODETAILS;
    [self.SHRequest_ startAsynchronous];
}
-(void)getRedPackets
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetRedPackets forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetRedPackets;
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
        if ([self.currentRequest isEqualToString:SH_PRODETAILS])
        {
            self.data=[item objectForKey:@"project"];
            NSLog(@"confirm:%@",[[item objectForKey:@"perUser"]objectForKey:@"nickName"]);
            self.nickName=[[item objectForKey:@"perUser"]objectForKey:@"nickName"];
            [self.m_tableView reloadData];
            
            [self getRedPackets];
        }
        else if ([self.currentRequest isEqualToString:SH_GetRedPackets])
        {
            [self.m_aryRedpackets addObjectsFromArray:[item objectForKey:@"packetList"]];
        }
        else if ([self.currentRequest isEqualToString:SH_GetRedPacketParametre])
        {
            self.packetAmt=[NSString stringWithFormat:@"%.2f",[self.bidMoney floatValue]*([[[item objectForKey:@"packetParams"] objectForKey:@"packetRate"] floatValue]/100.0)];
            if ([self.packetAmt floatValue]>[[[self.m_aryRedpackets objectAtIndex:self.selectedPacketIndex] objectForKey:@"currAmount"] floatValue])
            {
                self.packetAmt=[NSString stringWithFormat:@"%.2f",[[[self.m_aryRedpackets objectAtIndex:self.selectedPacketIndex] objectForKey:@"currAmount"] floatValue]];
            }
            self.confirmcell.labelRedPacket.text=self.packetAmt;
            self.confirmcell.labelPay.text=[NSString stringWithFormat:@"¥%.2f",([self.bidMoney floatValue]-[self.packetAmt floatValue])];
        }
        else if ([self.currentRequest isEqualToString:SH_GetPayBidWeb])
        {
            RechargeWebVC *vc=[[RechargeWebVC alloc] init];
            vc.dic=(NSMutableDictionary*)item;
            vc.typeIndex=@"1";
            vc.licaiSuccessData=self.m_detailData;
            [vc updateView];
            vc.title=@"支付";
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
    self.confirmcell=[[[NSBundle mainBundle] loadNibNamed:@"ConfirmLCCell" owner:nil options:nil] objectAtIndex:0];
    confirmcell.delegate=self;
    confirmcell.data=self.data;
    confirmcell.nickName=self.nickName;
    [confirmcell updateViews];
    return confirmcell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 510;
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
#pragma mark --------- uipicker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.m_aryRedpackets.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str=[NSString stringWithFormat:@"红包%@ %@元",[[self.m_aryRedpackets objectAtIndex:row] objectForKey:@"type"],[[self.m_aryRedpackets objectAtIndex:row] objectForKey:@"currAmount"]];
    return str;
}

#pragma mark ------- event response
-(void)bidTheItem:(NSString *)bidAmount redPacket:(NSString *)redpacket
{
//    PayVC *vc=[[PayVC alloc] init];
//    vc.data=[NSDictionary dictionaryWithObjects:@[[[MyFounctions getUserInfo] objectForKey:@"uid"],self.projNo,bidAmount,redpacket] forKeys:@[@"uid",@"projNo",@"payAmount",@"packetAmount"]];
//    [self.navigationController pushViewController:vc animated:YES];
    
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetPayBidWeb forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:self.projNo forKey:@"projNo"];
    [paras_fource setObject:bidAmount forKey:@"bidAmt"];
    [paras_fource setObject:self.packetType forKey:@"packetType"];
    [paras_fource setObject:self.packetAmt forKey:@"packetAmt"];
    
    self.m_detailData = [NSDictionary dictionaryWithDictionary:paras_fource];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetPayBidWeb;
    [self.SHRequest_ startAsynchronous];
}
-(void)creatPickerView
{
    if (self.m_aryRedpackets.count<1)
    {
        [self showMessage:@"您没有红包！"];
        return;
    }
    else if ([self.bidMoney isEqualToString:@""])
    {
        [self showMessage:@"请先填写投资金额"];
        return;
    }
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-200-49, Screen_Width, 30)];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.tag=0;
   
    [self.view addSubview:pickerView];
    
    self.doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame: CGRectMake(0, Screen_Height-200-49-40, Screen_Width, 40)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor lightGrayColor]];
    [doneBtn addTarget:self action:@selector(selectDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
//    self.shieldView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-PARENT_Y(doneBtn))];
//    [self.shieldView setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:self.shieldView];
    
}
-(void)selectDone
{
    NSInteger index= [self.pickerView selectedRowInComponent:0];
    self.selectedPacketIndex=index;
    self.packetType=[[self.m_aryRedpackets objectAtIndex:index] objectForKey:@"type"];
    
    
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetRedPacketParametre forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:[[self.m_aryRedpackets objectAtIndex:index] objectForKey:@"type"] forKey:@"packetType"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetRedPacketParametre;
    [self.SHRequest_ startAsynchronous];
    
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    [self.shieldView removeFromSuperview];
    self.shieldView=nil;
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
