//
//  ConfirmZCCell.m
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ConfirmZCCell.h"
#import "ConfirmZhongchouVC.h"
@implementation ConfirmZCCell

- (void)awakeFromNib {
    // Initialization code
    [self.btn setColor:JER_RED];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [MyFounctions setLineViewMoreThin:self.lineView1];
    [MyFounctions setLineViewMoreThin:self.lineView2];
    [MyFounctions setLineViewMoreThin:self.lineView3];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [self.lineView1 setBackgroundColor:JER_BG_GRAY];
    [self.lineView2 setBackgroundColor:JER_BG_GRAY];
    [self.lineView3 setBackgroundColor:JER_BG_GRAY];
    self.textfieldName.delegate=self;
    self.textfieldPhone.delegate=self;
    self.textfieldArea.delegate=self;
    self.textfieldAddress.delegate=self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelName.text=[[self.data objectForKey:@"cfRecord"] objectForKey:@"crowdfundingName"];
    self.labelPay.text=[self.supportData objectForKey:@"supportAmt"];
    self.labelRepayment.text=[self.supportData objectForKey:@"supportDesc"];
    self.labelSendFee.text=@"暂无";
    self.labelSupportMoney.text=[self.supportData objectForKey:@"supportAmt"];
    self.labelTime.text=[[self.data objectForKey:@"cfRecord"] objectForKey:@"crowdfundingStartTime"];
}
#pragma mark ------- textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float textfield_y=[textField convertRect:self.delegate.view.frame toView:self.delegate.view].origin.y;
    if (textfield_y>Screen_Height-KEYBOARD_HEIGHT-100)
    {
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), self.delegate.view.frame.origin.y-(textfield_y-(Screen_Height-KEYBOARD_HEIGHT-100)), PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), 64, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    return YES;
}
#pragma mark ------- event response
-(IBAction)btnPressed:(id)sender
{
    if ([self.textfieldAddress.text isEqualToString:@""]||[self.textfieldArea.text isEqualToString:@""]||[self.textfieldName.text isEqualToString:@""]||[self.textfieldPhone.text isEqualToString:@""])
    {
        [self.delegate showMessage:@"请将信息输入完整"];
        return;
    }
    
    [self.delegate supportZhongchouName:self.textfieldName.text Money:nil Phone:self.textfieldPhone.text Address:[NSString stringWithFormat:@"%@%@",self.textfieldArea.text,self.textfieldAddress.text]];
}

@end
