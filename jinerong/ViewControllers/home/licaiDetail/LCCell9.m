//
//  LCCell9.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell9.h"

@implementation LCCell9

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
    NSString* status=[[self.data objectForKey:@"project"] objectForKey:@"status"];
    if ([status isEqual:@"LOCKED"]) {
        [self.btn setColor:JER_RED];
        self.btn.userInteractionEnabled=NO;
        self.btn.alpha=0.4;
    }else{
        [self.btn setColor:JER_RED];

    }


}
#pragma mark ------ event response
-(IBAction)btnPressed:(id)sender
{
    [self.delegate bidTheItem];
}
@end
