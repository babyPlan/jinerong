//
//  MyLicaiCell.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyLicaiCell.h"

@implementation MyLicaiCell

- (void)awakeFromNib {
    // Initialization code
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    
    
    [self.labelState.layer setBorderColor:[JER_BLUE CGColor]];
    [self.labelState.layer setBorderWidth:1.0];
    [self.labelState setFrame:CGRectMake(PARENT_X(self.labelState)-30, PARENT_Y(self.labelState), [MyFounctions calculateTextWidth:@"投资失败" font:[UIFont systemFontOfSize:12.0]]+10,15.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelMoney.text=[NSString stringWithFormat:@"已投¥%@",[self.data objectForKey:@"investAmount"]];
    self.labelName.text=[self.data objectForKey:@"investName"];
    self.labelNumber.text=[NSString stringWithFormat:@"%@",[self.data objectForKey:@"projectNo"]] ;
    self.labelState.text=[self.data objectForKey:@"status"];
    self.labelMoneyStatus.text=[self.data objectForKey:@"payStatus"];
}
@end
