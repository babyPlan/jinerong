//
//  TRansactionCell.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TRansactionCell.h"

@implementation TRansactionCell

- (void)awakeFromNib {
    // Initialization code
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelID.text=[self.data objectForKey:@"orderInfoTransid"];
    if ([[self.data objectForKey:@"operType"] isEqualToString:@"CHARGE"]) {
        self.labelName.text=@"充值";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"DEPOSIT"]) {
        self.labelName.text=@"提现";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"INVEST"]) {
        self.labelName.text=@"投资";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"CAPITAL_RETURN"]) {
        self.labelName.text=@"回收本金";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"INTEREST_RETURN"]) {
        self.labelName.text=@"回收利息";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"REINVEST"]) {
        self.labelName.text=@"收益复投";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"Recovery_punitive_interest"]) {
        self.labelName.text=@"回收罚息";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"Foreclosure_Investing"]) {
        self.labelName.text=@"赎回投资";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"Get_advance_funds"]) {
        self.labelName.text=@"获得垫付资金";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"Buying_debt"]) {
        self.labelName.text=@"买入债权";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"FEE"]) {
        self.labelName.text=@"手续费";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"Frozen_Invest"]) {
        self.labelName.text=@"投资中冻结金额";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"Frozen_Withdraw"]) {
        self.labelName.text=@"提现中冻结金额";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"Bonus"]) {
        self.labelName.text=@"赠送奖金";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"REFUND"]) {
        self.labelName.text=@"流标退款";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"REPAYMENT"]) {
        self.labelName.text=@"还款";
    }else if ([[self.data objectForKey:@"operType"] isEqualToString:@"B_BORROW_AMT"]) {
        self.labelName.text=@"借款金";
    }
    self.labelTime.text=[self.data objectForKey:@"updatedOn"];
    self.labelMoneyBalance.text=[NSString stringWithFormat:@"账户余额：%.2f",[[self.data objectForKey:@"accountBalance"] floatValue]];
    
    if ([[self.data objectForKey:@"way"] isEqualToString:@"IN"])
    {
        self.labelMoneyTransaction.text=[NSString stringWithFormat:@"+%.2f",[[self.data objectForKey:@"amt"] floatValue]];
        [self.labelMoneyTransaction setTextColor:JER_GREEN];
    }
    else
    {
        self.labelMoneyTransaction.text=[NSString stringWithFormat:@"-%.2f",[[self.data objectForKey:@"amt"] floatValue]];
        [self.labelMoneyTransaction setTextColor:JER_RED];
    }
    
}
@end
