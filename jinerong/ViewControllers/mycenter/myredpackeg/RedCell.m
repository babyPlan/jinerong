//
//  RedCell.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RedCell.h"

@implementation RedCell

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelAmount.text=[NSString stringWithFormat:@"¥%@",[self.data objectForKey:@"currAmount"]];
    self.labelDescription.text=[self.data objectForKey:@"type"];
    //self.labelEndDate.text=[self.data objectForKey:@"expirTime"];
}
@end
