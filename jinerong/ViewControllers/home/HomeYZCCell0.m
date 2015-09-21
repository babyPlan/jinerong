//
//  HomeYZCCell0.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HomeYZCCell0.h"

@implementation HomeYZCCell0
@synthesize data;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [MyFounctions setLineViewMoreThin:self.lineView];
    [self.grayView setBackgroundColor:JER_BG_GRAY];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    [self.img setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"crowdfundingPicSmall"]]];
    self.labelName.text=[data objectForKey:@"crowdfundingName"];
    self.labelDays.text=[NSString stringWithFormat:@"%ld天",(long)[[data objectForKey:@"leftDays"] integerValue]];
    self.labelDealRate.text=[NSString stringWithFormat:@"%ld％",(long)[[data objectForKey:@"progress"] integerValue]];
    self.labelMoney.text=[NSString stringWithFormat:@"¥%.2f",[[data objectForKey:@"crowdfundingAmt"] floatValue]-[[data objectForKey:@"balanceAmt"] floatValue]];
    self.labelPeople.text=[NSString stringWithFormat:@"%ld",(long)[[data objectForKey:@"supportNum"] integerValue]];
    
    [MyFounctions setPercentGrayview:self.grayView redView:self.redView percent:[[data objectForKey:@"progress"] integerValue]];
}
@end