//
//  AppDelegate.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "myTabbarVC.h"
#import "JERNavigationController.h"
#import "LicaiListVC.h"
#import "ZhongchouListVC.h"
#import "MycenterVC.h"
#import "CLLockVC.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <ShareSDKConnector/ShareSDKConnector.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //tabbar
    self.tabBarController = [[myTabbarVC alloc] init];
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *item = [NSArray arrayWithObjects:@"首页",@"易理财",@"易众筹",@"我",nil];
    
    NSInteger count = [item count];
    for (int i = 0; i < count; i++)
    {
        switch (i)
        {
            case 0:
            {
                
                JERNavigationController *nav=[[JERNavigationController alloc] initWithRootViewController:[[HomeVC alloc] init]];
                [controllers addObject:nav];
                
            }
                break;
            case 1:
            {
                JERNavigationController *nav=[[JERNavigationController alloc] initWithRootViewController:[[LicaiListVC alloc] init]];
                [controllers addObject:nav];
                
            }
                break;
            case 2:
            {
                JERNavigationController *nav=[[JERNavigationController alloc] initWithRootViewController:[[ZhongchouListVC alloc] init]];
                [controllers addObject:nav];
                
            }
                break;
            case 3:
            {
                JERNavigationController *nav=[[JERNavigationController alloc] initWithRootViewController:[[MycenterVC alloc] init]];
                [controllers addObject:nav];
                
            }
                break;
            default:
                break;
        }
    }
    tabBarController.viewControllers=controllers;
    self.window.rootViewController=tabBarController;
    [self.window makeKeyAndVisible];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self verifyPwd:nil];
   
   /**
    *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
    *  在将生成的AppKey传入到此方法中。
    *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
    *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
    *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
    */
    [ShareSDK registerApp:@"9ac4e59aba2f"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeTencentWeibo), @(SSDKPlatformTypeFacebook), @(SSDKPlatformTypeTwitter), @(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                             
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
//                  case SSDKPlatformTypeTencentWeibo:
//                      //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
//                      [appInfo SSDKSetupTencentWeiboByAppKey:@"801307650"
//                                                   appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
//                                                 redirectUri:@"http://www.sharesdk.cn"
//                                                    authType:SSDKAuthTypeWeb];
//                      break;
                  case SSDKPlatformTypeFacebook:
                      //设置Facebook应用信息，其中authType设置为只用SSO形式授权
                      [appInfo SSDKSetupFacebookByAppKey:@"107704292745179"
                                               appSecret:@"38053202e1a5fe26c80c753071f0b573"
                                                authType:SSDKAuthTypeSSO];
                      break;
                  case SSDKPlatformTypeTwitter:
                      [appInfo SSDKSetupTwitterByConsumerKey:@"mnTGqtXk0TYMXYTN7qUxg"
                                              consumerSecret:@"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc"
                                                 redirectUri:@"http://www.sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx90e2e52e7132a4e5"
                                            appSecret:@"325d57371bb2ab41fe8bdf2909692756"];
                      break;
                  case SSDKPlatformSubTypeWechatSession:
                      [appInfo SSDKSetupWeChatByAppId:@"wx90e2e52e7132a4e5"
                                            appSecret:@"325d57371bb2ab41fe8bdf2909692756"];
                      break;
                      case SSDKPlatformSubTypeWechatTimeline:
                      [appInfo SSDKSetupWeChatByAppId:@"wx90e2e52e7132a4e5" appSecret:@"325d57371bb2ab41fe8bdf2909692756"];
                      break;
                  default:
                      break;
              }
              
          }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/*
 *  验证密码
 */
- (IBAction)verifyPwd:(id)sender {
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        NSLog(@"你还没有设置密码，请先设置密码");
    }else {
        
        [CLLockVC showVerifyLockVCInVC:self.tabBarController forgetPwdBlock:^{
            NSLog(@"忘记密码");
        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码正确");
            [lockVC dismiss:1.0f];
        }];
    }
}

@end
