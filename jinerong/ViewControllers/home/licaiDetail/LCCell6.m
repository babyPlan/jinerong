//
//  LCCell6.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell6.h"

@implementation LCCell6

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
    self.labelContent.text=self.contentSrt;
    float textHeight=[MyFounctions calculateLabelHeightWithString:self.contentSrt Width:278 font:[UIFont systemFontOfSize:14.0]];
    
    [self.labelContent setFrame: CGRectMake(PARENT_X(self.labelContent), PARENT_Y(self.labelContent), PARENT_WIDTH(self.labelContent),self.expandFlag==0?18:textHeight)];
    [self.labelExpand setFrame:CGRectMake(PARENT_X(self.labelExpand), PARENT_Y(self.labelContent)+PARENT_HEIGHT(self.labelContent)+10, PARENT_WIDTH(self.labelExpand), PARENT_HEIGHT(self.labelExpand))];
    if (self.expandFlag==0)
    {
        self.labelExpand.text=@"展开>>";
    }
    else
    {
        self.labelExpand.text=@"点击收起<<";
    }
    
    [self.contentBG setFrame:CGRectMake(PARENT_X(self.contentBG), PARENT_Y(self.contentBG), PARENT_WIDTH(self.contentBG), PARENT_Y(self.labelExpand)+PARENT_HEIGHT(self.labelExpand)+5)];
}

@end
