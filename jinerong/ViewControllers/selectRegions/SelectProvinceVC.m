//
//  SelectProvinceVC.m
//  jinerong
//
//  Created by carcool on 7/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SelectProvinceVC.h"
#import "SelectCityCell.h"
#import "SelectCityVC.h"
@interface SelectProvinceVC ()

@end

@implementation SelectProvinceVC
@synthesize m_aryRegions;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"选择省份";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(dismissSelfVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryRegions=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
    [self getRegions];
}
-(void)dismissSelfVC
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)completeSelectCity:(NSDictionary*)city
{
    [self.delegate selecteProvince:self.m_province city:city];
    [self dismissSelfVC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getRegions
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetRegions forKey:SH_LINK];
    [paras_fource setObject:@"" forKey:@"parentCode"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetRegions;
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
        if ([self.currentRequest isEqualToString:SH_GetRegions])//adver pictures
        {
            [self.m_aryRegions removeAllObjects];
            [self.m_aryRegions addObjectsFromArray:[item objectForKey:@"regions"]];
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
    return self.m_aryRegions.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCityCell *cell= [tableView dequeueReusableCellWithIdentifier:@"SelectCityCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SelectCityCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.data=[self.m_aryRegions objectAtIndex:indexPath.row];
    [cell updateViews];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SelectCityVC *vc=[[SelectCityVC alloc] init];
    vc.delegate=self;
    vc.provinceData=[self.m_aryRegions objectAtIndex:indexPath.row];
    self.m_province=[self.m_aryRegions objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
