//
//  LicaiFiltrateCell.h
//  jinerong
//
//  Created by carcool on 6/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LicaiFiltrateVC.h"
@interface LicaiFiltrateCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *labelTitle;
@property(nonatomic,retain)NSMutableArray *data;
@property(nonatomic,retain)NSMutableArray *m_aryBtns;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *selectedIndexStr;
@property(nonatomic,assign)NSInteger indexCell;
@property(nonatomic,assign)LicaiFiltrateVC *delegate;
-(void)updateViews;

@end
