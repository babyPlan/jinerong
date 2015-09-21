//
//  AutoBidVC.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AutoBidVC.h"

@interface AutoBidVC ()

@end

@implementation AutoBidVC
@synthesize btn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"自动投标";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn setColor: JER_RED];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [MyFounctions setLineViewMoreThin:self.lineView1];
    [MyFounctions setLineViewMoreThin:self.lineView2];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [self.lineView1 setBackgroundColor:JER_BG_GRAY];
    [self.lineView2 setBackgroundColor:JER_BG_GRAY];
    
    self.autoBidBG.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------- event response
-(IBAction)switchPressed:(id)sender
{
    UISwitch *myswitch=(UISwitch*)sender;
    if (myswitch.on==YES)
    {
        self.autoBidBG.hidden=NO;
    }
    else
    {
        self.autoBidBG.hidden=YES;
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
