//
//  ZCCell1.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ZCCell1.h"
#import "ZhongchouShowDetailVCViewController.h"

@implementation ZCCell1

- (void)awakeFromNib {
    // Initialization code
   // [self.btn.layer setBorderWidth:1.0];
    //[self.btn.layer setBorderColor:[JER_BLUE CGColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [MyFounctions setLineViewMoreThin:self.lineView1];
    [MyFounctions setLineViewMoreThin:self.lineView2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateViews
{
    self.labelID.text=[self.data objectForKey:@"crowdfundingNo"];
    self.labelName.text=[self.data objectForKey:@"crowdfundingName"];
    self.labelPercent.text=[NSString stringWithFormat:@"%ld％",(long)[[self.data objectForKey:@"progress"] integerValue]];
    self.labelTotalMoney.text=[NSString stringWithFormat:@"目标金额：%@",[self.data objectForKey:@"crowdfundingAmt"]];
    self.labelAlreadyMoney.text=[NSString stringWithFormat:@"¥%ld",[[self.data objectForKey:@"supportAmt"] integerValue]-[[self.data objectForKey:@"balanceAmt"] integerValue]];
    self.labelDaysLeft.text=[NSString stringWithFormat:@"%ld",(long)[[self.data objectForKey:@"leftDays"] integerValue]];
    self.labelPeople.text=[NSString stringWithFormat:@"%ld",(long)[[self.data objectForKey:@"supportNum"] integerValue]];
    
    [MyFounctions setPercentGrayview:self.grayView redView:self.redView percent:[[self.data objectForKey:@"progress"] integerValue]];
    
}
- (IBAction)btnpress:(id)sender {
    [self.delegate checkZhongchouDetail];
    
}

@end