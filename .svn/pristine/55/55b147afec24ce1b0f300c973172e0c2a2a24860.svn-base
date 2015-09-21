//
//  BankListVC.m
//  jinerong
//
//  Created by carcool on 6/18/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "BankListVC.h"
#import "BankListCell.h"
#import "BindBankCardVC.h"
@interface BankListVC ()

@end

@implementation BankListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择银行卡";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"保存"];
    [self.rightNaviBtn addTarget:self action:@selector(saveTheSelected) forControlEvents:UIControlEventTouchUpInside];
    self.selectedIndex=-1;
    self.m_searchBar.delegate=self;
    [self.m_searchBar setSearchBarStyle:UISearchBarStyleProminent];
    [self searchBarTextDidBeginEditing:self.m_searchBar];
    
    self.m_aryBanks=[NSMutableArray array];
    self.m_aryShowedBanks=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 44, Screen_Width, Screen_Height-64-49-44)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
    [self getCashBanks];
}
-(void)getCashBanks
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetCashBanks forKey:SH_LINK];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetCashBanks;
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
        if ([self.currentRequest isEqualToString:SH_GetCashBanks])
        {
            [self.m_aryBanks addObjectsFromArray:[item objectForKey:@"banks"]];
            [self.m_aryShowedBanks addObjectsFromArray:self.m_aryBanks];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------- search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (![self.m_searchBar.text isEqualToString:@""])
    {
        [self searchBank:self.m_searchBar.text];
    }
    else
    {
        [self.m_aryShowedBanks removeAllObjects];
        [self.m_aryShowedBanks addObjectsFromArray:self.m_aryBanks];
        [self.m_tableView reloadData];
    }
    [self.m_searchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    for(id cc in [searchBar.subviews[0] subviews])
    {
        for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
            if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
                UIButton * cancel =(UIButton *)view;
                [cancel setTitle:@"取消" forState:UIControlStateNormal];
                [cancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [cancel.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            }
        }
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    if ([self.m_searchBar.text isEqualToString:@""])
    {
        [self.m_aryShowedBanks removeAllObjects];
        [self.m_aryShowedBanks addObjectsFromArray:self.m_aryBanks];
        [self.m_tableView reloadData];
    }
    [self.m_searchBar resignFirstResponder];
}
-(void)searchBank:(NSString*)bankname
{
    [self.m_aryShowedBanks removeAllObjects];
    for (NSDictionary *dic in self.m_aryBanks)
    {
        if ([[dic objectForKey:@"bankName"] rangeOfString:bankname].location!=NSNotFound)
        {
            [self.m_aryShowedBanks addObject:dic];
        }
    }
    [self.m_tableView reloadData];
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryShowedBanks.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BankListCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BankListCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.labelName.text=[[self.m_aryShowedBanks objectAtIndex:indexPath.row] objectForKey:@"bankName"];
    cell.index=indexPath.row;
    if (self.selectedIndex==indexPath.row)
    {
        [cell.imgGou setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
    else
    {
        [cell.imgGou setImage:[UIImage imageNamed:@"circle"]];
    }
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
    self.selectedIndex=indexPath.row;
    [self.m_tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ----- event response
-(void)saveTheSelected
{
    if (self.selectedIndex>=0)
    {
        self.delegate.m_dicBank=[self.m_aryShowedBanks objectAtIndex:self.selectedIndex];
        self.delegate.labelBank.text=[self.delegate.m_dicBank objectForKey:@"bankName"];
        [self popSelfViewContriller];
    }
    else
    {
        [self showMessage:@"请选择要绑定的银行"];
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
