//
//  LCCell2expand.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCell2expand : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UIView *contentBG;
@property(nonatomic,retain)IBOutlet UILabel *labelExpand;
@property(nonatomic,retain)IBOutlet UILabel *labelWho;
@property(nonatomic,retain)IBOutlet UILabel *labelSex;
@property(nonatomic,retain)IBOutlet UILabel *labelAge;
@property(nonatomic,retain)IBOutlet UILabel *labelGrade;
@property(nonatomic,retain)IBOutlet UILabel *labelMarry;
@property(nonatomic,retain)IBOutlet UILabel *labelIndustry;
@property(nonatomic,retain)IBOutlet UILabel *labelCity;
@property(nonatomic,retain)IBOutlet UILabel *labelPosition;
@property(nonatomic,retain)IBOutlet UILabel *labelWorkTime;
@property(nonatomic,retain)IBOutlet UILabel *labelEarnPerYear;
@property(nonatomic,retain)IBOutlet UILabel *labelHouse;
@property(nonatomic,retain)IBOutlet UILabel *labelHorseLoan;
@property(nonatomic,retain)IBOutlet UILabel *labelCar;
@property(nonatomic,retain)IBOutlet UILabel *labelCarLoan;
-(void)updateViews;
@end
