//
//  TransferDebtCell0.h
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferDebtVC.h"
@interface TransferDebtCell0 : UITableViewCell
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,assign)TransferDebtVC *delegate;
@property(nonatomic,retain)IBOutlet UISwitch *m_switch;
@property(nonatomic,retain)IBOutlet UILabel *labelTransID;
@property(nonatomic,retain)IBOutlet UILabel *labelStatus;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UIImageView *headTypeImg;
@property(nonatomic,retain)IBOutlet UIImageView *ByTypeImg;
@property(nonatomic,retain)IBOutlet UIImageView *jiangImg;
@property(nonatomic,retain)IBOutlet UILabel *labelInvestMoney;
@property(nonatomic,retain)IBOutlet UILabel *labelYearRate;
@property(nonatomic,retain)IBOutlet UILabel *labelInvestMonths;
@property(nonatomic,retain)IBOutlet UILabel *labelBuyTime;
@property(nonatomic,retain)IBOutlet UILabel *labelStartTime;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSDictionary *investing;
@property(nonatomic,retain)NSString *status;
-(void)updateViews;
@end
