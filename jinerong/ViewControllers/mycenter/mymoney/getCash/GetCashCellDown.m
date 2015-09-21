//
//  GetCashCellDown.m
//  jinerong
//
//  Created by carcool on 6/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "GetCashCellDown.h"
#import "GetCashVC.h"
@implementation GetCashCellDown

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.btn setColor:JER_RED];
    self.textFieldMoney.delegate=self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ------ textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![MyFounctions isPureNumandCharacters:textField.text])
    {
        [self.delegate showMessage:@"请输入正确金额"];
        self.textFieldMoney.text=@"";
    }
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)btnPressed:(id)sender
{
    [self.delegate getCashBtnPressed:self.textFieldMoney.text];
}
@end
