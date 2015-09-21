//
//  ApplyRecordBorrowVC.m
//  jinerong
//
//  Created by carcool on 6/11/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ApplyRecordBorrowVC.h"

@interface ApplyRecordBorrowVC ()

@end

@implementation ApplyRecordBorrowVC
@synthesize data;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"借款申请";
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
    self.labelAmount.text=[data objectForKey:@"borrowAmt"];
    self.labelArea.text=[data objectForKey:@"borrowAddr"];
    self.labelDescription.text=[data objectForKey:@"borrowDesc"];
    self.labelLimitedMonth.text=[NSString stringWithFormat:@"%@个月",[data objectForKey:@"borrowPeriod"]];
    self.labelMainBody.text=[data objectForKey:@"borrowUserType"];
    if ([[data objectForKey:@"applyStatus"] isEqual:@"APPLY_ING"]) {
        self.labelStatus.text=@"待审核";
    }else if ([[data objectForKey:@"applyStatus"] isEqual:@"AUDIT_ING"]) {
        self.labelStatus.text=@"审核中";
    }else if ([[data objectForKey:@"applyStatus"] isEqual:@"AUDIT_FAIL"]) {
        self.labelStatus.text=@"审核失败";
    }else if ([[data objectForKey:@"applyStatus"] isEqual:@"AUDIT_SUCCESS"]) {
        self.labelStatus.text=@"审核成功";
    }else if ([[data objectForKey:@"applyStatus"] isEqual:@"APPLY_CANCEL"]) {
        self.labelStatus.text=@"审核取消";
    }
    self.labelSubmitTime.text=[data objectForKey:@"createdOn"];
    self.labelType.text=[data objectForKey:@"borrowTypeName"];
    self.labelUseFor.text=[data objectForKey:@"borrowUse"];
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
