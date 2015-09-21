//
//  MycenterVC.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MycenterVC.h"
#import "MessagesVC.h"
#import "MyInfoVC.h"
#import "SettingVC.h"
#import "MyMoneyVC.h"
#import "RepaymentListVC.h"
#import "MyInvestVC.h"
#import "MyRedPackegListVC.h"
#import "ApplyRecordsListVC.h"
@interface MycenterVC ()

@end

@implementation MycenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"个人中心";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setRightNaviBtnImage:[UIImage imageNamed:@"message"]];
    [self.rightNaviBtn addTarget:self action:@selector(showMessages) forControlEvents:UIControlEventTouchUpInside];
    [self addRedPointImgOnRightBtn];
    [self updateData];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (![[MyFounctions getUserInfo] objectForKey:@"uid"])
    {
        self.labelLogin.hidden=NO;
        NSString* filePath = [NSHomeDirectory() stringByAppendingFormat:@"/head_fang/%@.jpg",self.title];
        self.imageHead.image=[[UIImage alloc]init];
        self.imageHead.image=[self.imageHead.image initWithContentsOfFile:filePath];
    }
    else{
        self.labelLogin.hidden=YES;
        if ([[MyFounctions getUserInfo] objectForKey:@"avatarUrl"]) {
            NSLog(@"avataUrl:  %@",[[MyFounctions getUserInfo] objectForKey:@"avatarUrl"]);
//            NSURL* url = [NSURL URLWithString:[[MyFounctions getUserInfo] objectForKey:@"avatarUrl"]];
//            NSData* data = [NSData dataWithContentsOfURL:url];
//            self.imageHead.image=[[UIImage alloc]initWithData:data];
            
            
            [self.imageHead setWebImageViewWithURL:[NSURL URLWithString:[[MyFounctions getUserInfo] objectForKey:@"avatarUrl"]]];
            
        }else{
            NSString* filePath = [NSHomeDirectory() stringByAppendingFormat:@"/head_fang/%@.jpg",self.title];
            self.imageHead.image=[[UIImage alloc]init];
            self.imageHead.image=[self.imageHead.image initWithContentsOfFile:filePath];

        }
                self.labelName.text=[[MyFounctions getUserInfo] objectForKey:@"realName"];
        NSString *phone=[[MyFounctions getUserInfo] objectForKey:@"mobileNo"];
        self.labelPhone.text=[NSString stringWithFormat:@"%ld******%ld",(long)[[phone substringToIndex:3] integerValue],(long)[[phone substringFromIndex:9] integerValue]];
        
        //have new message
        [self updateMessage];
    }
}
-(void)updateMessage
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
            NSArray *messageAry=[item objectForKey:@"msgList"];
            BOOL haveNewMessage=NO;
            for (NSDictionary *dic in messageAry)
            {
                if ([[dic objectForKey:@"statusText"] isEqualToString:@"未读"])
                {
                    haveNewMessage=YES;
                }
            }
            if (haveNewMessage==YES)
            {
                self.redPointImg.hidden=NO;
            }
            else
            {
                self.redPointImg.hidden=YES;
            }
        }
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)updateData
{
    if (![[MyFounctions getUserInfo] objectForKey:@"uid"])
    {
        [self presentViewController:[[JERNavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]] animated:YES completion:^{
            
        }];
        self.labelLogin.hidden=NO;
        return;
    }
    else
    {
        self.labelLogin.hidden=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------- event response
-(void)showMessages
{
    if (![[MyFounctions getUserInfo] objectForKey:@"uid"]) {
        [self presentViewController:[[JERNavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]] animated:YES completion:^{
            
        }];
        return;
    }
    MessagesVC *vc=[[MessagesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)btnPressed:(id)sender
{
    if (![[MyFounctions getUserInfo] objectForKey:@"uid"])
    {
        [self presentViewController:[[JERNavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]] animated:YES completion:^{
            
        }];
        return;
    }
    
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        MyInfoVC *vc=[[MyInfoVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==1)
    {
        MyMoneyVC *vc=[[MyMoneyVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==2)
    {
        MyInvestVC *vc=[[MyInvestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==3)
    {
        ApplyRecordsListVC *vc=[[ApplyRecordsListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==4)
    {
        RepaymentListVC *vc=[[RepaymentListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==5)
    {
        MyRedPackegListVC *vc=[[MyRedPackegListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (btn.tag==6)
    {
        SettingVC *vc=[[SettingVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
