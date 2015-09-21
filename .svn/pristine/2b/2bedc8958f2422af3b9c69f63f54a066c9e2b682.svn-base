//
//  LCCell5.m
//  jinerong
//
//  Created by carcool on 5/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LCCell5.h"

@implementation LCCell5

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
    NSLog(@"index: %@",[[self.data objectForKey:@"authRecords"] objectAtIndex:index]);
    [[[self.data objectForKey:@"authRecords"]objectAtIndex:index] objectForKey:@"authInfoAddr"];
    [imageView setWebImageViewWithURL:[NSURL URLWithString:    [[[self.data objectForKey:@"authRecords"] objectAtIndex:index] objectForKey:@"authInfoAddr"]]];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}



-(void)updateViews{
    
   // [self.imageHead setWebImageViewWithURL:[NSURL URLWithString:[[[self.data objectForKey:@"authRecords"] lastObject ]objectForKey:@"authInfoAddr"]]];
   
    
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:[[self.data objectForKey:@"authRecords"] count] delegate:self];
    self.imagePlayerView.scrollInterval = 5.0f;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;

}


@end
