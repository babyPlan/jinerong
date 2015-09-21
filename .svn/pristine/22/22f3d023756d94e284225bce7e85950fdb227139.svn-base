//
//  WebImageViewNormal.m
//  weixueche
//
//  Created by carcool on 1/30/15.
//  Copyright (c) 2015 carcool. All rights reserved.
//

#import "WebImageViewNormal.h"

@implementation WebImageViewNormal

-(void)setWebImageViewWithURL:(NSURL *)url
{
    if (url==nil)
    {
        return;
    }
    NSString *strUrl=[url absoluteString];
    if(strUrl.length>0)
    {
        strUrl=[strUrl substringFromIndex:strUrl.length-8];
    }
    else
    {
        return;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl]])
    {
        NSData *myData= [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl]];
        if (myData.length>0)
        {
             self.image = [UIImage imageWithData:myData];
        }
       
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                if (imageData.length>0) {
                    self.image = [UIImage imageWithData:imageData];
                    if ([imageData writeToFile:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl] atomically:YES])
                    {
                        NSLog(@"saved");
                    }
                }
                
            });
        });
        
        //        NSData *myData= UIImageJPEGRepresentation(self.image, 1.0);
        
    }
    
    
}
-(void)setWebImageViewWithURLReturnImgFrame:(NSURL*)url;
{
    NSString *strUrl=[url absoluteString];
    strUrl=[strUrl substringFromIndex:strUrl.length-8];
    if (url==nil)
    {
        [self setImage:[UIImage imageNamed:nil]];
        return;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl]])
    {
        NSData *myData= [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl]];
        //set frame
        if (myData.length>0)
        {
            self.imageview=[[UIImageView alloc] initWithImage:[UIImage imageWithData:myData]];
            float width=Screen_Width;
            float height=self.imageview.frame.size.height*Screen_Width/self.imageview.frame.size.width;
            [self.imageview setFrame:CGRectMake(0, 50-height, width, height)];
//            if(PARENT_WIDTH(self.imageview)>Screen_Width)
//            {
//                [self.imageview setFrame:CGRectMake(0, (PARENT_HEIGHT(self)-PARENT_HEIGHT(self.imageview)*Screen_Width/PARENT_WIDTH(self.imageview))/2.0, Screen_Width, PARENT_HEIGHT(self.imageview)*Screen_Width/PARENT_WIDTH(self.imageview))];
//            }
//            if (PARENT_HEIGHT(self.imageview)>Screen_Height)
//            {
//                [self.imageview setFrame:CGRectMake((PARENT_WIDTH(self)-PARENT_WIDTH(self.imageview)*Screen_Height/PARENT_HEIGHT(self.imageview))/2.0, 0, PARENT_WIDTH(self.imageview)*Screen_Height/PARENT_HEIGHT(self.imageview), Screen_Height)];
//            }
            [self addSubview:self.imageview];
        }
        //        self.image = [UIImage imageWithData:myData];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                //set frame
                if (imageData.length>0)
                {
                    self.imageview=[[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
                    float width=Screen_Width;
                    float height=self.imageview.frame.size.height*Screen_Width/self.imageview.frame.size.width;
                    [self.imageview setFrame:CGRectMake(0, 50-height, width, height)];
//                    if(PARENT_WIDTH(self.imageview)>Screen_Width)
//                    {
//                        [self.imageview setFrame:CGRectMake(0, (PARENT_HEIGHT(self)-PARENT_HEIGHT(self.imageview)*Screen_Width/PARENT_WIDTH(self.imageview))/2.0, Screen_Width, PARENT_HEIGHT(self.imageview)*Screen_Width/PARENT_WIDTH(self.imageview))];
//                    }
//                    if (PARENT_HEIGHT(self.imageview)>Screen_Height)
//                    {
//                        [self.imageview setFrame:CGRectMake((PARENT_WIDTH(self)-PARENT_WIDTH(self.imageview)*Screen_Height/PARENT_HEIGHT(self.imageview))/2.0, 0, PARENT_WIDTH(self.imageview)*Screen_Height/PARENT_HEIGHT(self.imageview), Screen_Height)];
//                    }
                    [self addSubview:self.imageview];
                }

                //save
                if ([imageData writeToFile:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl] atomically:YES])
                {
                    NSLog(@"saved");
                }
                
            });
        });
        
        //        NSData *myData= UIImageJPEGRepresentation(self.image, 1.0);
        
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
