//
//  LicaiListVC.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LicaiListVC.h"
#import "HomeLicaiCell0.h"
#import "HomeLicaiCell1.h"
#import "LicaiDetailVC.h"
#import "JiekuanTopCell.h"
#import "JiekuanCell2.h"
#import "JiekuanConditionVC.h"
#import "LicaiFiltrateVC.h"
#import "ConfirmLicaiVC.h"
#import "BorrowSuccessVC.h"
@interface LicaiListVC ()

@end

@implementation LicaiListVC
@synthesize borrowPreData,borrowType,m_aryMonths,pickerView,doneBtn,shieldView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.borrowType=0;
    self.title=@"易理财";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    
    self.m_aryDatas=[NSMutableArray array];
    self.m_dicInput=[NSMutableDictionary dictionary];
    if(self.indexFlag==0)
    {
        self.m_showedDatas=[NSMutableArray array];
    }
    else
    {
        self.m_showedDatas=[NSMutableArray arrayWithObjects:@"jiekuan0",@"jiekuan1", nil];
    }

    self.m_dicTypes=[NSMutableDictionary dictionaryWithObjects:@[@"",@"",@"",@"",@""] forKeys:@[@"investType",@"projectType",@"projectPeriod",@"projectRate",@"creditLevel"]];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 40, Screen_Width, Screen_Height-64-40-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self setupHeader];
    [self setupFooter];
    
    [self updateData];
    
    self.m_aryMonths=[NSMutableArray arrayWithObjects:@"3个月",@"4个月",@"5个月",@"6个月", nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------- uipicker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.m_aryMonths.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str=[self.m_aryMonths objectAtIndex:row];
    return str;
}
-(void)creatPickerView
{
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
    
    //        self.shieldView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-PARENT_Y(doneBtn))];
    //        [self.shieldView setBackgroundColor:[UIColor clearColor]];
    //        [self.view addSubview:self.shieldView];
    
}
-(void)selectDone
{
    NSInteger index= [self.pickerView selectedRowInComponent:0];
    self.selectedMonth=index;
    [self.m_jiekuancell2 showSelectedMonth:[self.m_aryMonths objectAtIndex:self.selectedMonth]];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    [self.shieldView removeFromSuperview];
    self.shieldView=nil;
}

