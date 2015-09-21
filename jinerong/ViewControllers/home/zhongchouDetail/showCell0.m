//
//  showCell0.m
//  jinerong
//
//  Created by zhaoml on 15/8/6.
//  Copyright (c) 2015年 qinyun. All rights reserved.
//

#import "showCell0.h"

@implementation showCell0

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:[UIColor clearColor]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews{
    [self.imagePic setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"productPicUrl"]]];
    self.labelDesc.text=[self filterHTML:[self.data objectForKey:@"productDesc"]];
    
    //update cell hight
    self.labelDesc.numberOfLines=0;
    float textHeight=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"productDesc"] Width:278 font:[UIFont systemFontOfSize:15.0]];
    [self.labelDesc setFrame:CGRectMake(PARENT_X(self.labelDesc), PARENT_Y(self.labelDesc), PARENT_WIDTH(self.labelDesc), textHeight)];
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
@end
