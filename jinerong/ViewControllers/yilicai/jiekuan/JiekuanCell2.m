//
//  JiekuanCell2.m
//  jinerong
//
//  Created by carcool on 5/27/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JiekuanCell2.h"
#import "LicaiListVC.h"
@implementation JiekuanCell2
@synthesize originalHeight_superView;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    [self.btn setColor:JER_BLUE];
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
    
    self.textFieldArea.delegate=self;
    self.textFieldDiyawu.delegate=self;
    self.textFieldMoney.delegate=self;
    self.textFieldUseWay.delegate=self;
    self.textView.delegate=self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification object:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)changeJiekuanTypeSmall
{
    [self.labelDescription setFrame:CGRectMake(PARENT_X(self.labelDescription), PARENT_Y(self.labelDescription)-40, PARENT_WIDTH(self.labelDescription), PARENT_HEIGHT(self.labelDescription))];
    [self.textView setFrame:CGRectMake(PARENT_X(self.textView), PARENT_Y(self.textView)-40, PARENT_WIDTH(self.textView), PARENT_HEIGHT(self.textView))];
    [self.labelMyDescription setFrame:self.textView.frame];
    [self.btn setFrame:CGRectMake(PARENT_X(self.btn), PARENT_Y(self.btn)-40, PARENT_WIDTH(self.btn), PARENT_HEIGHT(self.btn))];
    [self.mainView setFrame:CGRectMake(PARENT_X(self.mainView), PARENT_Y(self.mainView), PARENT_WIDTH(self.mainView), PARENT_HEIGHT(self.mainView)-40)];

    self.labelDiyawu.hidden=YES;
    self.textFieldDiyawu.hidden=YES;
}
-(void)updateViews
{
    self.originalHeight_superView=self.delegate.view.frame.origin.y;
}
#pragma mark -------- textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //disable scroll tableview
    self.delegate.view.userInteractionEnabled=NO;
    float currentFrame=[textField convertRect:self.delegate.view.frame toView:nil].origin.y;//to window frame
    if (currentFrame>Screen_Height-KEYBOARD_HEIGHT)
    {
        float d_y=Screen_Height-KEYBOARD_HEIGHT-currentFrame;
         NSLog(@"d_y :%f",d_y);
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)+d_y, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //enable scroll tableview
        self.delegate.view.userInteractionEnabled=YES;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), self.originalHeight_superView, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.delegate.view.userInteractionEnabled=NO;
    float currentFrame=[textView convertRect:self.delegate.view.frame toView:nil].origin.y;//to window frame
    if (currentFrame>Screen_Height-KEYBOARD_HEIGHT)
    {
        float d_y=Screen_Height-KEYBOARD_HEIGHT-currentFrame;
        NSLog(@"d_y :%f",d_y);
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)+d_y, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }

    self.labelMyDescription.hidden=YES;

    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        self.delegate.view.userInteractionEnabled=YES;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), self.originalHeight_superView, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    if (![self.textView.text isEqualToString:@""])
    {
        self.labelMyDescription.hidden=YES;
    }
    else
    {
        self.labelMyDescription.hidden=NO;
    }
    return YES;
}
#pragma mark -------- event response
-(IBAction)showJiekuanCondition:(id)sender
{
    [self.delegate showJiekuanCondition];
}
-(IBAction)selectPersonalOrEnterprise:(id)sender
{
    UIButton *button=(UIButton*)sender;
    if (button.tag==0)
    {
        [self.personalImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
        [self.enterpriseImg setImage:[UIImage imageNamed:@"circle"]];
    }
    else if (button.tag==1)
    {
        [self.personalImg setImage:[UIImage imageNamed:@"circle"]];
        [self.enterpriseImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
}
-(IBAction)applyBorrow:(id)sender
{
    NSString *borrowTypeStr=@"";
    switch (self.borrowType) {
        case 0:
            borrowTypeStr=@"CREDIT";
            break;
        case 1:
            borrowTypeStr=@"MORTGAGE";
            break;
        case 2:
            borrowTypeStr=@"GUARANTEE";
            break;
        default:
            break;
    }
    if (![[MyFounctions getUserInfo] objectForKey:@"uid"])
    {
        [self.delegate presentViewController:[[JERNavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]] animated:YES completion:^{
            
        }];
    }
    else if ((self.borrowType==0||self.borrowType==2)&&([self.textFieldArea.text isEqualToString:@""]||[self.textFieldMoney.text isEqualToString:@""]||[self.textFieldUseWay.text isEqualToString:@""]||[self.textView.text isEqualToString:@""]))
    {
        [self.delegate showMessage:@"请将信息填写完整"];
    }
    else if ((self.borrowType==1)&&([self.textFieldArea.text isEqualToString:@""]||[self.textFieldMoney.text isEqualToString:@""]||[self.textFieldUseWay.text isEqualToString:@""]||[self.textView.text isEqualToString:@""]||[self.textFieldDiyawu.text isEqualToString:@""]))
    {
        [self.delegate showMessage:@"请将信息填写完整"];
    }
    else
    {
        NSString *type=@"";
        if ([self.personalImg.image isEqual:[UIImage imageNamed:@"gou_in_circle"]])
        {
            type=@"PERSONAL";
        }
        else
        {
            type=@"COMPANY";
        }
        NSDictionary *applyData=[NSDictionary dictionaryWithObjects:@[[[MyFounctions getUserInfo] objectForKey:@"uid"],borrowTypeStr,self.textFieldMoney.text,[self.labelTime.text substringToIndex:self.labelTime.text.length-2],@"我的借款",self.textFieldUseWay.text,self.textView.text,self.textFieldDiyawu.text,@"",self.textFieldArea.text,type] forKeys:@[@"uid",@"borrowType",@"borrowApply.borrowAmt",@"borrowApply.borrowPeriod",@"borrowApply.borrowTitle",@"borrowApply.borrowUse",@"borrowApply.borrowDesc",@"borrowApply.mortgageName",@"borrowApply.guarantee",@"borrowApply.borrowAddr",@"borrowApply.borrowUserType"]];
        
        [self.delegate appleBorrow:applyData];
    }
}
-(IBAction)TextViewBtnPressed:(id)sender
{
    [self.labelDescription setHidden:YES];
    [self.textView becomeFirstResponder];
}
-(IBAction)showPickerView:(id)sender
{
    [self.delegate creatPickerView];
}
-(void)showSelectedMonth:(NSString*)month
{
    self.labelTime.text=month;
}
@end
