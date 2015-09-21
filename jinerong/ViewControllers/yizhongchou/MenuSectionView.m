//
//  MenuSectionView.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MenuSectionView.h"
#import "MoreMenuView.h"
@implementation MenuSectionView
-(void)awakeFromNib
{
    [self.btn0 setBackgroundColor:JER_RED];
    [self.btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundColor:JER_BG_GRAY];
}
-(void)setSelectedViews:(NSInteger)index
{
    if (index<=4)
    {
        [self setAllBtnUnselected];
        for (UIButton *btn in [self subviews])
        {
            if (btn.tag==index)
            {
                [btn setBackgroundColor:JER_RED];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    else
    {
        [self setAllBtnUnselected];
        [self.btn5 setBackgroundColor:JER_RED];
        [self.btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        switch (index-4)
        {
            case 0:
                [self.btn5 setTitle:@"..." forState:UIControlStateNormal];
                break;
            case 1:
                [self.btn5 setTitle:@"梦想" forState:UIControlStateNormal];
                self.delegate.selectedType=5;
                break;
            case 2:
                [self.btn5 setTitle:@"艺术" forState:UIControlStateNormal];
                self.delegate.selectedType=6;
                break;
            case 3:
                [self.btn5 setTitle:@"农业" forState:UIControlStateNormal];
                self.delegate.selectedType=7;
                break;
            case 4:
                [self.btn5 setTitle:@"其他" forState:UIControlStateNormal];
                self.delegate.selectedType=8;
                break;
            case 5:
                //            [self.btn5 setTitle:@"发布" forState:UIControlStateNormal];
                break;
            default:
                break;
        }

    }
}
#pragma mark -------- event response
-(IBAction)BtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==5)
    {
        MoreMenuView *more=[[[NSBundle mainBundle] loadNibNamed:@"MoreMenuView" owner:nil options:nil] objectAtIndex:0];
        [more setFrame:CGRectMake(PARENT_X(btn), PARENT_Y(btn)+160, PARENT_WIDTH(more), PARENT_HEIGHT(more))];
        more.delegate=self;
        [[self superview] addSubview:more];
    }
    else
    {
        [self setAllBtnUnselected];
        [btn setBackgroundColor:JER_RED];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.delegate.selectedType=btn.tag;
        self.delegate.pageIndex=1;
        [self.delegate updateData];
    }
}
-(void)setAllBtnUnselected
{
    [self.btn0 setBackgroundColor:[UIColor clearColor]];
    [self.btn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 setBackgroundColor:[UIColor clearColor]];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn2 setBackgroundColor:[UIColor clearColor]];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn3 setBackgroundColor:[UIColor clearColor]];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn4 setBackgroundColor:[UIColor clearColor]];
    [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn5 setBackgroundColor:[UIColor clearColor]];
    [self.btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn5 setTitle:@"..." forState:UIControlStateNormal];
}
-(void)setMoreMenuViewSelectedItem:(NSInteger)index
{
    if (index==0)
    {
        return;
    }
    else if (index==5)
    {
        [self.delegate launchZhongchou];
        return;
    }
    
    [self setAllBtnUnselected];
    [self.btn5 setBackgroundColor:JER_RED];
    [self.btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    switch (index)
    {
        case 0:
            [self.btn5 setTitle:@"..." forState:UIControlStateNormal];
            break;
        case 1:
            [self.btn5 setTitle:@"梦想" forState:UIControlStateNormal];
            self.delegate.selectedType=5;
            break;
        case 2:
            [self.btn5 setTitle:@"艺术" forState:UIControlStateNormal];
            self.delegate.selectedType=6;
            break;
        case 3:
            [self.btn5 setTitle:@"农业" forState:UIControlStateNormal];
            self.delegate.selectedType=7;
            break;
        case 4:
            [self.btn5 setTitle:@"其他" forState:UIControlStateNormal];
            self.delegate.selectedType=8;
            break;
        case 5:
//            [self.btn5 setTitle:@"发布" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    self.delegate.pageIndex=1;
    [self.delegate updateData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
