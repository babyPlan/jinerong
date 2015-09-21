//
//  GetCashCellBank.m
//  jinerong
//
//  Created by carcool on 6/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "GetCashCellBank.h"

@implementation GetCashCellBank

- (void)awakeFromNib {
    // Initialization code
//    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelName.text=[self.data objectForKey:@"bankName"];
    self.labelNumberLast.text=[NSString stringWithFormat:@"尾号：%ld",(long)[[self.data objectForKey:@"bankAccountLast"] integerValue]];
}
@end
