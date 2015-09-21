//
//  TransferDebtCell1.h
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferDebtVC.h"
@interface TransferDebtCell1 : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UIView *lineView1;
@property(nonatomic,retain)IBOutlet UIView *lineView2;
@property(nonatomic,retain)IBOutlet UIView *lineView3;
@property(nonatomic,retain)IBOutlet UIView *lineView4;
@property(nonatomic,assign)TransferDebtVC *delegate;
@property(nonatomic,retain)IBOutlet UITextField *textFieldTransfer;
@property(nonatomic,retain)IBOutlet UITextField *textFieldSellPrice;
@property(nonatomic,retain)IBOutlet UITextField *textFieldVerifyCode;
@end
