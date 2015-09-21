//
//  MoreMenuView.m
//  jinerong
//
//  Created by carcool on 5/29/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MoreMenuView.h"
#import "ZhongchouListVC.h"
@implementation MoreMenuView
-(void)awakeFromNib
{
    [self.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.layer setBorderWidth:1.0];
}
-(IBAction)BtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        [self removeFromSuperview];
    }
    else
    {
        [self.delegate setMoreMenuViewSelectedItem:btn.tag];
        [self removeFromSuperview];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
