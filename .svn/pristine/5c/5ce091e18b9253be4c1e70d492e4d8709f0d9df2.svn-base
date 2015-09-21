//
//  LCCell3expand.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell3expand.h"

@implementation LCCell3expand

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
    NSNumberFormatter* nf =[[NSNumberFormatter alloc]init];
    
    NSDictionary* profile=[self.data objectForKey:@"profile"];
    self.labelGrades.text=[[self.data objectForKey:@"project"]objectForKey:@"creditGrade"];
    
    self.labelSuccess.text=[nf stringFromNumber:[profile objectForKey:@"borrowCnt"]];
    self.labelClear.text=[profile objectForKey:@"payOffCnt"];
    self.labelBroAmt.text=[profile objectForKey:@"borrowAmt"];
    self.labelDueAmt.text=[profile objectForKey:@"overDueAmt"];
    self.labelDueCount.text=[nf stringFromNumber:[profile objectForKey:@"overDueCnt"]];
    self.labelWaitAmt.text=[profile objectForKey:@"unpaidAmt"];
    
    
    
}
@end
