//
//  TransferDebtCell1.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TransferDebtCell1.h"

@implementation TransferDebtCell1

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [self.btn setColor:JER_RED];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [MyFounctions setLineViewMoreThin:self.lineView1];
    [MyFounctions setLineViewMoreThin:self.lineView2];
    [MyFounctions setLineViewMoreThin:self.lineView3];
    [MyFounctions setLineViewMoreThin:self.lineView4];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [self.lineView1 setBackgroundColor:JER_BG_GRAY];
    [self.lineView2 setBackgroundColor:JER_BG_GRAY];
    [self.lineView3 setBackgroundColor:JER_BG_GRAY];
    [self.lineView4 setBackgroundColor:JER_BG_GRAY];
    self.textFieldTransfer.delegate=self;
    self.textFieldSellPrice.delegate=self;
    self.textFieldVerifyCode.delegate=self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --------- textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float textfield_y=[textField convertRect:self.frame toView:self.delegate.view].origin.y;
    if (textfield_y>Screen_Height-KEYBOARD_HEIGHT+90)
    {
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)-(textfield_y-(Screen_Height-KEYBOARD_HEIGHT+90)), PARENT_WIDTH(self.delegate.view),PARENT_HEIGHT(self.delegate.view))];
    }
    self.delegate.view.userInteractionEnabled=NO;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
     [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), 64, PARENT_WIDTH(self.delegate.view),PARENT_HEIGHT(self.delegate.view))];
    self.delegate.view.userInteractionEnabled=YES;
    return YES;
}
@end
