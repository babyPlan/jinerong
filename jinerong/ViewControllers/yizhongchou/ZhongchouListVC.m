//
//  ZhongchouListVC.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ZhongchouListVC.h"
#import "ZCListCell.h"
#import "ZhongchouDetailVC.h"
#import "ZCListTopCell.h"
#import "MenuSectionView.h"
#import "LaunchZhongchouVC.h"
@interface ZhongchouListVC ()

@end

@implementation ZhongchouListVC
@synthesize selectedType,m_aryDatas;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"易众筹";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.bg.userInteractionEnabled=YES;
    self.view.userInteractionEnabled=YES;
    self.selectedType=0;
    self.m_aryDatas=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-49-64)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    [self setupHeader];
    [self setupFooter];
    
    [self updateData];
    [self updateCarousels];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_FiltrateZhongchou forKey:SH_LINK];
    [paras_fource setObject:@"" forKey:@"amt"];
    [paras_fource setObject:[self getSelectedTypeString] forKey:@"type"];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] forKey:SH_PAGE_CURRENTPAGE];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageCount] forKey:SH_PAGE_RECORDSPERPAGE];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_FiltrateZhongchou;
    [self.SHRequest_ startAsynchronous];
}
-(void)updateCarousels
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_CAROUSELS forKey:SH_LINK];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_CAROUSELS;
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
        if ([self.currentRequest isEqualToString:SH_FiltrateZhongchou])//adver pictures
        {
            NSArray *array=[item objectForKey:@"crowdFundings"];
            if (self.pageIndex==1)
            {
                [self.m_aryDatas removeAllObjects];
            }
            [self.m_aryDatas addObjectsFromArray:array];
            [self.m_tableView reloadData];
        }
        else if ([self.currentRequest isEqualToString:SH_CAROUSELS])//adver pictures
        {
            self.m_aryAdvers=[NSMutableArray arrayWithArray:[item objectForKey:@"list"]];
            
            NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
            [paras_fource setObject:SH_FiltrateZhongchou forKey:SH_LINK];
            [paras_fource setObject:@"" forKey:@"amt"];
            [paras_fource setObject:[self getSelectedTypeString] forKey:@"type"];
            [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] forKey:SH_PAGE_CURRENTPAGE];
            [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageCount] forKey:SH_PAGE_RECORDSPERPAGE];
            self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
            [self.SHRequest_ setDelegate:self];
            self.currentRequest=SH_FiltrateZhongchou;
            [self.SHRequest_ startAsynchronous];
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
    if (section==0)
    {
        return 1;
    }
    else
    {
        return self.m_aryDatas.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        ZCListTopCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZCListTopCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ZCListTopCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.m_aryAdvers=self.m_aryAdvers;
        [cell creatPageScrollview];
        return cell;
    }
    else
    {
        ZCListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZCListCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ZCListCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=[self.m_aryDatas objectAtIndex:indexPath.row];
        [cell updateViews];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 160;
    }
    else
    {
        return 115;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        ZhongchouDetailVC *vc=[[ZhongchouDetailVC alloc] init];
        vc.crowdFundingId=[[self.m_aryDatas objectAtIndex:indexPath.row] objectForKey:@"id"];
        [vc updateData];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        return 0;
    }
    else
    {
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        MenuSectionView *sec=[[[NSBundle mainBundle] loadNibNamed:@"MenuSectionView" owner:nil options:nil] objectAtIndex:0];
        sec.delegate=self;
        [sec setSelectedViews:self.selectedType];
        return sec;
    }
    else
    {
        return nil;
    }
}

#pragma  mark ------ refresh delegate
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
#pragma mark ======== event response
-(void)launchZhongchou
{
    LaunchZhongchouVC *vc=[[LaunchZhongchouVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSString*)getSelectedTypeString
{
    NSString *type=@"";
    switch (self.selectedType)
    {
        case 0:
            type=@"";
            break;
        case 1:
            type=@"TECH";
            break;
        case 2:
            type=@"COMMON_WEAL";
            break;
        case 3:
            type=@"CREATIVE";
            break;
        case 4:
            type=@"LIFE";
            break;
        case 5:
            type=@"ART";
            break;
        case 6:
            type=@"AGRICULTURE";
            break;
        case 7:
            type=@"DREAMS";
            break;
        case 8:
            type=@"OTHERS";
            break;
        default:
            break;
    }
    return type;
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
