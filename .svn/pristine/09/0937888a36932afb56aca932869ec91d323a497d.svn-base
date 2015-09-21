//
//  LaunchZhongchouCell.m
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LaunchZhongchouCell.h"
#import "LaunchZhongchouVC.h"
@implementation LaunchZhongchouCell

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
    [MyFounctions setLineViewMoreThin:self.lineView5];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [self.lineView1 setBackgroundColor:JER_BG_GRAY];
    [self.lineView2 setBackgroundColor:JER_BG_GRAY];
    [self.lineView3 setBackgroundColor:JER_BG_GRAY];
    [self.lineView4 setBackgroundColor:JER_BG_GRAY];
    [self.lineView5 setBackgroundColor:JER_BG_GRAY];
    [self.gouImg setImage:[UIImage imageNamed:@"gou_fangkuang"]];
    self.textfieldAmount.delegate=self;
    self.textfieldDays.delegate=self;
    self.textfieldPhone.delegate=self;
    self.textfieldProjectName.delegate=self;
    self.textfieldUseName.delegate=self;
    self.textViewDescription.delegate=self;
    self.typeIndex=0;
    self.typeString=@"TECH";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    if ([self.city objectForKey:@"name"])//selected
    {
        if ([[self.city objectForKey:@"name"] isEqualToString:[self.province objectForKey:@"name"]])
        {
            self.labelRegion.text=[self.city objectForKey:@"name"];
        }
        else
        {
            self.labelRegion.text=[NSString stringWithFormat:@"%@ %@",[self.province objectForKey:@"name"],[self.city objectForKey:@"name"]];
        }
        
    }
    else
    {
        self.labelRegion.text=@"请输入项目地址";
    }
}
#pragma mark -------- textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //disable scroll tableview
    self.delegate.view.userInteractionEnabled=NO;
    float currentFrame=[textField.superview convertRect:textField.frame toView:nil].origin.y;//to window frame
    if (currentFrame>Screen_Height-KEYBOARD_HEIGHT-40)
    {
        float d_y=Screen_Height-KEYBOARD_HEIGHT-currentFrame-40;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)+d_y, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //enable scroll tableview
    self.delegate.view.userInteractionEnabled=YES;
    [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), 64, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.labelDescription.hidden=YES;
    self.delegate.view.userInteractionEnabled=NO;
    float currentFrame=[textView.superview convertRect:textView.frame toView:nil].origin.y;//to window frame
    if (currentFrame>Screen_Height-KEYBOARD_HEIGHT_FOR_TEXTVIEW-40)
    {
        float d_y=Screen_Height-KEYBOARD_HEIGHT_FOR_TEXTVIEW-currentFrame-40;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view), PARENT_Y(self.delegate.view)+d_y, PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }
    
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
            self.labelDescription.hidden=NO;
        }
        else
        {
            self.labelDescription.hidden=YES;
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

#pragma mark ------- event response
-(IBAction)selectType:(id)sender
{
    [self setAllTypeUnselected];
    UIButton *typeBtn=(UIButton*)sender;
    self.typeIndex=typeBtn.tag;
    [self setMyTyteString];
    if (typeBtn.tag==0)
    {
        [self.kejiImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
    else if (typeBtn.tag==1)
    {
        [self.gongyiImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
    else if (typeBtn.tag==2)
    {
        [self.chuangyiImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
    else if (typeBtn.tag==3)
    {
        [self.shenghuoImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
    else if (typeBtn.tag==4)
    {
        [self.yishuImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
    else if (typeBtn.tag==5)
    {
        [self.nongyeImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
    else if (typeBtn.tag==6)
    {
        [self.mengxiangImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
    else if (typeBtn.tag==7)
    {
        [self.qitaImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
    }
}
-(void)setMyTyteString
{
    switch (self.typeIndex)
    {
        case 0:
            self.typeString=@"TECH";
            break;
        case 1:
            self.typeString=@"COMMON_WEAL";
            break;
        case 2:
            self.typeString=@"CREATIVE";
            break;
        case 3:
            self.typeString=@"LIFE";
            break;
        case 4:
            self.typeString=@"ART";
            break;
        case 5:
            self.typeString=@"AGRICULTURE";
            break;
        case 6:
            self.typeString=@"DREAMS";
            break;
        case 7:
            self.typeString=@"OTHERS";
            break;
        default:
            break;
    }
}
-(void)setAllTypeUnselected
{
    [self.kejiImg setImage:[UIImage imageNamed:@"circle"]];
    [self.gongyiImg setImage:[UIImage imageNamed:@"circle"]];
    [self.chuangyiImg setImage:[UIImage imageNamed:@"circle"]];
    [self.shenghuoImg setImage:[UIImage imageNamed:@"circle"]];
    [self.yishuImg setImage:[UIImage imageNamed:@"circle"]];
    [self.nongyeImg setImage:[UIImage imageNamed:@"circle"]];
    [self.mengxiangImg setImage:[UIImage imageNamed:@"circle"]];
    [self.qitaImg setImage:[UIImage imageNamed:@"circle"]];
}
-(IBAction)textViewBtnpressed:(id)sender
{
    [self.labelDescription setHidden:YES];
    [self.textViewDescription becomeFirstResponder];
}
-(IBAction)regionsBtnPressed:(id)sender
{
    [self.delegate showSelectRegionsVC];
}
-(IBAction)readedAndAdmitBtn:(id)sender
{
    if ([self.gouImg.image isEqual:[UIImage imageNamed:@"gou_fangkuang"]])
    {
        [self.gouImg setImage:[UIImage imageNamed:@"fangkuang"]];
    }
    else
    {
        [self.gouImg setImage:[UIImage imageNamed:@"gou_fangkuang"]];
    }
}
-(IBAction)launchZhongchou:(id)sender
{
    if([self.gouImg.image isEqual:[UIImage imageNamed:@"fangkuang"]])
    {
        [self.delegate showMessage:@"需同意协议条款"];
        return;
    }
    
    NSDictionary *launchData=[NSDictionary dictionaryWithObjects:@[[[MyFounctions getUserInfo] objectForKey:@"uid"],self.textfieldUseName.text,self.textfieldPhone.text,self.textfieldProjectName.text,self.textfieldAmount.text,self.textfieldDays.text,self.typeString,[self.province objectForKey:@"code"],[self.city objectForKey:@"code"],self.textViewDescription.text,@"PAY_BACK_INVESTOR"] forKeys:@[@"uid",@"crowdfundingApply.applyUsername",@"crowdfundingApply.phoneNum",@"crowdfundingApply.crowdfundingName",@"crowdfundingApply.crowdfundingAmt",@"crowdfundingApply.crowdfundingDays",@"crowdfundingApply.crowdfundingType",@"crowdfundingApply.crowdfundingProvince",@"crowdfundingApply.crowdfundingCity",@"crowdfundingApply.crowdfundingDesc",@"crowdfundingApply.notDoneTodo"]];
    [self.delegate launchZhongchou:launchData];
}
@end
