//
//  MyInfoCell2.h
//  jinerong
//
//  Created by carcool on 6/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyInfoVC;
@interface MyInfoCell2 : UITableViewCell
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,assign)MyInfoVC *delegate;
@end
