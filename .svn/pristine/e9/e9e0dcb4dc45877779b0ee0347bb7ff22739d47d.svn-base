//
//  JERNavigationController.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERNavigationController.h"

@interface JERNavigationController ()

@end

@implementation JERNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bg= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [self.navigationBar setBackgroundImage:[self imageWithUIView:bg] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barStyle=UIBaselineAdjustmentNone;
    self.navigationBar.clipsToBounds = YES;

    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0 green:0 blue:0 alpha:1],NSForegroundColorAttributeName,nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//view to image
- (UIImage*) imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
