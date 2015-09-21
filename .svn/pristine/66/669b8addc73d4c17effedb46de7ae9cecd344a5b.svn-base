//
//  LCCell3.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell3.h"

@implementation LCCell3

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)updateViews{
    NSLog(@"cell3:%@",[self.data objectForKey:@"profile"]);
    NSLog(@"cell3_1:%@",[[self.data objectForKey:@"profile"]objectForKey:@"payOffCnt"]);
    NSNumberFormatter* nf=[[NSNumberFormatter alloc]init];
    
    self.labelGrade.text=[[self.data objectForKey:@"project"]objectForKey:@"creditGrade"];
    self.labelSuccess.text=[nf stringFromNumber:[[self.data objectForKey:@"profile"]objectForKey:@"borrowCnt"]];
    self.labelclear.text=[[self.data objectForKey:@"profile"]objectForKey:@"payOffCnt"];
}
@end
