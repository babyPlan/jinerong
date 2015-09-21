//
//  MessagesVC.m
//  jinerong
//
//  Created by carcool on 7/15/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MessagesVC.h"
#import "MessageCell.h"
#import "MessageDetailVC.h"
@interface MessagesVC ()

@end

@implementation MessagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"消息";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryMessages=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateData];
}
-(void)updateData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_GetMessageList forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:@"all" forKey:@"msgType"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_GetMessageList;
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
        if ([self.currentRequest isEqualToString:SH_GetMessageList])
        {
            self.m_aryMessages=[item objectForKey:@"msgList"];
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
    return self.m_aryMessages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.data=[self.m_aryMessages objectAtIndex:indexPath.row];
    [cell updateViews];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageDetailVC *vc=[[MessageDetailVC alloc] init];
    vc.data=[self.m_aryMessages objectAtIndex:indexPath.row];
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
