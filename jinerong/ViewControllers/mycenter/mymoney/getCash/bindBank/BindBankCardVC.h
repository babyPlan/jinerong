//
//  BindBankCardVC.h
//  jinerong
//
//  Created by carcool on 6/16/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface BindBankCardVC : JERViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UITextField *textFieldCardID;
@property(nonatomic,retain)IBOutlet UITextField *textFieldUserName;
@property(nonatomic,retain)IBOutlet UILabel *labelBank;
@property(nonatomic,retain)NSDictionary *m_dicBank;
@property(nonatomic,retain)NSString *oldBankCardID;
@end
