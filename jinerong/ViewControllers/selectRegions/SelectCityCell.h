//
//  SelectCityCell.h
//  jinerong
//
//  Created by carcool on 7/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCityCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
-(void)updateViews;
@end
