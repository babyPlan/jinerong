//
//  RechargeVC.m
//  jinerong
//
//  Created by carcool on 6/12/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RechargeVC.h"
#import "RechargeWebVC.h"
@interface RechargeVC ()

@end

@implementation RechargeVC
@synthesize m_aryBanks,pickerView,doneBtn,shieldView,data;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"充值";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.rechargeType=0;
    self.rechargeDescription=@"充值";
    self.ip=[MyFounctions getIPAddress:YES];
    self.bankCode=@"";
    self.isRealName=0;
    
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [self.lineView1 setBackgroundColor:JER_BG_GRAY];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [MyFounctions setLineViewMoreThin:self.lineView1];
    [self.btn setColor:JER_RED];
    self.textFiedMoney.delegate=self;
    
    [self.personImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    [self.gouImg setImage:[UIImage imageNamed:@"gou_fangkuang"]];
    self.m_aryBanks=[NSMutableArray array];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"personBanks" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    [self.m_aryBanks removeAllObjects];
    [self.m_aryBanks addObjectsFromArray:[dictionary objectForKey:@"banks"]];
    [self getPreData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatPickerView:(NSInteger)index
{
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-200-49, Screen_Width, 30)];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:pickerView];
    
    self.doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame: CGRectMake(0, Screen_Height-200-49-40, Screen_Width, 40)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor lightGrayColor]];
    [doneBtn addTarget:self action:@selector(selectDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
    self.shieldView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-PARENT_Y(doneBtn)-64-49)];
    [self.shieldView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.shieldView];
}
-(void)getPreData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_RechargePreData forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_RechargePreData;
    [self.SHRequest_ startAsynchronous];
}
-(void)recharge
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_Recharge forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:self.textFiedMoney.text forKey:@"rechargeAmt"];
    [paras_fource setObject:self.rechargeType==0?@"B2CDEBITBANK":@"B2BBANK" forKey:@"rechargeType"];
    [paras_fource setObject:self.bankCode forKey:@"bankCode"];
    [paras_fource setObject:self.rechargeDescription forKey:@"rechargeDesc"];
    [paras_fource setObject:self.ip forKey:@"ip"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_Recharge;
    [self.SHRequest_ startAsynchronous];
}
#pragma mark ======== request delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    self.resultData=[request responseData];
    self.resultStr=responseString;
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        if ([self.currentRequest isEqualToString:SH_RechargePreData])
        {
            self.isRealName=[[item objectForKey:@"isRealName"] integerValue];
        }
        else if ([self.currentRequest isEqualToString:SH_Recharge])
        {
            RechargeWebVC *vc=[[RechargeWebVC alloc] init];
            vc.dic=[NSMutableDictionary dictionaryWithDictionary:item];
            [vc updateView];
            vc.typeIndex=@"3";
            vc.m_recgargeVC=self;
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

#pragma mark --------- textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark --------- uipicker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
            return self.m_aryBanks.count;
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [[self.m_aryBanks objectAtIndex:row] objectForKey:@"name"];
   
}
-(void)selectDone
{
    NSInteger index= [self.pickerView selectedRowInComponent:0];
    self.labelBank.text=[[self.m_aryBanks objectAtIndex:index] objectForKey:@"name"];
    self.bankCode=[[self.m_aryBanks objectAtIndex:index] objectForKey:@"id"];
    
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    [self.shieldView removeFromSuperview];
    self.shieldView=nil;
}


#pragma mark ------- event response
-(IBAction)selectType:(id)sender
{
    [self setAllTypeUnselected];
    UIButton *typeBtn=(UIButton*)sender;
    if (typeBtn.tag==0)
    {
        [self.personImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"personBanks" ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        [self.m_aryBanks removeAllObjects];
        [self.m_aryBanks addObjectsFromArray:[dictionary objectForKey:@"banks"]];
        self.rechargeType=0;
    }
    else if (typeBtn.tag==1)
    {
        [self.enterpriseImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"enterpriseBanks" ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        [self.m_aryBanks removeAllObjects];
        [self.m_aryBanks addObjectsFromArray:[dictionary objectForKey:@"banks"]];
        self.rechargeType=1;
    }
}
-(void)setAllTypeUnselected
{
    [self.personImg setImage:[UIImage imageNamed:@"circle"]];
    [self.enterpriseImg setImage:[UIImage imageNamed:@"circle"]];
}
-(IBAction)selectBank:(id)sender
{
    [self creatPickerView:0];
}
-(IBAction)readedAndAdmitBtn:(id)sender
{
    if ([self.gouImg.image isEqual:[UIImage imageNamed:@"gou_fangkuang"]])
    {
        [self.gouImg setImage:[UIImage imageNamed:@"fangkuang"]];
    }
    else
    {
        [self.gouImg setImage:[UIImage imageNamed:@"gou_fangkuang"]];
    }
}
-(IBAction)rechargeBtnPreseed:(id)sender
{
    if([self.gouImg.image isEqual:[UIImage imageNamed:@"fangkuang"]])
    {
        [self showMessage:@"需同意协议条款"];
        return;
    }
    
    if ([self.textFiedMoney.text isEqualToString:@""]||![MyFounctions isPureNumandCharacters:self.textFiedMoney.text])
    {
        [self showMessage:@"请输入正确充值金额"];
    }
    else if ([self.bankCode isEqualToString:@""])
    {
        [self showMessage:@"请选择银行"];
    }
    else if (self.isRealName==0)
    {
        [self showMessage:@"请先实名认证"];
    }
    else
    {
        [self recharge];
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
