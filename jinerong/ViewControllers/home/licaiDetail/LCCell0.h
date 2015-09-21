//
//  LCCell0.h
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCell0 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelId;
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UIView *lineView1;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelRate;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelMoney;
@property(nonatomic,retain)IBOutlet UIImageView *headTypeImg;
@property(nonatomic,retain)IBOutlet UIImageView *ByTypeImg;
@property(nonatomic,retain)IBOutlet UIImageView *jiangImg;
@property(nonatomic,retain)NSDictionary *data;
-(void)updateViews;
@end