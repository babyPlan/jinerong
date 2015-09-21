//
//  MenuSectionView.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhongchouListVC.h"
@interface MenuSectionView : UIView
@property(nonatomic,retain)IBOutlet UIButton *btn0;
@property(nonatomic,retain)IBOutlet UIButton *btn1;
@property(nonatomic,retain)IBOutlet UIButton *btn2;
@property(nonatomic,retain)IBOutlet UIButton *btn3;
@property(nonatomic,retain)IBOutlet UIButton *btn4;
@property(nonatomic,retain)IBOutlet UIButton *btn5;
@property(nonatomic,assign)ZhongchouListVC *delegate;
-(void)setAllBtnUnselected;
-(void)setMoreMenuViewSelectedItem:(NSInteger)index;
-(void)setSelectedViews:(NSInteger)index;
@end
