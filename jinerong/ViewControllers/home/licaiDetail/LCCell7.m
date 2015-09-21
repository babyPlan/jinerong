//
//  LCCell7.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell7.h"

@implementation LCCell7
@synthesize m_aryBids;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    NSInteger maxNum=3;
    if (self.expandFlag==0)
    {
        maxNum=3;
    }
    else
    {
        maxNum=99;
    }
        
    NSInteger i=0;
    do {
        NSDictionary *data=nil;
        if ([self.m_aryBids count]>0)
        {
            data=[self.m_aryBids objectAtIndex:i];
        }
        else
        {
            data=[NSDictionary dictionaryWithObjects:@[@"无投标",@""] forKeys:@[@"userName",@"amount"]];
        }
        UILabel *labelLeft=[[UILabel alloc] initWithFrame:CGRectMake(14, 36+i*20, 175, 20)];
        [labelLeft setFont:[UIFont systemFontOfSize:14.0]];
        if ([self.m_aryBids count]>0)
        {
            labelLeft.text=[NSString stringWithFormat:@"%ld%@ %@元",i+1,[data objectForKey:@"userName"],[data objectForKey:@"amount"]];
        }
        else
        {
            labelLeft.text=@"无投标记录";
        }
        
        [self.contentBG addSubview:labelLeft];
        
        UILabel *labelRight=[[UILabel alloc] initWithFrame:CGRectMake(146, 36+i*20, 146, 20)];
        [labelRight setFont:[UIFont systemFontOfSize:14.0]];
        [labelRight setTextAlignment:NSTextAlignmentRight];
        [labelRight setTextColor:[UIColor lightGrayColor]];
        labelRight.text=[data objectForKey:@"buyTime"];
        [self.contentBG addSubview:labelRight];
        
        i++;
    } while (i<self.m_aryBids.count&&i<maxNum);
    
    [self.labelExpand setFrame:CGRectMake(PARENT_X(self.labelExpand), 62+20*(i-1), 76, 20)];
    if (self.expandFlag==0)
    {
        self.labelExpand.text=@"展开>>";
    }
    else
    {
        self.labelExpand.text=@"点击收起<<";
    }
    
    [self.contentBG setFrame:CGRectMake(PARENT_X(self.contentBG), PARENT_Y(self.contentBG), PARENT_WIDTH(self.contentBG), 90+(i-1)*20)];
}
@end
