//
//  ZCCell0.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCCell0 : UITableViewCell
@property(nonatomic,retain)IBOutlet WebImageViewNormal *img;
@property(nonatomic,retain)NSString *picUrl;
-(void)updateViews;
@end
