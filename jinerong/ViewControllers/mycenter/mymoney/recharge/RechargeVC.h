//
//  RechargeVC.h
//  jinerong
//
//  Created by carcool on 6/12/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface RechargeVC : JERViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UIView *lineView1;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UIImageView *personImg;
@property(nonatomic,retain)IBOutlet UIImageView *enterpriseImg;
@property(nonatomic,retain)IBOutlet UIImageView *gouImg;
@property(nonatomic,retain)IBOutlet UITextField *textFiedMoney;
@property(nonatomic,retain)UIPickerView* pickerView ;
@property(nonatomic,retain)UIButton *doneBtn;
@property(nonatomic,retain)UIView *shieldView;
@property(nonatomic,retain)IBOutlet UILabel *labelBank;
@property(nonatomic,retain)NSMutableArray *m_aryBanks;
@property(nonatomic,assign)NSInteger rechargeType;//0:personal 1:enterprise
@property(nonatomic,retain)NSString *bankCode;
@property(nonatomic,retain)NSString *rechargeDescription;
@property(nonatomic,retain)NSString *ip;
@property(nonatomic,assign)NSInteger isRealName;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSString *resultStr;
@property(nonatomic,retain)NSData *resultData;
@end
