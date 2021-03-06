//
//  TransactionRecordsVC.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TransactionRecordsVC.h"
#import "TRansactionCell.h"
@interface TransactionRecordsVC ()

@end

@implementation TransactionRecordsVC
@synthesize switchFlag,menuFlitrateView,m_aryTrasactions;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.switchFlag=0;
    self.title=@"交易记录";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    self.m_aryTrasactions=[NSMutableArray array];
    self.orderType=@"";
    self.fromDate=@"";
    self.toDate=@"";
    self.pageCount=10;
    
    [self addTableView];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self.m_tableView setFrame:CGRectMake(0, 45, Screen_Width, Screen_Height-64-49-45)];
    [self setupHeader];
    [self setupFooter];
    

    self.menuFlitrateView.delegate=self;
    [self.menuFlitrateView setFrame:CGRectMake(0, 45, Screen_Width, 50)];
    [self.view addSubview:self.menuFlitrateView];
    self.menuFlitrateView.hidden=YES;
    
    [self headerRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    NSLog(@"self.orderType :%@ self.fromDate :%@",self.orderType,self.fromDate);
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_TRANSRECORDS forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] forKey:SH_PAGE_CURRENTPAGE];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageCount] forKey:SH_PAGE_RECORDSPERPAGE];
    [paras_fource setObject:self.orderType forKey:@"operType"];
    [paras_fource setObject:self.fromDate forKey:@"fromDateStr"];
    [paras_fource setObject:self.toDate forKey:@"toDateStr"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_TRANSRECORDS;
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
        if ([self.currentRequest isEqualToString:SH_TRANSRECORDS])
        {
            NSArray *array=[item objectForKey:@"recordList"];
            if (self.pageIndex==1)//首页
            {
                [self.m_aryTrasactions removeAllObjects];
            }
            [self.m_aryTrasactions addObjectsFromArray:array];
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
    return self.m_aryTrasactions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRansactionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TRansactionCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"TRansactionCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.data=[self.m_aryTrasactions objectAtIndex:indexPath.row];
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
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)headerRefresh
{
    self.pageIndex=1;
    [self updateData];
    
}
-(void)footerRefresh
{
    self.pageIndex++;
    [self updateData];
}

#pragma mark ------- event response
-(IBAction)MenuBtnPressed:(id)sender
{
    [self setAllUnselected];
    UIButton *btn=(UIButton*)sender;
    if(self.switchFlag==0)
    {
        if (btn.tag==0)
        {
            [self.labelDate setTextColor:JER_RED];
            [self.imgDate setImage:[UIImage imageNamed:@"jt_up_red"]];
            self.switchFlag=1;
        }
        else
        {
            [self.labelType setTextColor:JER_RED];
            [self.imgType setImage:[UIImage imageNamed:@"jt_up_red"]];
            self.switchFlag=2;
            
        }
    }
    else if (self.switchFlag==1)
    {
        if (btn.tag==0)
        {
            self.switchFlag=0;
        }
        else
        {
            [self.labelType setTextColor:JER_RED];
            [self.imgType setImage:[UIImage imageNamed:@"jt_up_red"]];
            self.switchFlag=2;
            
        }
    }
    else if (self.switchFlag==2)
    {
        if (btn.tag==0)
        {
            [self.labelDate setTextColor:JER_RED];
            [self.imgDate setImage:[UIImage imageNamed:@"jt_up_red"]];
            self.switchFlag=1;
        }
        else
        {
            self.switchFlag=0;
            
        }
    }
   
    switch (self.switchFlag)
    {
        case 0:
            self.menuFlitrateView.hidden=YES;
            [self removeBLackBGView];
            break;
        case 1:
            self.menuFlitrateView.hidden=NO;
            [self.menuFlitrateView updateViewDate];
            [self addBlackBGView];
            [self.blackBG removeFromSuperview];
            [self.blackBG setFrame:CGRectMake(PARENT_X(self.blackBG), 45, PARENT_WIDTH(self.blackBG), PARENT_HEIGHT(self.blackBG))];
            [self.view insertSubview:self.blackBG aboveSubview:self.m_tableView];
            break;
        case 2:
            self.menuFlitrateView.hidden=NO;
            [self.menuFlitrateView updateViewTypes];
            [self addBlackBGView];
            [self.blackBG removeFromSuperview];
            [self.blackBG setFrame:CGRectMake(PARENT_X(self.blackBG), 45, PARENT_WIDTH(self.blackBG), PARENT_HEIGHT(self.blackBG))];
            [self.view insertSubview:self.blackBG aboveSubview:self.m_tableView];
            break;
        default:
            break;
    }
}
-(void)setAllUnselected
{
    [self.labelDate setTextColor:[UIColor lightGrayColor]];
    [self.imgDate setImage:[UIImage imageNamed:@"jt_down_gray"]];
    [self.labelType setTextColor:[UIColor lightGrayColor]];
    [self.imgType setImage:[UIImage imageNamed:@"jt_down_gray"]];
}
-(void)setDate:(NSInteger)index title:(NSString *)str
{
    [self.labelDate setTextColor:[UIColor lightGrayColor]];
    [self.imgDate setImage:[UIImage imageNamed:@"jt_down_gray"]];
    self.labelDate.text=str;
    self.menuFlitrateView.hidden=YES;
    [self removeBLackBGView];
    
    switch (index)
    {
        case 0:
            self.fromDate=[MyFounctions getDateYearMonthDayWithSeperateDays:0];
            break;
        case 1:
            self.fromDate=[MyFounctions getDateYearMonthDayWithSeperateDays:-7];
            break;
        case 2:
            self.fromDate=[MyFounctions getDateYearMonthDayWithSeperateDays:-30];
            break;
        case 3:
            self.fromDate=[MyFounctions getDateYearMonthDayWithSeperateDays:-90];
            break;
        case 4:
            self.fromDate=[MyFounctions getDateYearMonthDayWithSeperateDays:-182];
            break;
        case 5:
            self.fromDate=[MyFounctions getDateYearMonthDayWithSeperateDays:-365];
            break;
        case 6:
            self.fromDate=@"";
            break;
        case 7:
            self.fromDate=@"";
            break;
            
        default:
            break;
    }
    self.pageIndex=1;
    [self updateData];
}
-(void)setType:(NSInteger)inde title:(NSString *)str
{
    [self.labelType setTextColor:[UIColor lightGrayColor]];
    [self.imgType setImage:[UIImage imageNamed:@"jt_down_gray"]];
    self.labelType.text=str;
    self.menuFlitrateView.hidden=YES;
    [self removeBLackBGView];
    
    switch (inde)
    {
        case 0:
            self.orderType=@"";
            break;
        case 1:
            self.orderType=@"CHARGE";
            break;
        case 2:
            self.orderType=@"DEPOSIT";
            break;
        case 3:
            self.orderType=@"INVEST";
            break;
        case 4:
            self.orderType=@"CAPITAL_RETURN";
            break;
        case 5:
            self.orderType=@"INTEREST_RETURN";
            break;
        case 6:
            self.orderType=@"Bonus";
            break;
        case 7:
            self.orderType=@"B_BORROW_AMT";
            break;
        default:
            break;
    }
    self.pageIndex=1;
    [self updateData];
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
