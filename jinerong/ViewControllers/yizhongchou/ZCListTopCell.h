//
//  ZCListTopCell.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCListTopCell : UITableViewCell<ImagePlayerViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
@property(nonatomic,retain)NSMutableArray *m_aryAdvers;
-(void)creatPageScrollview;
@end
