//
//  HomeLicaiCell1.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HomeLicaiCell1.h"
#import "HomeVC.h"
#import "LicaiListVC.h"
@implementation HomeLicaiCell1
@synthesize index,data;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    [self.btnDetail setColor:JER_RED];
    [self.btnBid setColor:JER_BLUE];
//    self.textfield.delegate=self;
//    self.expectEarning=0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    if (self.delegate)
    {
        self.originalHeight_superView=self.delegate.view.frame.origin.y;
        if ([self.delegate.m_dicInput objectForKey:[NSString stringWithFormat:@"%ld",(long)self.index]])
        {
//            self.textfield.text=[self.delegate.m_dicInput objectForKey:[NSString stringWithFormat:@"%d",self.index]];
//            self.expectEarning=[self.textfield.text integerValue]*[[data objectForKey:@"yearRate"] floatValue]/100.0/12.0*[[data objectForKey:@"dueTime"] integerValue];
//            self.labelExpect.text=[NSString stringWithFormat:@"%.2f元",self.expectEarning];
        }
    }
    else
    {
        self.originalHeight_superView=self.licaiListDelegate.view.frame.origin.y;
        if ([self.licaiListDelegate.m_dicInput objectForKey:[NSString stringWithFormat:@"%ld",(long)self.index]])
        {
//            self.textfield.text=[self.licaiListDelegate.m_dicInput objectForKey:[NSString stringWithFormat:@"%d",self.index]];
//            self.expectEarning=[self.textfield.text integerValue]*[[data objectForKey:@"yearRate"] floatValue]/100.0/12.0*[[data objectForKey:@"dueTime"] integerValue];
//            self.labelExpect.text=[NSString stringWithFormat:@"%.2f元",self.expectEarning];
        }
    }
    if ([[data objectForKey:@"status1"]isEqualToString:@"nostart"]) {
        [self.btnBid setTitle:@"未开始" forState:UIControlStateNormal];
        self.btnBid.userInteractionEnabled=NO;
        self.btnBid.alpha=0.4;

    }else if ([[data objectForKey:@"status1"]isEqualToString:@"investing"]) {
        [self.btnBid setTitle:@"投资中" forState:UIControlStateNormal];
        
    }else if ([[data objectForKey:@"status1"]isEqualToString:@"invested"]) {
        [self.btnBid setTitle:@"满标" forState:UIControlStateNormal];
        self.btnBid.userInteractionEnabled=NO;
        self.btnBid.alpha=0.4;
        
    }else if ([[data objectForKey:@"status1"]isEqualToString:@"repaying"]) {
        [self.btnBid setTitle:@"还款中" forState:UIControlStateNormal];
        self.btnBid.userInteractionEnabled=NO;
        self.btnBid.alpha=0.4;
        
    }else if ([[data objectForKey:@"status1"]isEqualToString:@"repayed"]) {
        [self.btnBid setTitle:@"已完成" forState:UIControlStateNormal];
        self.btnBid.userInteractionEnabled=NO;
        self.btnBid.alpha=0.4;
        
    }
    self.labelAccessMoney.text=[NSString stringWithFormat:@"%@元", [data objectForKey:@"balanceAmt"]];
}
#pragma mark -------- event response
-(IBAction)showDetail:(id)sender
{
    if (self.delegate)//home
    {
        [self.delegate showLicaiDetailVC:[self.data objectForKey:@"projectNo"]];
    }
    else//licai
    {
        [self.licaiListDelegate showLicaiDetailVC:[self.data objectForKey:@"projectNo"]];
    }
}
-(IBAction)Bid:(id)sender
{
    if (self.delegate)//home
    {
        [self.delegate bidLicai:[self.data objectForKey:@"projectNo"]];
    }
    else//licai
    {
        [self.licaiListDelegate bidLicai:[self.data objectForKey:@"projectNo"]];
    }
}
@end
