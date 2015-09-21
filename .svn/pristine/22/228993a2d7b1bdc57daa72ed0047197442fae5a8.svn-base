//
//  RealNameVerifyVC.m
//  jinerong
//
//  Created by carcool on 7/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RealNameVerifyVC.h"

@interface RealNameVerifyVC ()

@end

@implementation RealNameVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"实名认证";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.labelName.text=[[MyFounctions getUserInfo] objectForKey:@"realName"];
    self.labelId.text=[[MyFounctions getUserInfo] objectForKey:@"idCardCode"];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [MyFounctions setLineViewMoreThin:self.lineView0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
