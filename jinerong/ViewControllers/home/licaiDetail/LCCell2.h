//
//  LCCell2.h
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCell2 : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelWho;
@property(nonatomic,retain)IBOutlet UILabel *labelSex;
@property(nonatomic,retain)IBOutlet UILabel *labelAge;
@property(nonatomic,retain)IBOutlet UILabel *labelGrade;
@property(nonatomic,retain)IBOutlet UILabel *labelMarry;
-(void)updateViews;
@end