-(void)updateData
{
    NSMutableDictionary *paras_fource = [NSMutableDictionary dictionary];
    [paras_fource setObject:SH_ProductListByType forKey:SH_LINK];
//    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] forKey:SH_PAGE_CURRENTPAGE];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageCount] forKey:SH_PAGE_RECORDSPERPAGE];
    for (NSString *str in [self.m_dicTypes allKeys])
    {
        [paras_fource setObject:[self.m_dicTypes objectForKey:str] forKey:str];
    }
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ProductListByType;
    [self.SHRequest_ startAsynchronous];
}
-(void)getBorrowPreData
{
    NSString *borrowTypeStr=@"";
    switch (self.borrowType) {
        case 0:
            borrowTypeStr=@"CREDIT";
            break;
        case 1:
            borrowTypeStr=@"MORTGAGE";
            break;
        case 2:
            borrowTypeStr=@"GUARANTEE";
            break;
        default:
            break;
    }

    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_BorrowPre forKey:SH_LINK];
    [paras_fource setObject:borrowTypeStr forKey:@"borrowType"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_BorrowPre;
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
        if ([self.currentRequest isEqualToString:SH_ProductListByType])//product
        {
            if(![[item objectForKey:@"projects"] isEqual:[NSNull null]])
            {
                NSArray *array=[item objectForKey:@"projects"];
                if (self.pageIndex==1)
                {
                    [self.m_aryDatas removeAllObjects];
                }
                [self.m_aryDatas addObjectsFromArray:array];
                [self.m_showedDatas removeAllObjects];
                
                NSInteger i=0;
                while (i<self.m_aryDatas.count)
                {
                    [self.m_showedDatas addObject:@"cell0"];
                    i++;
                }
                [self.m_tableView reloadData];
            }
            else
            {
                NSArray *array=[NSArray array];
                if (self.pageIndex==1)
                {
                    [self.m_aryDatas removeAllObjects];
                }
                [self.m_aryDatas addObjectsFromArray:array];
                [self.m_showedDatas removeAllObjects];
                
                NSInteger i=0;
                while (i<self.m_aryDatas.count)
                {
                    [self.m_showedDatas addObject:@"cell0"];
                    i++;
                }
                [self.m_tableView reloadData];
            }
            
        }
        else if([self.currentRequest isEqualToString:SH_BorrowPre])
        {
            self.borrowPreData=item;
            self.borrowAmtMax=[[[self.borrowPreData objectForKey:@"product"] objectForKey:@"borrowAmtMax"] floatValue];
            self.borrowAmtMin=[[[self.borrowPreData objectForKey:@"product"] objectForKey:@"borrowAmtMin"] floatValue];
        }
        else if ([self.currentRequest isEqualToString:SH_ApplyBorrow])
        {
            BorrowSuccessVC *vc=[[BorrowSuccessVC alloc] init];
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
- (void)failWithError:(NSError *)theError
{
    NSLog(@"error :%@",theError);
}

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_showedDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell0"])
    {
        HomeLicaiCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeLicaiCell0"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"HomeLicaiCell0" owner:nil options:nil] objectAtIndex:0];
        }
        
        
        NSInteger i=0;
        NSInteger count=0;
        while (i<=indexPath.row)
        {
            if ([[self.m_showedDatas objectAtIndex:i] isEqualToString:@"cell0"])
            {
                count++;
            }
            i++;
        }
        cell.data=[self.m_aryDatas objectAtIndex:count-1];
        [cell updateViews];
        return cell;
    }
    else if([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell1"])
    {
        HomeLicaiCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeLicaiCell1"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"HomeLicaiCell1" owner:nil options:nil] objectAtIndex:0];
            cell.licaiListDelegate=self;
        }
        //update data and view
        NSInteger i=0;
        NSInteger count=0;
        while (i<=indexPath.row)
        {
            if ([[self.m_showedDatas objectAtIndex:i] isEqualToString:@"cell0"])
            {
                count++;
            }
            i++;
        }
        cell.data=[self.m_aryDatas objectAtIndex:count-1];
        cell.index=count-1;
        [cell updateViews];
        
        return cell;
        
    }
    else if([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"jiekuan0"])
    {
        JiekuanTopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"JiekuanTopCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"JiekuanTopCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.delegate=self;
        return cell;
        
    }
    else if([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"jiekuan1"])
    {
        JiekuanCell2 *cell=[[[NSBundle mainBundle] loadNibNamed:@"JiekuanCell2" owner:nil options:nil] objectAtIndex:0];
        self.m_jiekuancell2=cell;
        cell.borrowType=self.borrowType;
      //  NSLog(@"m_cell:%@",[[self.m_showedDatas objectAtIndex:indexPath.row] objectForKey:@"applyRequired"]);
      //  cell.labelDir.text=[[self.m_showedDatas objectAtIndex:indexPath.row] objectForKey:@"applyRequired"];
        [cell changeJiekuanTypeSmall];
        cell.delegate=self;
        [cell updateViews];
        return cell;
        
    }
    else if([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"jiekuan2"])
    {
    
        JiekuanCell2 *cell=[[[NSBundle mainBundle] loadNibNamed:@"JiekuanCell2" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        cell.borrowType=self.borrowType;
        [cell updateViews];
        return cell;
        
    }
    else
    {
        return [[UITableViewCell alloc] init];
    }

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell0"])
    {
        height=130;
    }
    else if([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell1"])
    {
        height=90;
    }
    else if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"jiekuan0"])
    {
        height=55;
    }
    else if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"jiekuan1"])
    {
        height=460;
    }
    else if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"jiekuan2"])
    {
        height=500;
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell0"])
    {
        [self showDetail:indexPath.row];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.indexFlag==0)
    {
        return 30;
    }
    else
    {
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.indexFlag==0)
    {
        UIView *sectionbg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
        [sectionbg setBackgroundColor:JER_BG_GRAY];
        UILabel *labelFiltrate=[[UILabel alloc] initWithFrame:sectionbg.frame];
        [labelFiltrate setText:@"筛选更多>"];
        [labelFiltrate setTextAlignment:NSTextAlignmentRight];
        [labelFiltrate setFont:[UIFont systemFontOfSize:13.0]];
        [labelFiltrate setTextColor:[UIColor grayColor]];
        [sectionbg addSubview:labelFiltrate];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:labelFiltrate.frame];
        [btn addTarget:self action:@selector(showFiltrateVC) forControlEvents:UIControlEventTouchUpInside];
        [sectionbg addSubview:btn];
        return sectionbg;
    }
    else
    {
        return nil;
    }
}

-(void)headerRefresh
{
    self.pageIndex=1;
    if ([self.currentRequest isEqualToString:SH_ProductListByType])
    {
        [self updateData];
    }
}
-(void)footerRefresh
{
    self.pageIndex++;
    if ([self.currentRequest isEqualToString:SH_ProductListByType])
    {
        [self updateData];
    }
}


