//
//  SettingVC.m
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SettingVC.h"
#import "MyInfoCell1.h"
#import "SuggestVC.h"
#import "UIImageView+WebCache.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "aboutUsVC.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"个人信息";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryTitles=[NSMutableArray arrayWithObjects:@"意见反馈",@"推荐",@"清除缓存",@"关于我们", nil];
    
    [self addTableView];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setScrollEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryTitles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoCell1 *cell=[[[NSBundle mainBundle] loadNibNamed:@"MyInfoCell1" owner:nil options:nil] objectAtIndex:0];
    cell.labelTitle.text=[self.m_aryTitles objectAtIndex:indexPath.row];
    cell.labelState.hidden=YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        SuggestVC *vc=[[SuggestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==1) {
        //创建分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"金E融，提高你的生活质量"
                                         images:@[[UIImage imageNamed:@"weixin"]]
                                            url:[NSURL URLWithString:@"http://www.efin5.com/invest/help/downApp.action"]
                                          title:@"金E融！"
                                           type:SSDKContentTypeImage];
        [shareParams SSDKSetupWeChatParamsByText:@"金E融，提高你的生活质量"
                                           title:@"金E融！"    url:[NSURL URLWithString:@"http://www.efin5.com/invest/help/downApp.action"]
                                      thumbImage:@[[UIImage imageNamed:@"weixin"]]    image:@[[UIImage imageNamed:@"weixin"]]
                                    musicFileURL:nil
                                         extInfo:@"exInfo"
                                        fileData:nil
                                    emoticonData:nil
                                            type:SSDKContentTypeWebPage
                              forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
        
        
        //进行分享
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state,SSDKPlatformType platformType,NSDictionary *userdata,SSDKContentEntity *contentEntity,NSError *error,BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@", error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateCancel:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           default:
                               break;
                       }
                       
                   }];
        
    }
    if (indexPath.row==2) {
        [self showMessage:@"警告"];
           }
    if (indexPath.row==3) {
        aboutUsVC* vc = [[aboutUsVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)showMessage:(NSString *)str{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    // 获取tmp目录路径
    NSString *tmpDir =  NSTemporaryDirectory();
    NSString * num= [NSString stringWithFormat:@"%.2f M",[SettingVC folderSizeAtPath:cachesDir]+[SettingVC folderSizeAtPath:tmpDir]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:[NSString stringWithFormat:@"确定清除%@缓存？",num] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    // 获取tmp目录路径
    NSString *tmpDir =  NSTemporaryDirectory();
    
    switch (buttonIndex) {
        case 1:
            [SettingVC clearCache:cachesDir];
            [SettingVC clearCache:tmpDir];
            break;
        default:
            break;
    }
    
}
#pragma mark - Cache

+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
        if ([fileManager fileExistsAtPath:path]) {
            NSArray *childerFiles=[fileManager subpathsAtPath:path];
                for (NSString *fileName in childerFiles) {
                    NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                        folderSize +=[self fileSizeAtPath:absolutePath];
                    }
            //SDWebImage框架自身计算缓存的实现
                    folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
                return folderSize;
            }
        return 0;
}
+(void)clearCache:(NSString *)path{
        NSFileManager *fileManager=[NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:path]) {
                NSArray *childerFiles=[fileManager subpathsAtPath:path];
                for (NSString *fileName in childerFiles) {
                    //如有需要，加入条件，过滤掉不想删除的文件
                    NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                    [fileManager removeItemAtPath:absolutePath error:nil];
                    }
                }
        [[SDImageCache sharedImageCache] cleanDisk];
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
