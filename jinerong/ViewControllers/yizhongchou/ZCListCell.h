//
//  ZCListCell.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCListCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelDays;
@property(nonatomic,retain)IBOutlet UILabel *labelDealRate;
@property(nonatomic,retain)IBOutlet UILabel *labelMoney;
@property(nonatomic,retain)IBOutlet UILabel *labelPeople;
@property(nonatomic,retain)IBOutlet UIView *grayView;
@property(nonatomic,retain)IBOutlet UIView *redView;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *img;
-(void)updateViews;
@end