#pragma mark -------------- detail expand
-(void)showDetail:(NSInteger)index
{
    if (index+1<self.m_showedDatas.count&&[[self.m_showedDatas objectAtIndex:index+1] isEqualToString:@"cell1"])
    {
        [self hideDetail:index];
    }
    else
    {
        
        if (index<self.m_showedDatas.count-1)
        {
            [self.m_showedDatas insertObject:@"cell1" atIndex:index+1];
        }
        else
        {
            [self.m_showedDatas addObject:@"cell1"];
        }
        NSArray *insertIndexPaths = [NSArray arrayWithObjects:
                                     [NSIndexPath indexPathForRow:index+1 inSection:0],
                                     nil];
        [self.m_tableView beginUpdates];
        [self.m_tableView insertRowsAtIndexPaths:insertIndexPaths
                                withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.m_tableView endUpdates];
    }
    
}
-(void)hideDetail:(NSInteger)index
{
    
    [self.m_showedDatas removeObjectAtIndex:index+1];
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:
                                 [NSIndexPath indexPathForRow:index+1 inSection:0],
                                 nil];
    [self.m_tableView beginUpdates];
    [self.m_tableView deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.m_tableView endUpdates];
    
}

#pragma mark -------- event response
-(IBAction)licai:(id)sender
{
    self.indexFlag=0;
    [self.label_lc setTextColor:JER_RED];
    [self.label_jk setTextColor:[UIColor darkGrayColor]];
    [self.lineView_l setBackgroundColor:JER_RED];
    [self.lineView_r setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.m_aryDatas removeAllObjects];
    [self.m_showedDatas removeAllObjects];
    self.pageIndex=1;
    [self updateData];
    if (![self.refreshHeader superview])
    {
        [self setupHeader];
        [self setupFooter];
    }
    
}
-(IBAction)jiekuan:(id)sender
{
    self.indexFlag=1;
    [self.label_lc setTextColor:[UIColor darkGrayColor]];
    [self.label_jk setTextColor:JER_RED];
    [self.lineView_l setBackgroundColor:[UIColor lightGrayColor]];
    [self.lineView_r setBackgroundColor:JER_RED];
    self.m_showedDatas=[NSMutableArray arrayWithObjects:@"jiekuan0",@"jiekuan1", nil];
    
    [self jiekuanTypeChange:self.borrowType];
    
    [self.refreshHeader removeFromSuperview];
    [self.refreshFooter removeFromSuperview];
    self.refreshHeader=nil;
    self.refreshFooter=nil;
}
-(void)showFiltrateVC
{
    LicaiFiltrateVC *vc=[[LicaiFiltrateVC alloc] init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showLicaiDetailVC:(NSString*)projNo
{
    LicaiDetailVC *vc=[[LicaiDetailVC alloc] init];
    vc.projNo=projNo;
    [vc updateData];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)bidLicai:(NSString*)projNo
{
    if([[MyFounctions getUserInfo] objectForKey:@"mobileNo"])
    {
        ConfirmLicaiVC *vc=[[ConfirmLicaiVC alloc] init];
        vc.projNo=projNo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        LoginVC *vc=[[LoginVC alloc] init];
        [self presentViewController:[[JERNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
            
        }];
    }
}

-(void)jiekuanTypeChange:(NSInteger)index
{
    if(index==0)
    {
        self.borrowType=0;
        [self.m_showedDatas removeAllObjects];
        self.m_showedDatas=[NSMutableArray arrayWithObjects:@"jiekuan0",@"jiekuan1", nil];
    }
    else if (index==1)
    {
        self.borrowType=1;
        self.m_showedDatas=[NSMutableArray arrayWithObjects:@"jiekuan0",@"jiekuan2", nil];
    }
    else if (index==2)
    {
        self.borrowType=2;
        self.m_showedDatas=[NSMutableArray arrayWithObjects:@"jiekuan0",@"jiekuan1", nil];
    }
    [self getBorrowPreData];
    [self.m_tableView reloadData];
}
-(void)showJiekuanCondition
{
    JiekuanConditionVC *vc=[[JiekuanConditionVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)appleBorrow:(NSDictionary*)applyData
{
    if ([[applyData objectForKey:@"borrowApply.borrowAmt"] floatValue]<self.borrowAmtMin||[[applyData objectForKey:@"borrowApply.borrowAmt"] floatValue]>self.borrowAmtMax)
    {
        [self showMessage:[NSString stringWithFormat:@"该类型借贷金额需在¥%.f-¥%.f之间",self.borrowAmtMin,self.borrowAmtMax]];
        return;
    }
    
    NSMutableDictionary *paras_fource = [NSMutableDictionary dictionaryWithDictionary:applyData];
    [paras_fource setObject:SH_ApplyBorrow forKey:SH_LINK];
    [paras_fource setObject:@"FIRST_INTEREST_LAST_CAPITAL" forKey:@"borrowApply.repaymentType"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ApplyBorrow;
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
