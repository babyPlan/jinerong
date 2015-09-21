//
//  PayVC.h
//  jinerong
//
//  Created by carcool on 6/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface PayVC : JERViewController<UITextFieldDelegate>
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UITextField *textFieldPayPassword;
@property(nonatomic,retain)IBOutlet UIView *textFieldBG;
@property(nonatomic,retain)IBOutlet UILabel *labelPayAmount;
@property(nonatomic,retain)IBOutlet UILabel *labelBalence;
@end
