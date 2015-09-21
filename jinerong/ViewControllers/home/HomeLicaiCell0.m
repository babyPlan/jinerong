//
//  HomeLicaiCell0.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HomeLicaiCell0.h"

@implementation HomeLicaiCell0
@synthesize data;
- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.grayView setBackgroundColor:JER_BG_GRAY];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelName.text=[data objectForKey:@"projectName"];
    self.labelMoney.text=[NSString stringWithFormat:@"¥%@",[data objectForKey:@"totalAmount"]];
    self.labelTime.text=[NSString stringWithFormat:@"%ld个月",(long)[[data objectForKey:@"dueTime"] integerValue]];
    self.labelRate.text= [NSString stringWithFormat:@"%@％",[data objectForKey:@"yearRate"]];
    self.labelPercent.text=[NSString stringWithFormat:@"%ld％",(long)[[data objectForKey:@"progress"] integerValue]];
    
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
    
    float textWidth=[MyFounctions calculateTextWidth:[data objectForKey:@"projectName"] font:[UIFont systemFontOfSize:14.0]];
    if (textWidth>220)
    {
        textWidth=220;
        [self.labelName setFrame:CGRectMake(PARENT_X(self.labelName), PARENT_Y(self.labelName), textWidth, PARENT_HEIGHT(self.labelName))];
    }
    [self.headTypeImg setFrame:CGRectMake(PARENT_X(self.labelName)+textWidth+10, PARENT_Y(self.headTypeImg), PARENT_WIDTH(self.headTypeImg), PARENT_HEIGHT(self.headTypeImg))];
    [self.ByTypeImg setFrame:CGRectMake(PARENT_X(self.labelName)+textWidth+10+PARENT_WIDTH(self.headTypeImg)+10, PARENT_Y(self.ByTypeImg), PARENT_WIDTH(self.ByTypeImg), PARENT_HEIGHT(self.ByTypeImg))];
    [self.jiangImg setFrame:CGRectMake(PARENT_X(self.labelName)+textWidth+10+PARENT_WIDTH(self.headTypeImg)+10+PARENT_WIDTH(self.ByTypeImg)+10, PARENT_Y(self.jiangImg), PARENT_WIDTH(self.jiangImg), PARENT_HEIGHT(self.jiangImg))];
    [MyFounctions setPercentGrayview:self.grayView redView:self.redView percent:[[data objectForKey:@"progress"] integerValue]];
    
}
@end
