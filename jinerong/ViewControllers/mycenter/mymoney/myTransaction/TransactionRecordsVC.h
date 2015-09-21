//
//  TransactionRecordsVC.h
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"
#import "TransactionRecordsMenuView.h"
@interface TransactionRecordsVC : JERViewController
@property(nonatomic,retain)IBOutlet UIView *lineView0;
@property(nonatomic,retain)IBOutlet UILabel *labelDate;
@property(nonatomic,retain)IBOutlet UILabel *labelType;
@property(nonatomic,retain)IBOutlet UIImageView *imgDate;
@property(nonatomic,retain)IBOutlet UIImageView *imgType;
@property(nonatomic,assign)NSInteger switchFlag;//0:none 1:date 2:type
@property(nonatomic,retain)IBOutlet TransactionRecordsMenuView *menuFlitrateView;
@property(nonatomic,retain)NSMutableArray *m_aryTrasactions;
@property(nonatomic,retain)NSString *orderType;
@property(nonatomic,retain)NSString *fromDate;
@property(nonatomic,retain)NSString *toDate;
-(void)setDate:(NSInteger)index title:(NSString*)str;
-(void)setType:(NSInteger)inde title:(NSString*)str;
@end
