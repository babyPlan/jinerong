//
//  JiekuanTopCell.m
//  jinerong
//
//  Created by carcool on 5/27/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JiekuanTopCell.h"
#import "LicaiListVC.h"
@implementation JiekuanTopCell
@synthesize delegate;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)segmentControlChange:(id)sender
{
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    NSInteger index=segment.selectedSegmentIndex;
    [self.delegate jiekuanTypeChange:index];
}
@end
