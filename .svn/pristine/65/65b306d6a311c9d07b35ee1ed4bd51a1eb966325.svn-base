//
//  RegisterVC2.m
//  jinerong
//
//  Created by carcool on 6/3/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RegisterVC2.h"
#import "Register2Cell.h"
@interface RegisterVC2 ()

@end

@implementation RegisterVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"注册";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    
//    [self.labelWebSite setFrame:CGRectMake(0,Screen_Height-64-30 , PARENT_WIDTH(self.labelWebSite), PARENT_HEIGHT(self.labelWebSite))];
//    [self.m_tableView addSubview:self.labelWebSite];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======== request delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        if ([self.currentRequest isEqualToString:SH_REGISTER])
        {
            [self showMessage:@"注册成功"];
            [self performSelector:@selector(popToRootVC) withObject:nil afterDelay:1.5];
        }
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)popToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Register2Cell *cell=[[[NSBundle mainBundle] loadNibNamed:@"Register2Cell" owner:nil options:nil] objectAtIndex:0];
    cell.delegate=self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 410;
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
-(void)registerBtnPressedPassword:(NSString*)paassword name:(NSString*)name idengtifyCard:(NSString*)ID
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_REGISTER forKey:SH_LINK];
    [paras_fource setObject:self.phone forKey:@"mobileNo"];
    [paras_fource setObject:@"" forKey:@"nickName"];
    [paras_fource setObject:name forKey:@"realName"];
    [paras_fource setObject:ID forKey:@"idCardNo"];
    [paras_fource setObject:[SHAPI md5:paassword] forKey:@"password"];
    [paras_fource setObject:self.promotingMan forKey:@"referrer"];
    [paras_fource setObject:[MyFounctions getIPAddress:YES] forKey:@"ip"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_REGISTER;
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
