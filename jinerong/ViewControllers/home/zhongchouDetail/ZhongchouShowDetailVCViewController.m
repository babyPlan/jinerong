//
//  ZhongchouShowDetailVCViewController.m
//  jinerong
//
//  Created by zhaoml on 15/7/23.
//  Copyright (c) 2015年 qinyun. All rights reserved.
//

#import "ZhongchouShowDetailVCViewController.h"
#import "showCell0.h"
@interface ZhongchouShowDetailVCViewController ()

@end

@implementation ZhongchouShowDetailVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"项目详情";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view from its nib.
    
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    NSLog(@"detaildata:%@",self.m_detailData);
   // NSLog(@"Pic:%@",[[self.data objectForKey:@"cfRecord"] objectForKey:@"crowdfundingPicBig"]);
   // [self.image setWebImageViewWithURL:[NSURL URLWithString:[[self.data objectForKey:@"cfRecord"] objectForKey:@"crowdfundingPicBig"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)updateData{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_ZhongchouMore forKey:SH_LINK];
    [paras_fource setObject:self.crowdFundingId forKey:@"crowdFundingId"];
  //  [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"] ;
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ZhongchouMore;
    [self.SHRequest_ startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseString = [request responseString];
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        self.m_detailData=[[item objectForKey:@"productList"] objectAtIndex:0];
        NSLog(@"%@",self.m_detailData);
        [self.m_tableView reloadData];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    showCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"showCell0"];
    if (cell==nil)
    {
        
        cell=[[[NSBundle mainBundle] loadNibNamed:@"showCell0" owner:nil options:nil] objectAtIndex:0];
                NSLog(@"%@",[self.m_detailData valueForKey:@"productPicUrl"]);
                cell.data=self.m_detailData ;
                [cell updateViews];
        
    }
    return cell;
    
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
