//
//  ConfirmZCCell.h
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfirmZhongchouVC;
@interface ConfirmZCCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UIView *lineView1;
@property(nonatomic,retain)IBOutlet UIView *lineView2;
@property(nonatomic,retain)IBOutlet UIView *lineView3;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSDictionary *supportData;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelRepayment;
@property(nonatomic,retain)IBOutlet UILabel *labelSupportMoney;
@property(nonatomic,retain)IBOutlet UILabel *labelSendFee;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelPay;
@property(nonatomic,retain)IBOutlet UITextField *textfieldName;
@property(nonatomic,retain)IBOutlet UITextField *textfieldPhone;
@property(nonatomic,retain)IBOutlet UITextField *textfieldArea;
@property(nonatomic,retain)IBOutlet UITextField *textfieldAddress;
@property(nonatomic,retain)ConfirmZhongchouVC *delegate;
-(void)updateViews;
@end
