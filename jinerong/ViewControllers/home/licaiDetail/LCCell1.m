//
//  LCCell1.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell1.h"

@implementation LCCell1
@synthesize data;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    self.imgAwardDescription.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelAwardRate.text=[NSString stringWithFormat:@"%ld％",(long)[[data objectForKey:@"iawardRate"] integerValue]];
    self.labelMethord.text=[data objectForKey:@"repaymentTypeDesc"];
    self.labelMoney.text=[NSString stringWithFormat:@"¥%@",[data objectForKey:@"balanceAmt"]];
    //calculate left days
    NSDate *endDate=[self dateFromString:[data objectForKey:@"investEndTime"]];
    NSDate *currentDate=[NSDate date];
    NSLog(@"date :%@ %@",endDate,currentDate);
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:currentDate  toDate:endDate  options:0];
    NSInteger days = [comps day];
    self.labelTime.text=[NSString stringWithFormat:@"%ld天",(long)(days>0?days:0)];
    
    self.labelPercent.text= [NSString stringWithFormat:@"%ld％",(long)[[data objectForKey:@"progress"] integerValue]];
    [MyFounctions setPercentGrayview:self.grayView redView:self.redView percent:[[data objectForKey:@"progress"] integerValue]];
}
- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}
-(IBAction)showAwardDescription:(id)sender
{
    if (self.imgAwardDescription.hidden==YES)
    {
        self.imgAwardDescription.hidden=NO;
    }
    else
    {
        self.imgAwardDescription.hidden=YES;
    }
}

@end
