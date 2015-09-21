//
//  Register2Cell.h
//  jinerong
//
//  Created by carcool on 6/3/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterVC2.h"
@interface Register2Cell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UITextField *textFieldName;
@property(nonatomic,retain)IBOutlet UITextField *textFieldID;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPassword;
@property(nonatomic,retain)IBOutlet UITextField *textFieldResetPassword;
@property(nonatomic,assign)RegisterVC2 *delegate;
@end
