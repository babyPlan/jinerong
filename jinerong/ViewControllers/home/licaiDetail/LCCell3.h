//
//  LCCell3.h
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCell3 : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;

@property (weak, nonatomic) IBOutlet UILabel *labelGrade;
@property (weak, nonatomic) IBOutlet UILabel *labelSuccess;
@property (weak, nonatomic) IBOutlet UILabel *labelclear;

-(void)updateViews;
@end
