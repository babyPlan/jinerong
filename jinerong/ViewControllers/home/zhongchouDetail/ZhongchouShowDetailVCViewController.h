//
//  ZhongchouShowDetailVCViewController.h
//  jinerong
//
//  Created by zhaoml on 15/7/23.
//  Copyright (c) 2015年 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhongchouShowDetailVCViewController : JERViewController

@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,retain)NSDictionary *supportData;
@property(nonatomic,retain)NSMutableDictionary *m_detailData;
@property(nonatomic,retain)NSString *crowdFundingId;

-(void)updateData;
@end
