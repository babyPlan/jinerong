//
//  MyZhongchouCell.h
//  jinerong
//
//  Created by carcool on 6/2/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyZhongchouCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet WebImageViewNormal *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelRate;
@property (weak, nonatomic) IBOutlet UILabel *labelKuai;
@property(nonatomic,retain)NSDictionary *data;
-(void)updateViews;

@end
