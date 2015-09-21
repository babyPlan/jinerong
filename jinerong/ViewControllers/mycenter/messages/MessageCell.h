//
//  MessageCell.h
//  jinerong
//
//  Created by carcool on 7/15/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelTime;
@property(nonatomic,retain)IBOutlet UILabel *labelContent;
@property(nonatomic,retain)IBOutlet UIImageView *redPoint;
@property(nonatomic,retain)NSDictionary *data;
-(void)updateViews;
@end
