//
//  ApplyRecordCell.m
//  jinerong
//
//  Created by carcool on 6/11/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ApplyRecordCell.h"

@implementation ApplyRecordCell

- (void)awakeFromNib {
    // Initialization code
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    [MyFounctions setLineViewMoreThin:self.lineView0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    if (self.indexFlag==0)
    {
        self.labelMoney.text=[NSString stringWithFormat:@"借款¥%@",[self.data objectForKey:@"borrowAmt"]];
        self.labelName.text=[self.data objectForKey:@"borrowTitle"];
        if ([[self.data objectForKey:@"applyStatus"] isEqual:@"APPLY_ING"]) {
            self.labelState.text=@"待审核";
        }else if ([[self.data objectForKey:@"applyStatus"] isEqual:@"AUDIT_ING"]) {
            self.labelState.text=@"审核中";
        }else if ([[self.data objectForKey:@"applyStatus"] isEqual:@"AUDIT_FAIL"]) {
            self.labelState.text=@"审核失败";
        }else if ([[self.data objectForKey:@"applyStatus"] isEqual:@"AUDIT_SUCCESS"]) {
            self.labelState.text=@"审核成功";
        }else if ([[self.data objectForKey:@"applyStatus"] isEqual:@"APPLY_CANCEL"]) {
            self.labelState.text=@"取消申请";
        }
        self.labelTime.text=[self.data objectForKey:@"updatedOn"];
    }
    else
    {
        self.labelMoney.text=[NSString stringWithFormat:@"金额¥%@",[self.data objectForKey:@"crowdfundingAmt"]];
        self.labelName.text=[self.data objectForKey:@"crowdfundingName"];
        if ([[self.data objectForKey:@"status"] isEqual:@"APPLYING"]) {
            self.labelState.text=@"待审核";
        }else if ([[self.data objectForKey:@"status"] isEqual:@"AUDITING"]) {
            self.labelState.text=@"审核中";
        }else if ([[self.data objectForKey:@"status"] isEqual:@"AUDITFAIL"]) {
            self.labelState.text=@"审核失败";
        }else if ([[self.data objectForKey:@"status"] isEqual:@"AUDITSUCCESS"]) {
            self.labelState.text=@"审核成功";
        }else if ([[self.data objectForKey:@"status"] isEqual:@"APPLYCANCEL"]) {
            self.labelState.text=@"取消申请";
        }
        self.labelTime.text=[self.data objectForKey:@"updatedOn"];
    }
}
@end
