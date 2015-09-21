//
//  ZhongchouListVC.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface ZhongchouListVC : JERViewController
@property(nonatomic,assign)NSInteger selectedType;
@property(nonatomic,retain)NSMutableArray *m_aryDatas;
@property(nonatomic,retain)NSMutableArray *m_aryAdvers;
-(void)launchZhongchou;
-(void)updateData;
-(void)updateCarousels;
@end
