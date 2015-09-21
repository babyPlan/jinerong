//
//  EditInfoVC.h
//  jinerong
//
//  Created by carcool on 6/12/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface EditInfoVC : JERViewController<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UITextField *textField1;
@property(nonatomic,retain)IBOutlet UIImageView *textBG2;
@property(nonatomic,retain)IBOutlet UITextField *textField2;
@property(nonatomic,assign)NSInteger editFlag;//0:nickname 1:id 2:phone 3:login password 4:pay password
@end
