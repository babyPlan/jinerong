//
//  Register2Cell.m
//  jinerong
//
//  Created by carcool on 6/3/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "Register2Cell.h"

@implementation Register2Cell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    [self.btn setColor:JER_BLUE];
    self.textFieldName.delegate=self;
    self.textFieldPassword.delegate=self;
    self.textFieldResetPassword.delegate=self;
    self.textFieldID.delegate=self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ------- yextfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float _y=[self convertRect:textField.frame toView:self.delegate.view].origin.y;
    if (_y>Screen_Height-KEYBOARD_HEIGHT)
    {
        float move_y=_y-Screen_Height-KEYBOARD_HEIGHT;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)-move_y, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), 64, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)registerBtnPressed:(id)sender
{
    if([self.textFieldID.text isEqualToString:@""])
    {
        [self.delegate showMessage:@"请填写身份证号码"];
        return;
    }
    else if ([self.textFieldName.text isEqualToString:@""])
    {
        [self.delegate showMessage:@"请填写真实姓名"];
        return;
    }
    else if ([self.textFieldPassword.text isEqualToString:@""])
    {
        [self.delegate showMessage:@"请填写密码"];
        return;
    }
    else if ([self.textFieldResetPassword.text isEqualToString:@""])
    {
        [self.delegate showMessage:@"请确认密码"];
        return;
    }
    else if (![self.textFieldPassword.text isEqualToString:self.textFieldResetPassword.text])
    {
        [self.delegate showMessage:@"两次输入密码不相同"];
        return;
    }
    
    //register
    [self.delegate registerBtnPressedPassword:self.textFieldPassword.text name:self.textFieldName.text idengtifyCard:self.textFieldID.text];
}
@end
