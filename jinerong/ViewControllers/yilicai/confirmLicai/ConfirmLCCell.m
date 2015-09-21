//
//  ConfirmLCCell.m
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ConfirmLCCell.h"
#import "ConfirmLicaiVC.h"
@implementation ConfirmLCCell

- (void)awakeFromNib {
    // Initialization code
    [self.btn setColor:JER_RED];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    [self.gouImg setImage:[UIImage imageNamed:@"gou_fangkuang"]];
    self.textFieldBid.delegate=self;
    self.BidAmount=0;
    self.PayAmount=0;
    self.expectEarn=0;
    self.redPacket=0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateViews
{
    self.labelAward.text=[NSString stringWithFormat:@"%@％",[self.data objectForKey:@"iawardRate"]];
    self.labelDaysLeft.text=[self.data objectForKey:@"investEndTime"];
    self.labelMoneyTotal.text=[self.data objectForKey:@"totalAmount"];
    self.labelName.text=[self.data objectForKey:@"projectName"];
    self.labelRate.text=[self.data objectForKey:@"yearRate"];
    self.labelRepaymentMethord.text=[self.data objectForKey:@"repaymentTypeDesc"];
    self.labelTime.text=[NSString stringWithFormat:@"%ld个月",(long)[[self.data objectForKey:@"dueTime"] integerValue]];
    self.labelUid.text=self.nickName;
}
#pragma mark ------- textField delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    float textfiled_y=[textField convertRect:self.delegate.view.frame toView:self.delegate.view].origin.y;
    if (textfiled_y>Screen_Height-KEYBOARD_HEIGHT)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y;
        [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view),PARENT_Y(self.delegate.view)+_y , PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    }

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    [self.delegate.view setFrame:CGRectMake(PARENT_X(self.delegate.view),64 , PARENT_WIDTH(self.delegate.view), PARENT_HEIGHT(self.delegate.view))];
    //judge wheather is number
    if (![MyFounctions isPureNumandCharacters:textField.text])
    {
        [self.delegate showMessage:@"请输入正确金额"];
        self.textFieldBid.text=@"";
        self.labelPay.text=@"0元";
        return YES;
    }
    //judge the amount
    if ([textField.text integerValue]>[[self.data objectForKey:@"balanceAmt"] integerValue])
    {
        
        [self.delegate showMessage:@"不能超过可投金额"];
        self.textFieldBid.text=@"";
        self.labelPay.text=@"0元";
        return YES;
    }
    //calculate expect earning
    
    self.BidAmount=[self.textFieldBid.text integerValue];
    
    self.expectEarn=[textField.text integerValue]*[[self.data objectForKey:@"yearRate"] floatValue]/100.0/12.0*[[self.data objectForKey:@"dueTime"] floatValue];
    self.labelExpectEarn.text=[NSString stringWithFormat:@"%.2f元",self.expectEarn];
    
    self.PayAmount=self.BidAmount-self.redPacket;
    self.labelPay.text=[NSString stringWithFormat:@"%.2f元",self.PayAmount];
    
    self.delegate.bidMoney=[NSString stringWithFormat:@"%f",self.PayAmount];
    return YES;
}
#pragma mark ------ event response
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
-(IBAction)bidBtnPressed:(id)sender
{
    if([self.gouImg.image isEqual:[UIImage imageNamed:@"fangkuang"]])
    {
        [self.delegate showMessage:@"需同意协议条款"];
        return;
    }
    [self.delegate bidTheItem:[NSString stringWithFormat:@"%ld",(long)self.BidAmount] redPacket:[NSString stringWithFormat:@"%.2f",self.redPacket]];
}
-(IBAction)showRedPackets:(id)sender
{
    [self.delegate creatPickerView];
}

- (IBAction)pressBtntoHtml:(id)sender {
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self addSubview:self.webView];
    _webView.delegate =self;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"loan_protocol" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
}


@end
