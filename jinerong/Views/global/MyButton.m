//
//  MyButton.m
//  weixueche
//
//  Created by carcool on 12/4/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
-(void)setColor:(UIColor*)colo
{
//    [self setFrame:CGRectMake(PARENT_X(self), PARENT_Y(self),280 , 32.5)];
    [self setBackgroundColor:colo];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [self setClipsToBounds:YES];
    [self.layer setCornerRadius:3.0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
