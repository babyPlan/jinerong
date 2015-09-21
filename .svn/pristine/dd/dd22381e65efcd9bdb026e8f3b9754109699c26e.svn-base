//
//  MessageCell.m
//  jinerong
//
//  Created by carcool on 7/15/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MessageCell.h"
#import "MessageDetailVC.h"

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
//    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelContent.text=[self.data objectForKey:@"content"];
    self.labelName.text=[self.data objectForKey:@"showTitle"];
    self.labelTime.text=[self.data objectForKey:@"showDate"];
    if ([[self.data objectForKey:@"statusText"] isEqualToString:@"已读"])
    {
        self.redPoint.hidden=YES;
    }
    else
    {
        self.redPoint.hidden=NO;
    }
    
}
@end
