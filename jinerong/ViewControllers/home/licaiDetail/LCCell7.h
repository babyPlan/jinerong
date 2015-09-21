//
//  LCCell7.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCCell7 : UITableViewCell
@property(nonatomic,retain)NSMutableArray *m_aryBids;
@property(nonatomic,retain)IBOutlet UIView *contentBG;
@property(nonatomic,retain)IBOutlet UILabel *labelExpand;
@property(nonatomic,assign)NSInteger expandFlag;//0:no expand 1:expand
-(void)updateViews;
@end
