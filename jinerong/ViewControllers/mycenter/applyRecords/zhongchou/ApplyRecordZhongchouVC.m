//
//  ApplyRecordZhongchouVC.m
//  jinerong
//
//  Created by carcool on 6/11/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ApplyRecordZhongchouVC.h"

@interface ApplyRecordZhongchouVC ()

@end

@implementation ApplyRecordZhongchouVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"众筹发布";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateViews
{
    self.labelAdrress.text=[NSString stringWithFormat:@"%@ %@",[self.data objectForKey:@"crowdfundingProvince"],[self.data objectForKey:@"crowdfundingCity"]];
    self.labelAmount.text=[self.data objectForKey:@"crowdfundingAmt"];
    self.labelDays.text=[NSString stringWithFormat:@"%@天",[self.data objectForKey:@"crowdfundingDays"]];
    self.labelDescription.text=[self.data objectForKey:@"crowdfundingDesc"];
    self.labelDescription.autoresizesSubviews=false;
    self.labelDescription.lineBreakMode=UILineBreakModeWordWrap;
    self.labelDescription.numberOfLines = 0;

    
    self.labelPhone.text=[self.data objectForKey:@"phoneNum"];
    self.labelProjectName.text=[self.data objectForKey:@"crowdfundingName"];
    
    if ([[self.data objectForKey:@"status"] isEqual:@"APPLYING"]) {
        self.labelStatus.text=@"待审核";
    }else if ([[self.data objectForKey:@"status"] isEqual:@"AUDITING"]) {
        self.labelStatus.text=@"审核中";
    }else if ([[self.data objectForKey:@"status"] isEqual:@"AUDITFAIL"]) {
        self.labelStatus.text=@"审核失败";
    }else if ([[self.data objectForKey:@"status"] isEqual:@"AUDITSUCCESS"]) {
        self.labelStatus.text=@"审核成功";
    }else if ([[self.data objectForKey:@"status"] isEqual:@"APPLYCANCEL"]) {
        self.labelStatus.text=@"取消申请";
    }
    self.labelSubmitTime.text=[self.data objectForKey:@"createdOn"];
    self.labelType.text=[self setZhongchouTypeChinese:[self.data objectForKey:@"crowdfundingType"]];
    self.labelUserName.text=[self.data objectForKey:@"applyUsername"];
    
}
-(NSString*)setZhongchouTypeChinese:(NSString*)type
{
    NSString *typeChinese=@"";
    if ([type isEqualToString:@"TECH"])
    {
        typeChinese=@"科技";
    }
    else if ([type isEqualToString:@"COMMON_WEAL"])
    {
        typeChinese=@"公益";
    }
    else if ([type isEqualToString:@"CREATIVE"])
    {
        typeChinese=@"创意";
    }
    else if ([type isEqualToString:@"LIFE"])
    {
        typeChinese=@"生活";
    }
    else if ([type isEqualToString:@"ART"])
    {
        typeChinese=@"艺术";
    }
    else if ([type isEqualToString:@"AGRICULTURE"])
    {
        typeChinese=@"农业";
    }
    else if ([type isEqualToString:@"DREAMS"])
    {
        typeChinese=@"梦想";
    }
    else if ([type isEqualToString:@"OTHERS"])
    {
        typeChinese=@"其他";
    }
    return typeChinese;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
