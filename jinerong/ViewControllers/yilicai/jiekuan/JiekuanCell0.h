//
//  JiekuanCell0.h
//  jinerong
//
//  Created by zhaoml on 15/9/15.
//  Copyright (c) 2015年 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JiekuanCell0 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineview0;
@property (weak, nonatomic) IBOutlet UIView *lineview1;
@property (weak, nonatomic) IBOutlet UIView *lineview2;
@property (weak, nonatomic) IBOutlet UIView *lineview3;
@property (weak, nonatomic) IBOutlet UIView *lineview4;
@property (weak, nonatomic) IBOutlet UIView *lineview5;
@property (weak, nonatomic) IBOutlet UIView *lineview6;
@property (weak, nonatomic) IBOutlet UIImageView *imagePerson;
@property (weak, nonatomic) IBOutlet UIImageView *imageCompany;
- (IBAction)btnPerson:(id)sender;
- (IBAction)btnCompany:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *typeFIrst;
@property (weak, nonatomic) IBOutlet UIImageView *typeSecond;

@end
