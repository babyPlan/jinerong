//
//  BankListCell.h
//  jinerong
//
//  Created by carcool on 6/18/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankListVC;
@interface BankListCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UIImageView *imgGou;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)BankListVC *delegate;
@end
