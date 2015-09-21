//
//  SuggestBottomCell.h
//  jinerong
//
//  Created by carcool on 6/3/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestVC.h"
@interface SuggestBottomCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,retain)IBOutlet UITextView *textView;
@property(nonatomic,retain)IBOutlet UITextField *textField;
@property(nonatomic,assign)SuggestVC *delegate;

@end
