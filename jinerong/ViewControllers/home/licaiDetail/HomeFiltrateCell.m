//
//  HomeFiltrateCell.m
//  jinerong
//
//  Created by carcool on 6/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HomeFiltrateCell.h"

@implementation HomeFiltrateCell

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
