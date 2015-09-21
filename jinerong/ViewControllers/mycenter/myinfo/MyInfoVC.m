//
//  MyInfoVC.m
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyInfoVC.h"
#import "MyInfoCell0.h"
#import "MyInfoCell1.h"
#import "MyInfoCell2.h"
#import "CLLockVC.h"
#import "EditInfoVC.h"
#import "EditNickNameVC.h"
#import "RealNameVerifyVC.h"
#import "BundlePhoneLoginVC.h"
@interface MyInfoVC ()

@end

@implementation MyInfoVC
@synthesize m_aryTitles,picker;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"个人信息";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryTitles=[NSMutableArray arrayWithObjects:@"昵称",@"实名认证",@"绑定手机",@"登录密码",@"支付密码",@"手势密码", nil];
    
    [self addTableView];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];

}
-(void)viewDidAppear:(BOOL)animated
{
    [self.m_tableView reloadData];
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
        if ([self.currentRequest isEqualToString:SH_UploadPortrait])
        {
            [self showMessage:@"上传成功"];
            //change avatar url
            NSMutableDictionary *user=(NSMutableDictionary*)[MyFounctions getUserInfo];
            [user setObject:[item objectForKey:@"imageUrl"] forKey:@"avatarUrl"];
            [MyFounctions saveUserInfo:(NSDictionary*)user];
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
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        MyInfoCell0 *cell=[[[NSBundle mainBundle] loadNibNamed:@"MyInfoCell0" owner:nil options:nil] objectAtIndex:0];
        if(![[[MyFounctions getUserInfo] objectForKey:@"avatarUrl"] isEqual:[NSNull null]])
        {
             [cell.headImg setWebImageViewWithURL:[NSURL URLWithString:[[MyFounctions getUserInfo] objectForKey:@"avatarUrl"]]];
        }
       
        return cell;
    }
    else if(2<=indexPath.row&&indexPath.row<=8&&indexPath.row!=5)
    {
        MyInfoCell1 *cell=[[[NSBundle mainBundle] loadNibNamed:@"MyInfoCell1" owner:nil options:nil] objectAtIndex:0];
        if (indexPath.row<5)
        {
            cell.labelTitle.text=[m_aryTitles objectAtIndex:indexPath.row-2];
            if (indexPath.row==2)
            {
                cell.labelState.text=[[MyFounctions getUserInfo] objectForKey:@"nickName"];
            }
            else if (indexPath.row==3)
            {
                cell.labelState.text=@"已认证";
            }
            else if (indexPath.row==4)
            {
                if ([[MyFounctions getUserInfo] objectForKey:@"mobileNo"]) {
                    cell.labelState.text=@"已绑定";
                }else {
                    cell.labelState.text=@"未绑定"; 
                }
            }
        }
        else
        {
            cell.labelTitle.text=[m_aryTitles objectAtIndex:indexPath.row-3];
            cell.labelState.hidden=YES;
        }
        
        return cell;
    }
    else if (indexPath.row==1||indexPath.row==5)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        MyInfoCell2 *cell=[[[NSBundle mainBundle] loadNibNamed:@"MyInfoCell2" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=70;
    }
    else if(2<=indexPath.row&&indexPath.row<=8&&indexPath.row!=5)
    {
        height=40;
    }
    else if(indexPath.row==1||indexPath.row==5)
    {
        height=10;
    }
    else
    {
        height=75;
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0)
    {
        [self performSelectorOnMainThread:@selector(showLoadingWithBG) withObject:nil waitUntilDone:NO];
        [self performSelector:@selector(showPickVC) withObject:nil afterDelay:1.0];
    }
    else if (indexPath.row==2)
    {
        //EditNickNameVC *vc=[[EditNickNameVC alloc] init];
        //[self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==3)
    {
        RealNameVerifyVC *vc=[[RealNameVerifyVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==4)
    {
        BundlePhoneLoginVC *vc=[[BundlePhoneLoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(4<indexPath.row&&indexPath.row<8&&indexPath.row!=5)
    {
        EditInfoVC *vc=[[EditInfoVC alloc] init];
        if (indexPath.row<5)
        {
            vc.editFlag=indexPath.row-2;
        }
        else
        {
            vc.editFlag=indexPath.row-3;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==8)
    {
        [self setPwd:nil];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)showPickVC
{
    self.picker=nil;
    self.picker = [[UIImagePickerController alloc]init];
    picker.view.backgroundColor = [UIColor orangeColor];
    UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.sourceType = sourcheType;
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:^{
        [self stopLoadingWithBG];
    }];

}
#pragma mark ------ uiimagepickercontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* img = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *dataimg = UIImageJPEGRepresentation(img, 1.0);
    //upload image
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_UploadPortrait forKey:SH_LINK];
    [paras_fource setObject:[[MyFounctions getUserInfo] objectForKey:@"uid"] forKey:@"uid"];
    [paras_fource setObject:@"myPortrait" forKey:@"imageName"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ addData:dataimg withFileName:@"jpg" andContentType:@"image/png" forKey:@"image"];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_UploadPortrait;
    [self.SHRequest_ startAsynchronous];
    
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark ------ event response
/*
 *  设置密码
 */
- (IBAction)setPwd:(id)sender {
    
    
    BOOL hasPwd = [CLLockVC hasPwd];
    hasPwd = NO;
    if(hasPwd){
        
        NSLog(@"已经设置过密码了，你可以验证或者修改密码");
    }else{
        
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            NSLog(@"密码设置成功");
            [lockVC dismiss:1.0f];
        }];
    }
}
-(void)logoutUser
{
    [MyFounctions removeUserInfo];
    [self popSelfViewContriller];
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
