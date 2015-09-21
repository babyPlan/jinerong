//
//  MycenterVC.h
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface MycenterVC : JERViewController
@property(nonatomic,retain)IBOutlet UILabel *labelLogin;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelPhone;
@property (weak, nonatomic) IBOutlet WebImageViewNormal *imageHead;

@end
