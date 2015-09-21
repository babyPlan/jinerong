//
//  TransactionRecordsMenuView.m
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TransactionRecordsMenuView.h"
#import "TransactionRecordsVC.h"
@implementation TransactionRecordsMenuView
@synthesize m_aryDates,m_aryTypes;
-(void)awakeFromNib
{
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
    
    self.m_aryDates=[NSMutableArray arrayWithObjects:@"今天",@"最近一周",@"一个月",@"三个月",@"半年",@"一年",@"全部",@"", nil];
    self.m_aryTypes=[NSMutableArray arrayWithObjects:@"全部",@"充值",@"提现",@"投资",@"回收本金",@"回收利息",@"红包",@"借款金", nil];
    self.m_aryBtns=[NSMutableArray arrayWithObjects:self.btn0,self.btn1,self.btn2,self.btn3,self.btn4,self.btn5,self.btn6,self.btn7, nil];
    self.dateOrType=0;
    
    NSInteger i=0;
    for (UIButton *btn in self.m_aryBtns)
    {
        btn.tag=i;
        i++;
    }
}
-(void)updateViewDate
{
    self.dateOrType=0;
    
    NSInteger i=0;
    while (i<self.m_aryDates.count)
    {
        UIButton *btn=[self.m_aryBtns objectAtIndex:i];
        [btn setTitle:[self.m_aryDates objectAtIndex:i] forState:UIControlStateNormal];
        i++;
    }
    self.btn7.hidden=YES;
}
-(void)updateViewTypes
{
    self.dateOrType=1;
    
    NSInteger i=0;
    while (i<self.m_aryTypes.count)
    {
        UIButton *btn=[self.m_aryBtns objectAtIndex:i];
        [btn setTitle:[self.m_aryTypes objectAtIndex:i] forState:UIControlStateNormal];
        i++;
    }
    self.btn7.hidden=NO;
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    NSLog(@"btn.tag :%ld",(long)btn.tag);
    
    if (self.dateOrType==0)
    {
        [self.delegate setDate:btn.tag title:[self.m_aryDates objectAtIndex:btn.tag]];
    }
    else
    {
        [self.delegate setType:btn.tag title:[self.m_aryTypes objectAtIndex:btn.tag]];
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
