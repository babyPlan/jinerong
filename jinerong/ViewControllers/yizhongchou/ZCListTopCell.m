//
//  ZCListTopCell.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ZCListTopCell.h"

@implementation ZCListTopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)creatPageScrollview
{
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:self.m_aryAdvers.count delegate:self];
    self.imagePlayerView.scrollInterval = 5.0f;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
}
#pragma mark ------------- image player delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
    NSLog(@"index: %@",[self.m_aryAdvers objectAtIndex:index]);
    [[self.m_aryAdvers objectAtIndex:index] objectForKey:@"url"];
    [imageView setWebImageViewWithURL:[NSURL URLWithString:    [[self.m_aryAdvers objectAtIndex:index] objectForKey:@"url"]]];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}


-(void)viewDidLayoutSubviews
{
    
}
@end
