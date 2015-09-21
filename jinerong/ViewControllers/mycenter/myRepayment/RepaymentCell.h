//
//  RepaymentCell.h
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepaymentCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelNumber;
@property(nonatomic,retain)IBOutlet UILabel *labelRepaymethord;
@property(nonatomic,retain)IBOutlet UILabel *labelDate;
-(void)updateViews;
@end
