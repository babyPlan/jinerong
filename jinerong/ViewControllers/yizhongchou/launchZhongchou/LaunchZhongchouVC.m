//
//  LaunchZhongchouVC.m
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LaunchZhongchouVC.h"
#import "LaunchZhongchouCell.h"
#import "SelectProvinceVC.h"
@interface LaunchZhongchouVC ()

@end

@implementation LaunchZhongchouVC
@synthesize m_cell;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"发起众筹";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)launchZhongchou:(NSDictionary*)launchData
{
    NSMutableDictionary *paras_fource = [NSMutableDictionary dictionary];
    [paras_fource setObject:SH_LaunchZhongchou forKey:SH_LINK];
    for (NSString *key in [launchData allKeys])
    {
        [paras_fource setObject:[launchData objectForKey:key] forKey:key];
    }
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_LaunchZhongchou;
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
        if ([self.currentRequest isEqualToString:SH_LaunchZhongchou])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发起众筹成功，等待审核" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag=11;
            [alert show];
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
    self.m_cell=[[[NSBundle mainBundle] loadNibNamed:@"LaunchZhongchouCell" owner:nil options:nil] objectAtIndex:0];
    m_cell.delegate=self;
    self.m_cell.province=self.province;
    self.m_cell.city=self.city;
    [self.m_cell updateViews];
    return m_cell;
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
#pragma mark -------- select city delegate
-(void)selecteProvince:(NSDictionary *)province city:(NSDictionary *)city
{
    self.province=province;
    self.city=city;
    self.m_cell.province=self.province;
    self.m_cell.city=self.city;
    [self.m_cell updateViews];
}
#pragma mark ---------- event response
-(void)showSelectRegionsVC
{
    SelectProvinceVC *vc=[[SelectProvinceVC alloc]init];
    vc.delegate=self;
    [self presentViewController:[[JERNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
        
    }];
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
