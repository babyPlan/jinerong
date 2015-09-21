//
//  aboutUsCell1.m
//  jinerong
//
//  Created by zhaoml on 15/8/20.
//  Copyright (c) 2015年 qinyun. All rights reserved.
//

#import "aboutUsCell1.h"

@implementation aboutUsCell1

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *str =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.labelVersion.text=[@"V" stringByAppendingString:str];
    //[self.labelVersion setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
