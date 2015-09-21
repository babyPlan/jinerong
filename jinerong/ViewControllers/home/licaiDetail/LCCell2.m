//
//  LCCell2.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell2.h"

@implementation LCCell2
@synthesize data;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    NSDictionary *user=nil;
    if(![[data objectForKey:@"perUser"] isEqual:[NSNull null]])
    {
        self.labelWho.text=@"个人借款";
        user=[NSDictionary dictionaryWithDictionary:[self.data objectForKey:@"perUser"]];
    }
    else
    {
        if(![[data objectForKey:@"comUser"] isEqual:[NSNull null]])
        {
            self.labelWho.text=@"企业借款";
            user=[NSDictionary dictionaryWithDictionary:[self.data objectForKey:@"comUser"]];
        }
        else
        {
            user=[NSDictionary dictionary];
        }
    }
    self.labelAge.text=[NSString stringWithFormat:@"%ld",(long)[[user objectForKey:@"age"] integerValue]];
    self.labelSex.text=[[user objectForKey:@"gender"] integerValue]==1?@"男":@"女";
    self.labelGrade.text= [user objectForKey:@"educationalBackground"];
    
    if ([[user objectForKey:@"maritalStatus"] isEqual:@"UNMARRIED"]) {
        self.labelMarry.text=@"未婚";
    }else if ([[user objectForKey:@"maritalStatus"] isEqual:@"MARRIED"]) {
        self.labelMarry.text=@"已婚";
    }else if ([[user objectForKey:@"maritalStatus"] isEqual:@"DIVORCED"]) {
        self.labelMarry.text=@"离异";
    }else if ([[user objectForKey:@"maritalStatus"] isEqual:@"WIDOWED"]) {
        self.labelMarry.text=@"丧偶";
    }
}
@end
