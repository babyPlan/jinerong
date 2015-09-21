//
//  SuggestBottomCell.m
//  jinerong
//
//  Created by carcool on 6/3/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SuggestBottomCell.h"

@implementation SuggestBottomCell

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [self.btn setColor:[UIColor grayColor]];
    
    self.textView.delegate =self;
    self.textField.delegate =self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //enable scroll tableview
//    self.delegate.view.userInteractionEnabled=YES;
    [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view),64, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqual:@"这里填写的是你遇到的，以及想要我们帮您解决的问题"]) {
        textView.text=@"";
    }
    [textView setTextColor:[UIColor blackColor]];
    self.delegate.view.userInteractionEnabled=NO;
    float curentFrame = [textView.superview convertRect:textView.frame toView:nil].origin.y;
    NSLog(@"curentFrame:%f",curentFrame);
 //   if (curentFrame>Screen_Height-KEYBOARD_HEIGHT_FOR_TEXTVIEW) {
        float d_y = Screen_Height-KEYBOARD_HEIGHT_FOR_TEXTVIEW-curentFrame-30;
        NSLog(@"d_y :%f",d_y);
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)+d_y, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
// }

    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        self.delegate.view.userInteractionEnabled=YES;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), 64, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
        [textView resignFirstResponder];
    
        if ([textView.text isEqualToString:@""])
        {
//            self.labelDescription.hidden=NO;
            textView.textColor=[UIColor grayColor];
            textView.text=@"这里填写的是你遇到的，以及想要我们帮您解决的问题";
            
        }
        else
        {
//            self.labelDescription.hidden=YES;
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {//按下return键
        [textView resignFirstResponder];
        return NO;
    }else {
        if ([textView.text length] < 140) {//判断字符个数
            return YES;
        }else if ([textView.text length]==0){
            
            
            return YES;
        }
    }
    return NO;
}


@end
