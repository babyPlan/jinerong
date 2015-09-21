//
//  JiekuanCell2.h
//  jinerong
//
//  Created by carcool on 5/27/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LicaiListVC;
@interface JiekuanCell2 : UITableViewCell<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,assign)LicaiListVC *delegate;
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UIView *lineView1;
@property(nonatomic,retain)IBOutlet UIView *lineView2;
@property(nonatomic,retain)IBOutlet UIView *lineView3;
@property(nonatomic,retain)IBOutlet UIView *lineView4;
@property(nonatomic,retain)IBOutlet UIImageView *personalImg;
@property(nonatomic,retain)IBOutlet UIImageView *enterpriseImg;
@property (weak, nonatomic) IBOutlet UILabel *labelDir;

@property(nonatomic,retain)IBOutlet UIView *mainView;
@property(nonatomic,retain)IBOutlet UILabel *labelDescription;
@property(nonatomic,retain)IBOutlet UITextView *textView;
@property(nonatomic,retain)IBOutlet UILabel *labelDiyawu;
@property(nonatomic,retain)IBOutlet UITextField *textFieldMoney;
@property(nonatomic,retain)IBOutlet UITextField *textFieldUseWay;
@property(nonatomic,retain)IBOutlet UITextField *textFieldArea;
@property(nonatomic,retain)IBOutlet UITextField *textFieldDiyawu;
@property(nonatomic,retain)IBOutlet UILabel *labelMyDescription;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,assign)float originalHeight_superView;
@property(nonatomic,assign)NSInteger borrowType;//0:信用贷1:抵押贷2:担保贷
-(void)changeJiekuanTypeSmall;
-(void)updateViews;
-(void)showSelectedMonth:(NSString*)month;
@end
