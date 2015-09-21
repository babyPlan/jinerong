//
//  TransferDebtCell0.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TransferDebtCell0.h"

@implementation TransferDebtCell0
@synthesize data,investing;
- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ------- event response
-(IBAction)switchPressed:(id)sender
{
    UISwitch *myswitch=(UISwitch*)sender;
    if (myswitch.on==YES)
    {
        if ([[self.data objectForKey:@"canAssignment"] integerValue]==0)
        {
            [self.delegate showMessage:@"不能转让债权"];
            [myswitch setOn:NO];
            return;
        }
        self.delegate.transferFlag=1;
        [self.delegate.m_tableView reloadData];
    }
    else
    {
        self.delegate.transferFlag=0;
        [self.delegate.m_tableView reloadData];
    }

}
-(void)updateViews
{
    self.labelName.text=[data objectForKey:@"projName"];
    self.labelInvestMoney.text=[NSString stringWithFormat:@"¥%@",[data objectForKey:@"bidAmt"]];
    self.labelInvestMonths.text=[NSString stringWithFormat:@"%ld个月",(long)[[data objectForKey:@"dueTime"] integerValue]];
    self.labelYearRate.text= [NSString stringWithFormat:@"%@％",[data objectForKey:@"yearRate"]];
    self.labelTransID.text=[data objectForKey:@"projNo"];
    self.labelStatus.text=self.status;
    self.labelBuyTime.text=[data objectForKey:@"buyDate"];
    if ([[data objectForKey:@"interestDate"] isEqual:[NSNull null]])
    {
         self.labelStartTime.text=@"暂无数据";
    }
    else
    {
         self.labelStartTime.text=[data objectForKey:@"interestDate"];
    }
   

    if ([[data objectForKey:@"borrowerType"] isEqualToString:@"PERSONAL"])
    {
        [self.headTypeImg setImage:[UIImage imageNamed:@"head_home"]];
    }
    else
    {
        [self.headTypeImg setImage:[UIImage imageNamed:@"head_home_lingdai"]];
    }
    
    if ([[data objectForKey:@"projectType"] isEqualToString:@"GUARANTEE"])
    {
        [self.ByTypeImg setImage:[UIImage imageNamed:@"dan"]];
    }
    else if ([[data objectForKey:@"projectType"] isEqualToString:@"MORTGAGE"])
    {
        [self.ByTypeImg setImage:[UIImage imageNamed:@"ya"]];
    }
    else if ([[data objectForKey:@"projectType"] isEqualToString:@"CREDIT"])
    {
        [self.ByTypeImg setImage:[UIImage imageNamed:@"xin"]];
    }
    else if ([[data objectForKey:@"projectType"] isEqualToString:@"OTHER"])
    {
        [self.ByTypeImg setImage:[UIImage imageNamed:@"zhai"]];
    }
    
    if ([[data objectForKey:@"isAward"] integerValue]!=1)
    {
        self.jiangImg.hidden=YES;
    }
    
    float textWidth=[MyFounctions calculateTextWidth:self.labelName.text font:[UIFont systemFontOfSize:17.0]];
    if (textWidth>220)
    {
        textWidth=220;
        [self.labelName setFrame:CGRectMake(PARENT_X(self.labelName), PARENT_Y(self.labelName), textWidth, PARENT_HEIGHT(self.labelName))];
    }
    [self.headTypeImg setFrame:CGRectMake(PARENT_X(self.labelName)+textWidth+10, PARENT_Y(self.headTypeImg), PARENT_WIDTH(self.headTypeImg), PARENT_HEIGHT(self.headTypeImg))];
    [self.ByTypeImg setFrame:CGRectMake(PARENT_X(self.labelName)+textWidth+10+PARENT_WIDTH(self.headTypeImg)+10, PARENT_Y(self.ByTypeImg), PARENT_WIDTH(self.ByTypeImg), PARENT_HEIGHT(self.ByTypeImg))];
    [self.jiangImg setFrame:CGRectMake(PARENT_X(self.labelName)+textWidth+10+PARENT_WIDTH(self.headTypeImg)+10+PARENT_WIDTH(self.ByTypeImg)+10, PARENT_Y(self.jiangImg), PARENT_WIDTH(self.jiangImg), PARENT_HEIGHT(self.jiangImg))];

}
@end
