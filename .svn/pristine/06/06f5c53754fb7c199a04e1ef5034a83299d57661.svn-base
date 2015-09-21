//
//  BorrowSuccessVC.m
//  jinerong
//
//  Created by carcool on 6/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "BorrowSuccessVC.h"

@interface BorrowSuccessVC ()

@end

@implementation BorrowSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"提交成功";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setRightNaviBtnTitle:@"完成"];
    [self.rightNaviBtn addTarget:self action:@selector(popToRootVC) forControlEvents:UIControlEventTouchUpInside];
}
-(void)popToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
