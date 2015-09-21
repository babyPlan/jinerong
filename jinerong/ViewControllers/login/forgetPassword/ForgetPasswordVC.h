//
//  ForgetPasswordVC.h
//  jinerong
//
//  Created by carcool on 6/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface ForgetPasswordVC : JERViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UILabel *labelSendYZM;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPhone;
@property(nonatomic,retain)IBOutlet UITextField *textFieldCode;
@property(nonatomic,assign)NSInteger time;
@end
