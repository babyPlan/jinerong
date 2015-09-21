//
//  SelectProvinceVC.h
//  jinerong
//
//  Created by carcool on 7/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@protocol SelectCityDelegate <NSObject>

@required
-(void)selecteProvince:(NSDictionary*)province city:(NSDictionary*)city;
@end
@interface SelectProvinceVC : JERViewController
@property(nonatomic,retain)NSMutableArray *m_aryRegions;
@property(nonatomic,retain)NSDictionary *m_province;
@property(nonatomic,assign)id<SelectCityDelegate> delegate;
-(void)completeSelectCity:(NSDictionary*)city;
@end
