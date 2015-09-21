//
//  LCCell2expand.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell2expand.h"

@implementation LCCell2expand
@synthesize data;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    // labels
    NSDictionary *user=nil;
    if(![[data objectForKey:@"perUser"] isEqual:[NSNull null]])
    {
        self.labelWho.text=@"个人借款";
        user=[NSDictionary dictionaryWithDictionary:[self.data objectForKey:@"perUser"]];
    }
    else
    {
        if(![[data objectForKey:@"comUser"] isEqual:[NSNull null]])
        {
            self.labelWho.text=@"企业借款";
            user=[NSDictionary dictionaryWithDictionary:[self.data objectForKey:@"comUser"]];
        }
        else
        {
            user=[NSDictionary dictionary];
        }
    }
    self.labelAge.text=[NSString stringWithFormat:@"%ld",(long)[[user objectForKey:@"age"] integerValue]];
    self.labelSex.text=[[user objectForKey:@"gender"] integerValue]==1?@"男":@"女";
    self.labelGrade.text= [user objectForKey:@"educationalBackground"];
    if ([[user objectForKey:@"maritalStatus"] isEqual:@"UNMARRIED"]) {
        self.labelMarry.text=@"未婚";
    }else if ([[user objectForKey:@"maritalStatus"] isEqual:@"MARRIED"]) {
        self.labelMarry.text=@"已婚";
    }else if ([[user objectForKey:@"maritalStatus"] isEqual:@"DIVORCED"]) {
        self.labelMarry.text=@"离异";
    }else if ([[user objectForKey:@"maritalStatus"] isEqual:@"WIDOWED"]) {
        self.labelMarry.text=@"丧偶";
    }    self.labelCar.text=[NSString stringWithFormat:[[user objectForKey:@"hasCar"] integerValue]==0?@"无":@"有"];
    self.labelCarLoan.text=[NSString stringWithFormat:[[user objectForKey:@"hasCarloan"] integerValue]==0?@"无":@"有"];
    self.labelCity.text=[user objectForKey:@"liveCity"];
    self.labelEarnPerYear.text=[user objectForKey:@"yearIncome"];
    self.labelHorseLoan.text=[NSString stringWithFormat:[[user objectForKey:@"hasHouseLoan"] integerValue]==0?@"无":@"有"];
    self.labelHouse.text=[NSString stringWithFormat:[[user objectForKey:@"hasHouse"] integerValue]==0?@"无":@"有"];
    self.labelIndustry.text=[user objectForKey:@"companyCategory"];
    self.labelPosition.text=[user objectForKey:@"position"];
    self.labelWorkTime.text=[NSString stringWithFormat:@"%ld年",(long)[[user objectForKey:@"workingYears"] integerValue]];
    
    //auth show
    NSLog(@"cell2expand:%@",[self.data objectForKey:@"authRecords"]);
    NSArray *authArray=[self.data objectForKey:@"authRecords"];
    if (authArray.count>0)
    {
        NSInteger i=0;
        while (i<[authArray count])
        {
            UIImageView *gou=[[UIImageView alloc] initWithFrame:CGRectMake(14, 390+i*25, 12, 12)];
            [gou setImage:[UIImage imageNamed:@"gou_blue"]];
            [self.contentBG addSubview:gou];
            
            UILabel *labelAuth=[[UILabel alloc] initWithFrame:CGRectMake(39, 385+i*25, 65, 20)];
            [labelAuth setText:[[authArray objectAtIndex:i] objectForKey:@"authInfoName"]];
            [labelAuth setTextColor:[UIColor blackColor]];
            [labelAuth setFont:[UIFont systemFontOfSize:14.0]];
            [self.contentBG addSubview:labelAuth];
            
            UILabel *labelStatus=[[UILabel alloc]initWithFrame:CGRectMake(255, 385+i*25, 50, 20)];
            [labelStatus setTextColor:[UIColor grayColor]];
            [labelStatus setFont:[UIFont systemFontOfSize:13.0]];
            if ([[[authArray objectAtIndex:i] objectForKey:@"authStatus"]isEqual:@"CHECKING"]) {
                [labelStatus setText:@"待审核"];
            }else if([[[authArray objectAtIndex:i] objectForKey:@"authStatus"]isEqual:@"NORMAL"]){
                [labelStatus setText:@"有效"];
            }else if([[[authArray objectAtIndex:i] objectForKey:@"authStatus"]isEqual:@"EXPIRED"]){
                [labelStatus setText:@"失效"];
            }else if([[[authArray objectAtIndex:i] objectForKey:@"authStatus"]isEqual:@"CHECK_FAILED"]){
                [labelStatus setText:@"审核拒绝"];
            }
            [self.contentBG addSubview:labelStatus];
            
            i++;
        }
        
        [self.labelExpand setFrame:CGRectMake(PARENT_X(self.labelExpand), 385+i*25, PARENT_WIDTH(self.labelExpand), PARENT_HEIGHT(self.labelExpand))];
        [self.contentBG setFrame:CGRectMake(PARENT_X(self.contentBG), PARENT_Y(self.contentBG), PARENT_WIDTH(self.contentBG), PARENT_Y(self.labelExpand)+35)];
    }
    else
    {
        UILabel *labelAuth=[[UILabel alloc] initWithFrame:CGRectMake(39, 385, 65, 20)];
        [labelAuth setText:@"暂无认证"];
        [labelAuth setTextColor:[UIColor blackColor]];
        [labelAuth setFont:[UIFont systemFontOfSize:14.0]];
        [self.contentBG addSubview:labelAuth];
        
        [self.labelExpand setFrame:CGRectMake(PARENT_X(self.labelExpand), 385+25, PARENT_WIDTH(self.labelExpand), PARENT_HEIGHT(self.labelExpand))];
        [self.contentBG setFrame:CGRectMake(PARENT_X(self.contentBG), PARENT_Y(self.contentBG), PARENT_WIDTH(self.contentBG), PARENT_Y(self.labelExpand)+35)];
    }
    
}
@end
