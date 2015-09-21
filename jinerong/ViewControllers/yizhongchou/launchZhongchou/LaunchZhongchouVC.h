//
//  LaunchZhongchouVC.h
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"
#import "SelectProvinceVC.h"
#import "LaunchZhongchouCell.h"
@interface LaunchZhongchouVC : JERViewController<SelectCityDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)NSDictionary *province;
@property(nonatomic,retain)NSDictionary *city;
@property(nonatomic,retain)LaunchZhongchouCell *m_cell;
-(void)launchZhongchou:(NSDictionary*)launchData;
-(void)showSelectRegionsVC;
@end
