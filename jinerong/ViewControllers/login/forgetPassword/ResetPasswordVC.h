//
//  ResetPasswordVC.h
//  jinerong
//
//  Created by carcool on 6/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface ResetPasswordVC : JERViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPassword;
@property(nonatomic,retain)IBOutlet UITextField *textFieldResetPassword;
@property(nonatomic,retain)NSString *phone;
@property(nonatomic,retain)NSString *verifyCode;
@end
