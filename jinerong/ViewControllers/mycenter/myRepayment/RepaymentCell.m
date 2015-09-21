//
//  RepaymentCell.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RepaymentCell.h"

@implementation RepaymentCell

- (void)awakeFromNib {
    // Initialization code
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelName.text=[self.data objectForKey:@"projName"];
    self.labelNumber.text=[self.data objectForKey:@"projNo"];
    
    if ([[self.data objectForKey:@"repayType"]isEqualToString:@"FIRST_INTEREST_LAST_CAPITAL"]) {
        self.labelRepaymethord.text=@"按月还息，到期还本";
    }else if ([[self.data objectForKey:@"repayType"]isEqualToString:@"EQUAL_CAPTICAL_INTEREST"]) {
        self.labelRepaymethord.text=@"等额本息";
    }else if ([[self.data objectForKey:@"repayType"]isEqualToString:@"ONETINE_CAPITAL_INTEREST"]) {
        self.labelRepaymethord.text=@"一次性还本息";
    }
    NSString* date=[self.data objectForKey:@"repayDate"];
    NSString* former=@"请于";
    NSString* footer=@"前还款";
    NSString* str=[[former stringByAppendingString:date]stringByAppendingString:footer];
    self.labelDate.text=str;
}
@end
