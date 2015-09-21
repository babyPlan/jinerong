//
//  aboutUsVC.m
//  jinerong
//
//  Created by zhaoml on 15/8/17.
//  Copyright (c) 2015年 qinyun. All rights reserved.
//
#import "aboutUsCell1.h"
#import "aboutUsCell0.h"
#import "aboutUsCell2.h"
#import "aboutUsVC.h"

@interface aboutUsVC ()

@end

@implementation aboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"关于我们";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];



    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        aboutUsCell0* cell = [[[NSBundle mainBundle] loadNibNamed:@"aboutUsCell0" owner:nil options:nil] objectAtIndex:0];
        return cell;
    } else if (indexPath.row==1){
        aboutUsCell1* cell = [[[NSBundle mainBundle] loadNibNamed:@"aboutUsCell1" owner:nil options:nil]objectAtIndex:0];
        return cell;
    }else if(indexPath.row==2)
    {
        aboutUsCell2* cell=[[[NSBundle mainBundle]loadNibNamed:@"aboutUsCell2" owner:nil options:nil]objectAtIndex:0];
        return cell;
    }
    return nil;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;

    if (indexPath.row==0) {
        height=70;
    }
    if (indexPath.row==1) {
        height=70;
    }
    if (indexPath.row==2) {
        height=400;
    }
    return height;
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
