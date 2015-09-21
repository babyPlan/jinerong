//
//  LCCell9.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LicaiDetailVC.h"
@interface LCCell9 : UITableViewCell
@property(nonatomic,retain)IBOutlet MyButton *btn;
@property(nonatomic,assign)LicaiDetailVC *delegate;
@property(nonatomic,retain)NSDictionary *data;
-(void)updateViews;

@end
